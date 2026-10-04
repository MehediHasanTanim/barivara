import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:barivara/app/app_config.dart';
import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/core/storage/preferences_store.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

/// A fully self-contained local backup archive and its creation metadata.
class BackupArchive {
  const BackupArchive({required this.path, required this.manifest});

  final String path;
  final BackupManifest manifest;

  String get fileName => File(path).uri.pathSegments.last;
}

/// Portable archive metadata. Hashes cover every payload file, never itself.
class BackupManifest {
  const BackupManifest({
    required this.formatVersion,
    required this.appVersion,
    required this.databaseSchemaVersion,
    required this.createdAt,
    required this.fileHashes,
    required this.platform,
    this.encrypted = false,
  });

  final int formatVersion;
  final String appVersion;
  final int databaseSchemaVersion;
  final DateTime createdAt;
  final Map<String, String> fileHashes;
  final String platform;
  final bool encrypted;

  Map<String, Object> toJson() => <String, Object>{
    'formatVersion': formatVersion,
    'appVersion': appVersion,
    'databaseSchemaVersion': databaseSchemaVersion,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'platform': platform,
    'encrypted': encrypted,
    'fileHashes': fileHashes,
  };

  factory BackupManifest.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> hashes =
        json['fileHashes']! as Map<String, dynamic>;
    return BackupManifest(
      formatVersion: json['formatVersion']! as int,
      appVersion: json['appVersion']! as String,
      databaseSchemaVersion: json['databaseSchemaVersion']! as int,
      createdAt: DateTime.parse(json['createdAt']! as String).toUtc(),
      platform: json['platform']! as String,
      encrypted: json['encrypted'] as bool? ?? false,
      fileHashes: hashes.map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value as String),
      ),
    );
  }
}

/// Last successful backup and restore times retained locally, not in exports.
class BackupHistory {
  const BackupHistory({
    this.lastBackupAt,
    this.lastRestoreAt,
    this.formatVersion,
  });

  final DateTime? lastBackupAt;
  final DateTime? lastRestoreAt;
  final int? formatVersion;
}

enum CsvExportKind { tenants, units, bills, payments, deposits, repairs }

/// A UTF-8 CSV payload intended for viewing rather than data restoration.
class CsvExport {
  const CsvExport({required this.fileName, required this.bytes});

  final String fileName;
  final Uint8List bytes;
}

/// Creates, validates, restores, and exports entirely local landlord data.
///
/// The restored database is installed only after its archive, hashes, SQLite
/// integrity, and schema compatibility have been checked. Production callers
/// close the active Drift database before replacement and restart the app.
class BackupArchiveService {
  BackupArchiveService({
    this.database,
    this.preferences,
    Future<Directory> Function()? supportDirectory,
    Future<Directory> Function()? temporaryDirectory,
    this.closeActiveDatabase,
    this.afterDatabaseReplacement,
    DateTime Function()? clock,
  }) : _supportDirectory = supportDirectory ?? getApplicationSupportDirectory,
       _temporaryDirectory = temporaryDirectory ?? getTemporaryDirectory,
       _clock = clock ?? DateTime.now;

  final AppDatabase? database;
  final PreferencesStore? preferences;
  final Future<Directory> Function() _supportDirectory;
  final Future<Directory> Function() _temporaryDirectory;
  final Future<void> Function()? closeActiveDatabase;
  final Future<void> Function()? afterDatabaseReplacement;
  final DateTime Function() _clock;

  static const String _databaseEntry = 'database.sqlite';
  static const String _manifestEntry = 'manifest.json';
  static const String _attachmentsEntry = 'attachments';
  static const String _metadataEntry = 'metadata/app.json';
  static const String _lastBackupKey = 'backup_last_success_at';
  static const String _lastRestoreKey = 'backup_last_restore_at';
  static const String _lastFormatKey = 'backup_last_format_version';

  /// Builds an archive in app-private temporary storage, ready to share/save.
  Future<Result<BackupArchive>> createBackup() async {
    Directory? staging;
    try {
      await _checkpointDatabase();
      final Directory support = await _supportDirectory();
      final File sourceDatabase = File(
        '${support.path}/${AppConfig.databaseName}',
      );
      if (!await sourceDatabase.exists()) {
        return const Result<BackupArchive>.failure(
          BackupError('No local database is available to back up.'),
        );
      }
      final DateTime createdAt = _clock().toUtc();
      final Directory temporary = await _temporaryDirectory();
      await _cleanTemporaryArtifacts(temporary);
      staging = Directory(
        '${temporary.path}/bv-backup-${createdAt.microsecondsSinceEpoch}',
      );
      await staging.create(recursive: true);

      await sourceDatabase.copy('${staging.path}/$_databaseEntry');
      final Directory attachments = Directory(
        '${support.path}/repair_attachments',
      );
      if (await attachments.exists()) {
        await _copyDirectory(
          attachments,
          Directory('${staging.path}/$_attachmentsEntry'),
        );
      } else {
        await Directory('${staging.path}/$_attachmentsEntry')
            .create(recursive: true);
      }
      final File appMetadata = File('${staging.path}/$_metadataEntry');
      await appMetadata.parent.create(recursive: true);
      await appMetadata.writeAsString(
        jsonEncode(<String, Object>{'platform': Platform.operatingSystem}),
        flush: true,
      );

      final Map<String, String> hashes = await _hashPayload(staging);
      final BackupManifest manifest = BackupManifest(
        formatVersion: AppConfig.backupFormatVersion,
        appVersion: AppConfig.applicationVersion,
        databaseSchemaVersion: AppConfig.databaseVersion,
        createdAt: createdAt,
        fileHashes: hashes,
        platform: Platform.operatingSystem,
        encrypted: false,
      );
      await File('${staging.path}/$_manifestEntry')
          .writeAsString(jsonEncode(manifest.toJson()), flush: true);

      final String fileName = 'bari_vara_${_stamp(createdAt)}.bvbackup';
      final File archive = File('${temporary.path}/$fileName');
      final ZipFileEncoder encoder = ZipFileEncoder();
      encoder.create(archive.path);
      await encoder.addDirectory(staging, includeDirName: false);
      await encoder.close();
      await _recordBackup(createdAt);
      return Result<BackupArchive>.success(
        BackupArchive(path: archive.path, manifest: manifest),
      );
    } on FileSystemException {
      return const Result<BackupArchive>.failure(
        BackupError('The backup files could not be created.'),
      );
    } on Object {
      return const Result<BackupArchive>.failure(
        BackupError('The backup could not be created.'),
      );
    } finally {
      if (staging != null && await staging.exists()) {
        await staging.delete(recursive: true);
      }
    }
  }

  /// Opens and fully validates an archive without touching the active data.
  Future<Result<BackupManifest>> validateArchive(String archivePath) async {
    Directory? extracted;
    try {
      extracted = await _extractAndValidate(archivePath);
      return Result<BackupManifest>.success(await _readManifest(extracted));
    } on _BackupValidationError catch (error) {
      return Result<BackupManifest>.failure(BackupError(error.message));
    } on Object {
      return const Result<BackupManifest>.failure(
        BackupError('The selected backup could not be read.'),
      );
    } finally {
      if (extracted != null && await extracted.exists()) {
        await extracted.delete(recursive: true);
      }
    }
  }

  /// Replaces current data only after validation. The app must restart after a
  /// successful restore because its active database connection is closed.
  Future<Result<void>> restore(String archivePath) async {
    Directory? extracted;
    Directory? safety;
    try {
      extracted = await _extractAndValidate(archivePath);
      final Directory support = await _supportDirectory();
      await support.create(recursive: true);
      safety = Directory(
        '${support.path}/.restore-safety-${_clock().microsecondsSinceEpoch}',
      );
      await safety.create(recursive: true);

      await closeActiveDatabase?.call();
      await _replaceWithSafetySnapshot(
        support: support,
        extracted: extracted,
        safety: safety,
      );
      await _recordRestore(_clock().toUtc());
      await safety.delete(recursive: true);
      safety = null;
      return const Result<void>.success(null);
    } on _BackupValidationError catch (error) {
      return Result<void>.failure(RestoreError(error.message));
    } on Object {
      if (safety != null && await safety.exists()) {
        await _rollbackSafetySnapshot(safety);
      }
      return const Result<void>.failure(
        RestoreError('Restore failed. Your previous local data was kept.'),
      );
    } finally {
      if (extracted != null && await extracted.exists()) {
        await extracted.delete(recursive: true);
      }
      if (safety != null && await safety.exists()) {
        await safety.delete(recursive: true);
      }
    }
  }

  Future<BackupHistory> history() async => BackupHistory(
    lastBackupAt: _date(preferences?.getString(_lastBackupKey)),
    lastRestoreAt: _date(preferences?.getString(_lastRestoreKey)),
    formatVersion: int.tryParse(preferences?.getString(_lastFormatKey) ?? ''),
  );

  /// Produces a portable reporting CSV with a UTF-8 BOM for Bengali text.
  Future<Result<CsvExport>> createCsv(CsvExportKind kind) async {
    if (database == null) {
      return const Result<CsvExport>.failure(
        DatabaseError('Local data is unavailable.'),
      );
    }
    try {
      final StringBuffer output = StringBuffer();
      switch (kind) {
        case CsvExportKind.tenants:
          output.writeln('Name,Bangla name,Phone,Email,Status');
          for (final row in await database!.select(database!.tenants).get()) {
            _row(output, <Object?>[
              row.fullName,
              row.banglaName,
              row.phone,
              row.email,
              row.status,
            ]);
          }
        case CsvExportKind.units:
          output.writeln('Unit,Property ID,Floor,Default rent (poisha),Status');
          for (final row in await database!.select(database!.units).get()) {
            _row(output, <Object?>[
              row.name,
              row.propertyId,
              row.floorName,
              row.defaultRentPoisha,
              row.occupancyStatus,
            ]);
          }
        case CsvExportKind.bills:
          output.writeln(
            'Billing year,Billing month,Property ID,Unit ID,Total (poisha),Paid (poisha),Balance (poisha),Status',
          );
          for (final row
              in await database!.select(database!.monthlyBills).get()) {
            _row(output, <Object?>[
              row.billingYear,
              row.billingMonth,
              row.propertyId,
              row.unitId,
              row.totalPoisha,
              row.paidPoisha,
              row.balancePoisha,
              row.status,
            ]);
          }
        case CsvExportKind.payments:
          output.writeln(
            'Payment number,Payment date,Tenant ID,Amount (poisha),Method,Status,Reference',
          );
          for (final row in await database!.select(database!.payments).get()) {
            _row(output, <Object?>[
              row.paymentNumber,
              row.paymentDate.toIso8601String(),
              row.tenantId,
              row.amountPoisha,
              row.paymentMethod,
              row.status,
              row.reference,
            ]);
          }
        case CsvExportKind.deposits:
          output.writeln(
            'Tenancy ID,Opening balance (poisha),Expected balance (poisha),Current balance (poisha),Advance rent balance (poisha)',
          );
          for (final row in await database!.select(database!.deposits).get()) {
            _row(output, <Object?>[
              row.tenancyId,
              row.openingBalancePoisha,
              row.expectedBalancePoisha,
              row.currentBalancePoisha,
              row.advanceRentBalancePoisha,
            ]);
          }
        case CsvExportKind.repairs:
          output.writeln(
            'Title,Category,Property ID,Unit ID,Reported date,Cost (poisha),Paid by,Status',
          );
          for (final row in await database!.select(database!.repairs).get()) {
            _row(output, <Object?>[
              row.title,
              row.category,
              row.propertyId,
              row.unitId,
              row.reportedDate.toIso8601String(),
              row.costPoisha,
              row.responsibility,
              row.status,
            ]);
          }
      }
      return Result<CsvExport>.success(
        CsvExport(
          fileName: 'bari-vara-${kind.name}.csv',
          bytes: Uint8List.fromList(<int>[
            0xEF,
            0xBB,
            0xBF,
            ...utf8.encode(output.toString()),
          ]),
        ),
      );
    } on Object {
      return const Result<CsvExport>.failure(
        FileSystemError('The CSV export could not be created.'),
      );
    }
  }

  Future<void> _checkpointDatabase() async {
    if (database != null) {
      await database!.customStatement('PRAGMA wal_checkpoint(FULL);');
    }
  }

  Future<Directory> _extractAndValidate(String archivePath) async {
    final File archiveFile = File(archivePath);
    if (!await archiveFile.exists()) {
      throw const _BackupValidationError(
        'The selected backup file is unavailable.',
      );
    }
    final Directory temporary = await _temporaryDirectory();
    final Directory extracted = Directory(
      '${temporary.path}/bv-restore-${_clock().microsecondsSinceEpoch}',
    );
    await extracted.create(recursive: true);
    try {
      final Archive archive = ZipDecoder().decodeBytes(
        await archiveFile.readAsBytes(),
        verify: true,
      );
      for (final ArchiveFile entry in archive.files) {
        final String name = entry.name.replaceAll('\\', '/');
        if (!_safeArchivePath(name)) {
          throw const _BackupValidationError(
            'The backup contains an unsafe file path.',
          );
        }
        if (entry.isFile) {
          final File file = File('${extracted.path}/$name');
          await file.parent.create(recursive: true);
          await file.writeAsBytes(entry.readBytes() ?? <int>[], flush: true);
        }
      }
      final BackupManifest manifest = await _readManifest(extracted);
      if (manifest.formatVersion != AppConfig.backupFormatVersion) {
        throw const _BackupValidationError(
          'This backup format is not supported by this app version.',
        );
      }
      if (manifest.databaseSchemaVersion > AppConfig.databaseVersion) {
        throw const _BackupValidationError(
          'This backup was made by a newer app version.',
        );
      }
      final File databaseFile = File('${extracted.path}/$_databaseEntry');
      if (!await databaseFile.exists()) {
        throw const _BackupValidationError(
          'The backup does not contain a database.',
        );
      }
      await _verifyHashes(extracted, manifest);
      _verifyDatabase(databaseFile, manifest);
      return extracted;
    } on Object {
      if (await extracted.exists()) {
        await extracted.delete(recursive: true);
      }
      rethrow;
    }
  }

  Future<BackupManifest> _readManifest(Directory root) async {
    final File file = File('${root.path}/$_manifestEntry');
    if (!await file.exists()) {
      throw const _BackupValidationError('The backup manifest is missing.');
    }
    try {
      return BackupManifest.fromJson(
        jsonDecode(await file.readAsString()) as Map<String, dynamic>,
      );
    } on Object {
      throw const _BackupValidationError('The backup manifest is invalid.');
    }
  }

  Future<void> _verifyHashes(Directory root, BackupManifest manifest) async {
    if (!manifest.fileHashes.containsKey(_databaseEntry)) {
      throw const _BackupValidationError(
        'The backup manifest does not verify its database.',
      );
    }
    for (final MapEntry<String, String> entry in manifest.fileHashes.entries) {
      if (!_safeArchivePath(entry.key)) {
        throw const _BackupValidationError(
          'The backup manifest contains an unsafe file path.',
        );
      }
      final File file = File('${root.path}/${entry.key}');
      if (!await file.exists() || await _hash(file) != entry.value) {
        throw const _BackupValidationError(
          'Backup integrity verification failed.',
        );
      }
    }
  }

  void _verifyDatabase(File file, BackupManifest manifest) {
    final sqlite.Database database = sqlite.sqlite3.open(
      file.path,
      mode: sqlite.OpenMode.readOnly,
    );
    try {
      final sqlite.ResultSet integrity = database.select(
        'PRAGMA integrity_check;',
      );
      if (integrity.isEmpty || integrity.first.values.first != 'ok') {
        throw const _BackupValidationError('The backup database is corrupted.');
      }
      final sqlite.ResultSet schema = database.select(
        "SELECT schema_version FROM schema_metadata WHERE id = 'current';",
      );
      if (schema.isEmpty ||
          schema.first['schema_version'] != manifest.databaseSchemaVersion) {
        throw const _BackupValidationError(
          'The backup database schema does not match its manifest.',
        );
      }
    } on _BackupValidationError {
      rethrow;
    } on Object {
      throw const _BackupValidationError('The backup database is invalid.');
    } finally {
      database.close();
    }
  }

  Future<void> _replaceWithSafetySnapshot({
    required Directory support,
    required Directory extracted,
    required Directory safety,
  }) async {
    final File currentDatabase = File(
      '${support.path}/${AppConfig.databaseName}',
    );
    final File safetyDatabase = File(
      '${safety.path}/${AppConfig.databaseName}',
    );
    final File incomingDatabase = File(
      '${support.path}/.${AppConfig.databaseName}.incoming',
    );
    await File('${extracted.path}/$_databaseEntry').copy(incomingDatabase.path);
    if (await currentDatabase.exists()) {
      await currentDatabase.rename(safetyDatabase.path);
    }
    await incomingDatabase.rename(currentDatabase.path);
    await afterDatabaseReplacement?.call();

    final Directory currentAttachments = Directory(
      '${support.path}/repair_attachments',
    );
    final Directory safetyAttachments = Directory(
      '${safety.path}/repair_attachments',
    );
    final Directory incomingAttachments = Directory(
      '${extracted.path}/$_attachmentsEntry',
    );
    if (await currentAttachments.exists()) {
      await currentAttachments.rename(safetyAttachments.path);
    }
    if (await incomingAttachments.exists()) {
      await _copyDirectory(incomingAttachments, currentAttachments);
    }
  }

  Future<void> _rollbackSafetySnapshot(Directory safety) async {
    final Directory support = await _supportDirectory();
    final File currentDatabase = File(
      '${support.path}/${AppConfig.databaseName}',
    );
    final File safetyDatabase = File(
      '${safety.path}/${AppConfig.databaseName}',
    );
    if (await currentDatabase.exists()) {
      await currentDatabase.delete();
    }
    if (await safetyDatabase.exists()) {
      await safetyDatabase.rename(currentDatabase.path);
    }
    final Directory currentAttachments = Directory(
      '${support.path}/repair_attachments',
    );
    final Directory safetyAttachments = Directory(
      '${safety.path}/repair_attachments',
    );
    if (await currentAttachments.exists()) {
      await currentAttachments.delete(recursive: true);
    }
    if (await safetyAttachments.exists()) {
      await safetyAttachments.rename(currentAttachments.path);
    }
  }

  Future<Map<String, String>> _hashPayload(Directory root) async {
    final Map<String, String> result = <String, String>{};
    await for (final FileSystemEntity entity in root.list(recursive: true)) {
      if (entity is File) {
        final String name = entity.path
            .substring(root.path.length + 1)
            .replaceAll('\\', '/');
        result[name] = await _hash(entity);
      }
    }
    return result;
  }

  Future<void> _recordBackup(DateTime at) async {
    await preferences?.setString(_lastBackupKey, at.toUtc().toIso8601String());
    await preferences?.setString(
      _lastFormatKey,
      AppConfig.backupFormatVersion.toString(),
    );
  }

  Future<void> _recordRestore(DateTime at) async {
    await preferences?.setString(_lastRestoreKey, at.toUtc().toIso8601String());
    await preferences?.setString(
      _lastFormatKey,
      AppConfig.backupFormatVersion.toString(),
    );
  }

  /// Removes stale app-created exports without touching unrelated cache files.
  Future<void> _cleanTemporaryArtifacts(Directory temporary) async {
    if (!await temporary.exists()) {
      return;
    }
    final DateTime cutoff = _clock().toUtc().subtract(const Duration(days: 7));
    await for (final FileSystemEntity entity in temporary.list()) {
      final String name = entity.uri.pathSegments.isEmpty
          ? ''
          : entity.uri.pathSegments.last;
      final bool owned =
          name.startsWith('bari_vara_') ||
          name.startsWith('bv-backup-') ||
          name.startsWith('bv-restore-');
      if (!owned) {
        continue;
      }
      try {
        if ((await entity.stat()).modified.toUtc().isBefore(cutoff)) {
          await entity.delete(recursive: entity is Directory);
        }
      } on FileSystemException {
        // Best effort: cache cleanup must not block a new backup.
      }
    }
  }

  static Future<void> _copyDirectory(
    Directory source,
    Directory destination,
  ) async {
    await destination.create(recursive: true);
    await for (final FileSystemEntity entity in source.list(recursive: true)) {
      final String relative = entity.path.substring(source.path.length + 1);
      final String destinationPath = '${destination.path}/$relative';
      if (entity is Directory) {
        await Directory(destinationPath).create(recursive: true);
      } else if (entity is File) {
        await File(destinationPath).parent.create(recursive: true);
        await entity.copy(destinationPath);
      }
    }
  }

  static Future<String> _hash(File file) async =>
      sha256.convert(await file.readAsBytes()).toString();
  static bool _safeArchivePath(String value) {
    final String normalized = value.endsWith('/')
        ? value.substring(0, value.length - 1)
        : value;
    return normalized.isNotEmpty &&
        !normalized.startsWith('/') &&
        !normalized
            .split('/')
            .any((String part) => part == '..' || part.isEmpty);
  }

  static DateTime? _date(String? value) =>
      value == null ? null : DateTime.tryParse(value)?.toUtc();
  static String _stamp(DateTime value) => value
      .toIso8601String()
      .replaceAll(RegExp(r'[^0-9]'), '')
      .substring(0, 14);
  static void _row(StringBuffer output, List<Object?> cells) => output.writeln(
    cells
        .map(
          (Object? cell) =>
              '"${(cell?.toString() ?? '').replaceAll('"', '""')}"',
        )
        .join(','),
  );
}

class _BackupValidationError implements Exception {
  const _BackupValidationError(this.message);
  final String message;
}

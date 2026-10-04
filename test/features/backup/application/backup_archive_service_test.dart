import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:barivara/app/app_config.dart';
import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/backup/application/backup_archive_service.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  late Directory root;
  late Directory source;
  late Directory target;
  late Directory temporary;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('barivara-backup-test-');
    source = Directory('${root.path}/source');
    target = Directory('${root.path}/target');
    temporary = Directory('${root.path}/temporary');
    await Future.wait(<Future<void>>[
      source.create(recursive: true),
      target.create(recursive: true),
      temporary.create(recursive: true),
    ]);
  });

  tearDown(() => root.delete(recursive: true));

  BackupArchiveService serviceFor(
    Directory support, {
    Future<void> Function()? afterDatabaseReplacement,
  }) => BackupArchiveService(
    supportDirectory: () async => support,
    temporaryDirectory: () async => temporary,
    afterDatabaseReplacement: afterDatabaseReplacement,
    clock: () => DateTime.utc(2026, 10, 4, 10, 30),
  );

  test(
    'backs up the SQLite database, Bengali attachment, and manifest hashes',
    () async {
      await _database(source, value: 'source balance');
      final File attachment = File(
        '${source.path}/repair_attachments/রসিদ.txt',
      );
      await attachment.parent.create(recursive: true);
      await attachment.writeAsString('বাংলা সংযুক্তি');

      final Result<BackupArchive> result = await serviceFor(source)
          .createBackup();

      expect(result, isA<Success<BackupArchive>>());
      final BackupArchive archive = (result as Success<BackupArchive>).value;
      expect(archive.fileName, endsWith('.bvbackup'));
      expect(archive.manifest.formatVersion, AppConfig.backupFormatVersion);
      expect(archive.manifest.fileHashes, contains('database.sqlite'));
      expect(
        archive.manifest.fileHashes.keys,
        contains('attachments/রসিদ.txt'),
      );
      expect(
        await serviceFor(source).validateArchive(archive.path),
        isA<Success<BackupManifest>>(),
      );
    },
  );

  test(
    'restores database and attachments into a clean app directory',
    () async {
      await _database(source, value: 'restored financial balance');
      final File attachment = File(
        '${source.path}/repair_attachments/invoice.pdf',
      );
      await attachment.parent.create(recursive: true);
      await attachment.writeAsString('invoice bytes');
      final BackupArchive archive =
          (await serviceFor(source).createBackup() as Success<BackupArchive>)
              .value;

      await _database(target, value: 'old balance');
      final Result<void> restore = await serviceFor(target)
          .restore(archive.path);

      expect(restore, isA<Success<void>>());
      expect(await _value(target), 'restored financial balance');
      expect(
        await File('${target.path}/repair_attachments/invoice.pdf')
            .readAsString(),
        'invoice bytes',
      );
    },
  );

  test(
    'rejects a corrupted archive before changing the active database',
    () async {
      await _database(source, value: 'source');
      final BackupArchive archive =
          (await serviceFor(source).createBackup() as Success<BackupArchive>)
              .value;
      await _database(target, value: 'keep me');
      await File(archive.path).writeAsBytes(<int>[1, 2, 3, 4], flush: true);

      final Result<void> result = await serviceFor(target)
          .restore(archive.path);

      expect(result, isA<Failure<void>>());
      expect(await _value(target), 'keep me');
    },
  );

  test('rejects an unsupported backup format', () async {
    await _database(source, value: 'source');
    final BackupArchive archive =
        (await serviceFor(source).createBackup() as Success<BackupArchive>)
            .value;
    final File broken = File('${temporary.path}/unsupported.bvbackup');
    await _copyWithUnsupportedManifest(archive.path, broken.path);

    final Result<BackupManifest> result = await serviceFor(source)
        .validateArchive(broken.path);

    expect(result, isA<Failure<BackupManifest>>());
    expect(
      (result as Failure<BackupManifest>).failure.message,
      contains('not supported'),
    );
  });

  test('rolls back the safety snapshot if replacement fails', () async {
    await _database(source, value: 'new');
    final BackupArchive archive =
        (await serviceFor(source).createBackup() as Success<BackupArchive>)
            .value;
    await _database(target, value: 'old');

    final Result<void> result = await serviceFor(
      target,
      afterDatabaseReplacement: () async =>
          throw StateError('simulated replacement failure'),
    ).restore(archive.path);

    expect(result, isA<Failure<void>>());
    expect(await _value(target), 'old');
  });

  test(
    'a fresh app database restores the same records and Bengali attachment',
    () async {
      final AppDatabase sourceDatabase = AppDatabase.forTesting(
        NativeDatabase(File('${source.path}/${AppConfig.databaseName}')),
      );
      await sourceDatabase.customSelect('SELECT 1;').get();
      await sourceDatabase.customStatement(
        "INSERT INTO properties (id, name) VALUES ('property-1', 'বাড়ি');",
      );
      final File attachment = File(
        '${source.path}/repair_attachments/চালান.txt',
      );
      await attachment.parent.create(recursive: true);
      await attachment.writeAsString('রক্ষণাবেক্ষণ চালান');
      final BackupArchiveService sourceService = BackupArchiveService(
        database: sourceDatabase,
        supportDirectory: () async => source,
        temporaryDirectory: () async => temporary,
      );
      final BackupArchive archive =
          (await sourceService.createBackup() as Success<BackupArchive>).value;
      await sourceDatabase.close();

      expect(
        await serviceFor(target).restore(archive.path),
        isA<Success<void>>(),
      );
      final AppDatabase restored = AppDatabase.forTesting(
        NativeDatabase(File('${target.path}/${AppConfig.databaseName}')),
      );
      addTearDown(restored.close);
      final int count =
          (await restored
                  .customSelect('SELECT COUNT(*) AS total FROM properties;')
                  .getSingle())
              .read<int>('total');

      expect(count, 1);
      expect(
        await File('${target.path}/repair_attachments/চালান.txt')
            .readAsString(),
        'রক্ষণাবেক্ষণ চালান',
      );
    },
  );
}

Future<void> _database(Directory directory, {required String value}) async {
  final sqlite.Database database = sqlite.sqlite3.open(
    '${directory.path}/${AppConfig.databaseName}',
  );
  try {
    database.execute(
      'CREATE TABLE schema_metadata (id TEXT PRIMARY KEY, schema_version INTEGER NOT NULL);',
    );
    database.execute(
      "INSERT INTO schema_metadata (id, schema_version) VALUES ('current', ${AppConfig.databaseVersion});",
    );
    database.execute('CREATE TABLE financial_snapshot (value TEXT NOT NULL);');
    database.execute(
      'INSERT INTO financial_snapshot (value) VALUES (?)',
      <Object?>[value],
    );
  } finally {
    database.close();
  }
}

Future<String> _value(Directory directory) async {
  final sqlite.Database database = sqlite.sqlite3.open(
    '${directory.path}/${AppConfig.databaseName}',
    mode: sqlite.OpenMode.readOnly,
  );
  try {
    return database
            .select('SELECT value FROM financial_snapshot;')
            .single['value']!
        as String;
  } finally {
    database.close();
  }
}

Future<void> _copyWithUnsupportedManifest(
  String source,
  String destination,
) async {
  final Directory stage = await Directory.systemTemp.createTemp(
    'barivara-unsupported-',
  );
  try {
    final Archive archive = ZipDecoder().decodeBytes(
      await File(source).readAsBytes(),
    );
    for (final ArchiveFile entry in archive.files) {
      if (entry.isFile) {
        final File file = File('${stage.path}/${entry.name}');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(entry.readBytes() ?? <int>[]);
      }
    }
    final File manifest = File('${stage.path}/manifest.json');
    final Map<String, dynamic> contents =
        jsonDecode(await manifest.readAsString()) as Map<String, dynamic>;
    contents['formatVersion'] = 999;
    await manifest.writeAsString(jsonEncode(contents));
    final ZipFileEncoder encoder = ZipFileEncoder();
    encoder.create(destination);
    await encoder.addDirectory(stage, includeDirName: false);
    await encoder.close();
  } finally {
    await stage.delete(recursive: true);
  }
}

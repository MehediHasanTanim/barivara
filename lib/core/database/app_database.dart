import 'dart:io';

import 'package:barivara/app/app_config.dart';
import 'package:barivara/core/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

part 'app_database.g.dart';

/// Observes schema transitions without coupling migrations to presentation.
abstract interface class DatabaseMigrationObserver {
  /// Runs immediately before a schema transition.
  Future<void> beforeMigration({required int from, required int to});

  /// Runs after a successful schema transition.
  Future<void> afterMigration({required int from, required int to});

  /// Records a schema transition failure for diagnostics where possible.
  Future<void> onMigrationFailure(
    Object error,
    StackTrace stackTrace, {
    required int from,
    required int to,
  });
}

/// No-op migration observer used in production until backup integration exists.
class NoopDatabaseMigrationObserver implements DatabaseMigrationObserver {
  /// Creates the no-op observer.
  const NoopDatabaseMigrationObserver();

  @override
  Future<void> afterMigration({required int from, required int to}) async {}

  @override
  Future<void> beforeMigration({required int from, required int to}) async {}

  @override
  Future<void> onMigrationFailure(
    Object error,
    StackTrace stackTrace, {
    required int from,
    required int to,
  }) async {}
}

/// Bari Vara's local SQLite source of truth.
@DriftDatabase(
  tables: <Type>[
    Properties,
    Units,
    Tenants,
    Tenancies,
    RecurringChargeRules,
    UtilityMeterConfigs,
    MonthlyBills,
    BillLineItems,
    Payments,
    PaymentAllocations,
    Deposits,
    DepositTransactions,
    Repairs,
    RepairAttachments,
    AppSettings,
    AuditEvents,
    SchemaMetadata,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Opens the production app-private database.
  AppDatabase({DatabaseMigrationObserver? migrationObserver})
    : _migrationObserver =
          migrationObserver ?? const NoopDatabaseMigrationObserver(),
      super(_openConnection());

  /// Uses a supplied executor for deterministic repository and migration tests.
  // `executor` cannot be a super parameter because this constructor also
  // initializes the migration observer before forwarding the executor.
  // ignore: use_super_parameters
  AppDatabase.forTesting(
    QueryExecutor executor, {
    DatabaseMigrationObserver? migrationObserver,
  }) : _migrationObserver =
           migrationObserver ?? const NoopDatabaseMigrationObserver(),
       super(executor);

  final DatabaseMigrationObserver _migrationObserver;

  @override
  int get schemaVersion => AppConfig.databaseVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator migrator) async {
        await _runMigration(
          from: 0,
          to: schemaVersion,
          action: migrator.createAll,
        );
      },
      onUpgrade: (Migrator migrator, int from, int to) async {
        await _runMigration(
          from: from,
          to: to,
          action: () async {
            // Add explicit, tested transitions here as schemaVersion advances.
            throw StateError('No migration is registered from v$from to v$to.');
          },
        );
      },
      beforeOpen: (OpeningDetails details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
        await into(schemaMetadata).insertOnConflictUpdate(
          SchemaMetadataCompanion.insert(
            id: 'current',
            schemaVersion: schemaVersion,
            lastMigrationAt: DateTime.now().toUtc(),
          ),
        );
      },
    );
  }

  Future<void> _runMigration({
    required int from,
    required int to,
    required Future<void> Function() action,
  }) async {
    try {
      await _migrationObserver.beforeMigration(from: from, to: to);
      await action();
      await _migrationObserver.afterMigration(from: from, to: to);
    } on Object catch (error, stackTrace) {
      await _migrationObserver.onMigrationFailure(
        error,
        stackTrace,
        from: from,
        to: to,
      );
      rethrow;
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory directory = await getApplicationSupportDirectory();
    final File file = File('${directory.path}/${AppConfig.databaseName}');
    return NativeDatabase.createInBackground(
      file,
      setup: (sqlite.Database database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}

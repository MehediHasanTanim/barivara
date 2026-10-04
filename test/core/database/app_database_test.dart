import 'dart:io';

import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/database/database_health_check.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart' as domain;
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../support/fixtures.dart';

void main() {
  // This suite deliberately opens the same file sequentially to verify
  // persistence. Each instance is closed before the next one is opened.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await database.close();
    });

    test('enables foreign keys and records schema metadata', () async {
      final DatabaseHealthResult health = await DatabaseHealthCheck(database)
          .run();

      expect(health.isHealthy, isTrue);
      expect(health.schemaVersion, 8);
    });

    test('prevents an orphan unit through the SQLite foreign key', () async {
      await expectLater(
        database
            .into(database.units)
            .insert(
              UnitsCompanion.insert(
                id: 'orphan-unit',
                propertyId: 'missing-property',
                name: 'A-1',
              ),
            ),
        throwsA(isA<Object>()),
      );
    });

    test('persists repository records across a database restart', () async {
      final Directory directory = await Directory.systemTemp.createTemp(
        'barivara_db_test_',
      );
      final File file = File('${directory.path}/barivara.sqlite');
      final DateTime now = DateTime.utc(2026, 10, 1);
      final domain.Property property = domain.Property(
        id: EntityId('property-restart'),
        name: 'Rahman Villa',
        createdAt: now,
        updatedAt: now,
      );

      final AppDatabase first = AppDatabase.forTesting(NativeDatabase(file));
      final DriftPropertyRepository firstRepository = DriftPropertyRepository(
        first,
      );
      await firstRepository.save(property);
      await first.close();

      final AppDatabase second = AppDatabase.forTesting(NativeDatabase(file));
      final Result<domain.Property?> result = await DriftPropertyRepository(
        second,
      ).findById(property.id);
      await second.close();
      await directory.delete(recursive: true);

      expect(result, isA<Success<domain.Property?>>());
      expect((result as Success<domain.Property?>).value?.name, 'Rahman Villa');
    });

    test('maps and archives a property without deleting its history', () async {
      final DriftPropertyRepository repository = DriftPropertyRepository(
        database,
      );
      final domain.Property property = Fixtures.property();

      expect(await repository.save(property), isA<Success<void>>());
      expect(await repository.list(), isA<Success<List<domain.Property>>>());

      await repository.archive(property.id);
      final Result<List<domain.Property>> result = await repository.list();

      expect((result as Success<List<domain.Property>>).value, isEmpty);
    });

    test('reports schema creation through the migration observer', () async {
      final _RecordingMigrationObserver observer =
          _RecordingMigrationObserver();
      final AppDatabase observed = AppDatabase.forTesting(
        NativeDatabase.memory(),
        migrationObserver: observer,
      );
      addTearDown(observed.close);

      await DatabaseHealthCheck(observed).run();

      expect(observer.events, <String>['before:0->8', 'after:0->8']);
    });

    test(
      'upgrades a v7 repairs table and preserves its historical row',
      () async {
        final Directory directory = await Directory.systemTemp.createTemp(
          'barivara_v7_migration_',
        );
        addTearDown(() => directory.delete(recursive: true));
        final File file = File('${directory.path}/barivara.sqlite');
        final AppDatabase current = AppDatabase.forTesting(
          NativeDatabase(file),
        );
        await current.customStatement(
          "INSERT INTO properties (id, name) VALUES ('property-1', 'পুরোনো বাড়ি');",
        );
        await current.customStatement('''
        INSERT INTO repairs (
          id, property_id, category, title, reported_date, cost_poisha,
          responsibility, status, created_at, updated_at
        ) VALUES (
          'repair-1', 'property-1', 'plumbing', 'Old pipe', 0, 50000,
          'landlord', 'open', 0, 0
        );
      ''');
        await current.close();

        final sqlite.Database legacy = sqlite.sqlite3.open(file.path);
        try {
          legacy.execute('PRAGMA foreign_keys = OFF;');
          legacy.execute('''
          CREATE TABLE repairs_legacy (
            id TEXT NOT NULL PRIMARY KEY,
            property_id TEXT NOT NULL REFERENCES properties (id),
            unit_id TEXT NULL REFERENCES units (id),
            tenancy_id TEXT NULL REFERENCES tenancies (id),
            category TEXT NOT NULL,
            title TEXT NOT NULL,
            description TEXT NULL,
            reported_date INTEGER NOT NULL,
            completed_date INTEGER NULL,
            cost_poisha INTEGER NOT NULL DEFAULT 0,
            responsibility TEXT NOT NULL,
            status TEXT NOT NULL DEFAULT 'open',
            notes TEXT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          );
        ''');
          legacy.execute('''
          INSERT INTO repairs_legacy (
            id, property_id, unit_id, tenancy_id, category, title,
            description, reported_date, completed_date, cost_poisha,
            responsibility, status, notes, created_at, updated_at
          ) SELECT
            id, property_id, unit_id, tenancy_id, category, title,
            description, reported_date, completed_date, cost_poisha,
            responsibility, status, notes, created_at, updated_at
          FROM repairs;
        ''');
          legacy.execute('DROP TABLE repairs;');
          legacy.execute('ALTER TABLE repairs_legacy RENAME TO repairs;');
          legacy.execute(
            'CREATE INDEX repairs_property_id_idx ON repairs (property_id);',
          );
          legacy.execute(
            'CREATE INDEX repairs_unit_id_idx ON repairs (unit_id);',
          );
          legacy.execute('PRAGMA user_version = 7;');
        } finally {
          legacy.close();
        }

        final AppDatabase upgraded = AppDatabase.forTesting(
          NativeDatabase(file),
        );
        addTearDown(upgraded.close);
        final List<String> columns =
            (await upgraded.customSelect('PRAGMA table_info(repairs);').get())
                .map((row) => row.read<String>('name'))
                .toList();
        final String title =
            (await upgraded
                    .customSelect(
                      "SELECT title FROM repairs WHERE id = 'repair-1';",
                    )
                    .getSingle())
                .read<String>('title');

        expect(
          columns,
          containsAll(<String>[
            'estimated_cost_poisha',
            'recoverable_from_tenant',
            'tenant_charge_bill_id',
          ]),
        );
        expect(title, 'Old pipe');
        expect(
          (await upgraded.customSelect('PRAGMA user_version;').getSingle())
              .read<int>('user_version'),
          8,
        );
      },
    );
  });
}

class _RecordingMigrationObserver implements DatabaseMigrationObserver {
  final List<String> events = <String>[];

  @override
  Future<void> afterMigration({required int from, required int to}) async {
    events.add('after:$from->$to');
  }

  @override
  Future<void> beforeMigration({required int from, required int to}) async {
    events.add('before:$from->$to');
  }

  @override
  Future<void> onMigrationFailure(
    Object error,
    StackTrace stackTrace, {
    required int from,
    required int to,
  }) async {
    events.add('failed:$from->$to');
  }
}

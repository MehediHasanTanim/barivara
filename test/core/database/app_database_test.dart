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
      expect(health.schemaVersion, 4);
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
  });
}

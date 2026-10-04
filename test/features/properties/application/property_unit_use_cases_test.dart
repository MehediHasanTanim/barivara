import 'package:barivara/core/database/app_database.dart' hide Property, Tenant;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/database/tables.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late PropertyUseCases properties;
  late UnitUseCases units;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    properties = PropertyUseCases(DriftPropertyRepository(database));
    units = UnitUseCases(DriftUnitRepository(database));
  });

  tearDown(() => database.close());

  test(
    'creates, updates, lists, and archives a property without units',
    () async {
      final Result<Property> created = await properties.create(
        const PropertyInput(
          name: 'Rahman Villa',
          addressLine: '12 Mirpur Road',
        ),
      );
      final Property property = (created as Success<Property>).value;

      expect(
        (await properties.list() as Success<List<PropertySummary>>).value,
        hasLength(1),
      );
      expect(
        (await properties.get(
          property.id,
        ) as Success<Property?>).value?.addressLine,
        '12 Mirpur Road',
      );

      final Result<Property> updated = await properties.update(
        property,
        const PropertyInput(name: 'Rahman Villa', area: 'Mirpur'),
      );
      expect((updated as Success<Property>).value.area, 'Mirpur');
      expect(await properties.archive(property.id), isA<Success<void>>());
      expect(
        (await properties.list() as Success<List<PropertySummary>>).value,
        isEmpty,
      );
    },
  );

  test('warns on duplicate property names until the user confirms', () async {
    await properties.create(const PropertyInput(name: 'Rahman Villa'));

    expect(
      await properties.create(const PropertyInput(name: 'Rahman Villa')),
      isA<Failure<Property>>(),
    );
    expect(
      await properties.create(
        const PropertyInput(name: 'Rahman Villa', area: 'Uttara'),
        allowDuplicateName: true,
      ),
      isA<Success<Property>>(),
    );
  });

  test(
    'keeps units separated by property and derives occupancy from tenancy',
    () async {
      final Property first = (await properties.create(
        const PropertyInput(name: 'Rahman Villa'),
      ) as Success<Property>).value;
      final Property second = (await properties.create(
        const PropertyInput(name: 'Green View House'),
      ) as Success<Property>).value;
      final RentalUnit firstUnit = (await units.create(
        first.id,
        UnitInput(name: 'A-1', defaultRent: Money.fromTaka(15000)),
      ) as Success<RentalUnit>).value;
      await units.create(
        second.id,
        UnitInput(name: 'A-1', defaultRent: Money.fromTaka(12000)),
      );

      final Tenant tenant = Tenant(
        id: EntityId('tenant-1'),
        fullName: 'Rahim Uddin',
        phone: PhoneNumber('01712000000'),
        createdAt: DateTime.utc(2026, 10, 4),
        updatedAt: DateTime.utc(2026, 10, 4),
      );
      await DriftTenantRepository(database).save(tenant);
      await database
          .into(database.tenancies)
          .insert(
            TenanciesCompanion.insert(
              id: 'tenancy-1',
              tenantId: tenant.id.value,
              unitId: firstUnit.id.value,
              moveInDate: DateTime.utc(2026, 10, 1),
              status: const Value<String>('active'),
            ),
          );

      final List<UnitSummary> firstUnits = (await units.listByProperty(
        first.id,
      ) as Success<List<UnitSummary>>).value;
      final List<UnitSummary> secondUnits = (await units.listByProperty(
        second.id,
      ) as Success<List<UnitSummary>>).value;
      expect(firstUnits, hasLength(1));
      expect(firstUnits.single.availability, UnitAvailability.occupied);
      expect(firstUnits.single.activeTenantName, 'Rahim Uddin');
      expect(secondUnits, hasLength(1));
      expect(secondUnits.single.availability, UnitAvailability.vacant);
    },
  );

  test('prevents archive while occupied, then shows archived units only in archive filter', () async {
    final Property property = (await properties.create(
      const PropertyInput(name: 'Lake Point'),
    ) as Success<Property>).value;
    final RentalUnit unit = (await units.create(
      property.id,
      UnitInput(name: 'B-2', defaultRent: Money.fromTaka(12000)),
    ) as Success<RentalUnit>).value;
    final Tenant tenant = Tenant(
      id: EntityId('tenant-2'),
      fullName: 'Salma Akter',
      phone: PhoneNumber('01713000000'),
      createdAt: DateTime.utc(2026, 10, 4),
      updatedAt: DateTime.utc(2026, 10, 4),
    );
    await DriftTenantRepository(database).save(tenant);
    await database
        .into(database.tenancies)
        .insert(
          TenanciesCompanion.insert(
            id: 'tenancy-2',
            tenantId: tenant.id.value,
            unitId: unit.id.value,
            moveInDate: DateTime.utc(2026, 9, 1),
            status: const Value<String>('active'),
          ),
        );
    expect(await units.archive(unit.id), isA<Failure<void>>());

    await (database.update(database.tenancies)
          ..where((Tenancies table) => table.id.equals('tenancy-2')))
        .write(const TenanciesCompanion(status: Value<String>('moved_out')));
    expect(await units.archive(unit.id), isA<Success<void>>());
    expect(
      (await units.listByProperty(
        property.id,
      ) as Success<List<UnitSummary>>).value,
      isEmpty,
    );
    expect(
      (await units.listByProperty(
        property.id,
        filter: UnitFilter.archived,
      ) as Success<List<UnitSummary>>).value,
      hasLength(1),
    );
    expect(await properties.archive(property.id), isA<Success<void>>());
  });
}

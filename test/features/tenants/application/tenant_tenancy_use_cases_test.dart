import 'package:barivara/core/database/app_database.dart'
    hide Property, Tenant, Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late PropertyUseCases properties;
  late UnitUseCases units;
  late TenantUseCases tenants;
  late TenancyUseCases tenancies;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    properties = PropertyUseCases(DriftPropertyRepository(database));
    units = UnitUseCases(DriftUnitRepository(database));
    tenants = TenantUseCases(DriftTenantRepository(database));
    tenancies = TenancyUseCases(DriftTenancyRepository(database));
  });

  tearDown(() => database.close());

  test('prevents overlapping active tenancies for the same unit', () async {
    final RentalUnit unit = await _createUnit(properties, units);
    final Tenant first = (await tenants.create(
      const TenantInput(fullName: 'Rahim Uddin', phone: '01712000000'),
    ) as Success<Tenant>).value;
    final Tenant second = (await tenants.create(
      const TenantInput(fullName: 'Salma Akter', phone: '01713000000'),
    ) as Success<Tenant>).value;
    expect(
      await tenancies.create(
        TenancyInput(
          tenantId: first.id,
          unitId: unit.id,
          moveInDate: DateTime.utc(2026, 10, 1),
          agreedRent: Money.fromTaka(15000),
          billingDay: 5,
        ),
      ),
      isA<Success<Tenancy>>(),
    );
    expect(
      await tenancies.create(
        TenancyInput(
          tenantId: second.id,
          unitId: unit.id,
          moveInDate: DateTime.utc(2026, 10, 2),
          agreedRent: Money.fromTaka(15000),
          billingDay: 5,
        ),
      ),
      isA<Failure<Tenancy>>(),
    );
  });

  test(
    'moves out, stops the active state, and preserves tenancy history',
    () async {
      final RentalUnit unit = await _createUnit(properties, units);
      final Tenant tenant = (await tenants.create(
        const TenantInput(
          fullName: 'Rahim Uddin',
          phone: '01712000000',
          permanentAddress: 'Rangpur',
        ),
      ) as Success<Tenant>).value;
      final Tenancy tenancy = (await tenancies.create(
        TenancyInput(
          tenantId: tenant.id,
          unitId: unit.id,
          moveInDate: DateTime.utc(2026, 1, 1),
          agreedRent: Money.fromTaka(15000),
          billingDay: 5,
          securityDepositTarget: Money.fromTaka(30000),
        ),
      ) as Success<Tenancy>).value;

      expect(
        await tenancies.moveOut(tenancy, DateTime.utc(2026, 10, 1)),
        isA<Success<void>>(),
      );
      expect(
        await DriftTenancyRepository(database).findActiveByUnit(unit.id),
        isA<Success<Tenancy?>>(),
      );
      expect(
        (await tenancies.historyForTenant(
          tenant.id,
        ) as Success<List<Tenancy>>).value.single.status,
        TenancyStatus.movedOut,
      );
      expect(await tenants.archive(tenant.id), isA<Success<void>>());
      expect(
        (await tenancies.historyForTenant(
          tenant.id,
        ) as Success<List<Tenancy>>).value,
        hasLength(1),
      );
    },
  );

  test('searches a tenant by current unit and property locally', () async {
    final RentalUnit unit = await _createUnit(properties, units);
    final Tenant tenant = (await tenants.create(
      const TenantInput(fullName: 'Karim Mia', phone: '01714000000'),
    ) as Success<Tenant>).value;
    await tenancies.create(
      TenancyInput(
        tenantId: tenant.id,
        unitId: unit.id,
        moveInDate: DateTime.utc(2026, 10, 1),
        agreedRent: Money.fromTaka(16000),
        billingDay: 5,
      ),
    );

    expect(
      (await tenants.search('A-1') as Success<List<TenantSummary>>).value,
      hasLength(1),
    );
    expect(
      (await tenants.search(
        'Rahman Villa',
      ) as Success<List<TenantSummary>>).value.single.tenant.fullName,
      'Karim Mia',
    );
  });
}

Future<RentalUnit> _createUnit(
  PropertyUseCases properties,
  UnitUseCases units,
) async {
  final Property property = (await properties.create(
    const PropertyInput(name: 'Rahman Villa'),
  ) as Success<Property>).value;
  return (await units.create(
    property.id,
    UnitInput(name: 'A-1', defaultRent: Money.fromTaka(15000)),
  ) as Success<RentalUnit>).value;
}

import 'package:barivara/core/database/app_database.dart'
    hide Property, RecurringChargeRule, Tenant, Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/charges/application/charge_configuration_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'selects the correct effective rule without altering historical rules',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
      final EntityId tenancyId = await _tenancy(database);
      final ChargeConfigurationUseCases charges = ChargeConfigurationUseCases(
        DriftChargeConfigurationRepository(database),
      );

      await charges.configureRule(
        tenancyId: tenancyId,
        type: ChargeType.rent,
        method: ChargeCalculationMethod.fixed,
        fixedAmount: Money.fromTaka(15000),
        effectiveFrom: BillingMonth(2026, 1),
      );
      await charges.configureRule(
        tenancyId: tenancyId,
        type: ChargeType.rent,
        method: ChargeCalculationMethod.fixed,
        fixedAmount: Money.fromTaka(16000),
        effectiveFrom: BillingMonth(2027, 1),
      );

      final RecurringChargeRule? december = (await charges.ruleForMonth(
        tenancyId,
        ChargeType.rent,
        BillingMonth(2026, 12),
      ) as Success<RecurringChargeRule?>).value;
      final RecurringChargeRule? january = (await charges.ruleForMonth(
        tenancyId,
        ChargeType.rent,
        BillingMonth(2027, 1),
      ) as Success<RecurringChargeRule?>).value;
      expect(december?.fixedAmount, Money.fromTaka(15000));
      expect(january?.fixedAmount, Money.fromTaka(16000));
    },
  );

  test('calculates meters exactly and rejects negative consumption', () {
    final Result<MeterChargeCalculation> calculated =
        UtilityChargeCalculator.electricity(
          previous: MeterReading(100),
          current: MeterReading(150),
          ratePerUnit: Money.fromPoisha(1250),
          fixedFee: Money.fromTaka(50),
        );
    expect(calculated, isA<Success<MeterChargeCalculation>>());
    final MeterChargeCalculation meterResult =
        (calculated as Success<MeterChargeCalculation>).value;
    expect(meterResult.consumption, 50);
    expect(meterResult.amount, Money.fromPoisha(67500));
    expect(
      UtilityChargeCalculator.electricity(
        previous: MeterReading(150),
        current: MeterReading(100),
        ratePerUnit: Money.fromPoisha(100),
      ),
      isA<Failure<MeterChargeCalculation>>(),
    );
  });
}

Future<EntityId> _tenancy(AppDatabase database) async {
  final Property property =
      (await PropertyUseCases(DriftPropertyRepository(database)).create(
        const PropertyInput(name: 'Rahman Villa'),
      ) as Success<Property>).value;
  final RentalUnit unit =
      (await UnitUseCases(DriftUnitRepository(database)).create(
        property.id,
        UnitInput(name: 'A-1', defaultRent: Money.fromTaka(15000)),
      ) as Success<RentalUnit>).value;
  final Tenant tenant =
      (await TenantUseCases(DriftTenantRepository(database)).create(
        const TenantInput(fullName: 'Rahim Uddin', phone: '01712000000'),
      ) as Success<Tenant>).value;
  return (await TenancyUseCases(DriftTenancyRepository(database)).create(
    TenancyInput(
      tenantId: tenant.id,
      unitId: unit.id,
      moveInDate: DateTime.utc(2026, 1, 1),
      agreedRent: Money.fromTaka(15000),
      billingDay: 5,
    ),
  ) as Success<Tenancy>).value.id;
}

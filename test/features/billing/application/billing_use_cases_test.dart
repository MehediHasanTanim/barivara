import 'package:barivara/core/database/app_database.dart'
    hide MonthlyBill, Property, RecurringChargeRule, Tenant, Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/charges/application/charge_configuration_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'prevents duplicate generation and retains snapshotted draft lines',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
      final Tenancy tenancy = await _tenancy(database);
      final BillingUseCases bills = _billing(database);

      final Result<BillDraft> first = await bills.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 10),
        issueDate: DateTime.utc(2026, 10, 1),
      );
      final BillDraft draft = (first as Success<BillDraft>).value;
      expect(draft.items.single.amount, Money.fromTaka(15000));
      expect(
        await bills.generateDraft(
          tenancy: tenancy,
          period: BillingMonth(2026, 10),
        ),
        isA<Failure<BillDraft>>(),
      );

      final ChargeConfigurationUseCases charges = ChargeConfigurationUseCases(
        DriftChargeConfigurationRepository(database),
      );
      await charges.configureRule(
        tenancyId: tenancy.id,
        type: ChargeType.gas,
        method: ChargeCalculationMethod.fixed,
        fixedAmount: Money.fromTaka(1080),
        effectiveFrom: BillingMonth(2026, 11),
      );
      final BillDraft persisted = (await DriftBillingRepository(
        database,
      ).findDraft(draft.bill.id) as Success<BillDraft?>).value!;
      expect(persisted.items, hasLength(1));
      expect(persisted.bill.total, Money.fromTaka(15000));
    },
  );

  test(
    'carries only the latest finalized balance and ignores cancelled bills',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
      final Tenancy tenancy = await _tenancy(database);
      final BillingUseCases bills = _billing(database);

      final BillDraft october = (await bills.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 10),
        issueDate: DateTime.utc(2026, 10, 1),
      ) as Success<BillDraft>).value;
      await bills.finalize(october.bill.id);
      final BillDraft november = (await bills.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 11),
        issueDate: DateTime.utc(2026, 11, 1),
      ) as Success<BillDraft>).value;
      expect(november.bill.openingDue, Money.fromTaka(15000));
      await bills.cancel(november.bill.id);
      final Result<Money> due = await DriftBillingRepository(database)
          .openingDue(tenancy.id, BillingMonth(2026, 12));
      expect((due as Success<Money>).value, Money.fromTaka(15000));
    },
  );
}

BillingUseCases _billing(AppDatabase database) => BillingUseCases(
  DriftBillingRepository(database),
  DriftChargeConfigurationRepository(database),
  DriftUnitRepository(database),
);

Future<Tenancy> _tenancy(AppDatabase database) async {
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
      moveInDate: DateTime.utc(2026, 10, 1),
      agreedRent: Money.fromTaka(15000),
      billingDay: 5,
    ),
  ) as Success<Tenancy>).value;
}

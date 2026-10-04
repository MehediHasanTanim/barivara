import 'package:barivara/core/database/app_database.dart'
    hide MonthlyBill, Payment, Property, Tenant, Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/deposits/application/deposit_settlement.dart';
import 'package:barivara/features/payments/application/payment_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// End-to-end, database-backed regression coverage for the critical local
/// collection journey.  Platform sharing/printing is deliberately excluded:
/// all financial transitions must be deterministic without a device service.
void main() {
  test(
    'monthly collection, due carry-forward, receipt, and move-out',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
      final DriftPropertyRepository properties = DriftPropertyRepository(
        database,
      );
      final DriftUnitRepository units = DriftUnitRepository(database);
      final DriftTenancyRepository tenancies = DriftTenancyRepository(database);
      final Property property = (await PropertyUseCases(properties).create(
        const PropertyInput(name: 'রহমান ভিলা / Rahman Villa'),
      ) as Success<Property>).value;
      final RentalUnit unit = (await UnitUseCases(units).create(
        property.id,
        UnitInput(name: 'A-1', defaultRent: Money.fromTaka(15000)),
      ) as Success<RentalUnit>).value;
      final Tenant tenant =
          (await TenantUseCases(DriftTenantRepository(database)).create(
            const TenantInput(fullName: 'আব্দুল করিম', phone: '01712000000'),
          ) as Success<Tenant>).value;
      final Tenancy tenancy = (await TenancyUseCases(tenancies).create(
        TenancyInput(
          tenantId: tenant.id,
          unitId: unit.id,
          moveInDate: DateTime.utc(2026, 10, 1),
          agreedRent: Money.fromTaka(15000),
          billingDay: 5,
          securityDepositTarget: Money.fromTaka(10000),
        ),
      ) as Success<Tenancy>).value;
      final BillingUseCases billing = BillingUseCases(
        DriftBillingRepository(database),
        DriftChargeConfigurationRepository(database),
        units,
      );
      final PaymentUseCases payments = PaymentUseCases(
        DriftPaymentRepository(database),
        DriftBillingRepository(database),
      );

      final BillDraft october = (await billing.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 10),
        issueDate: DateTime.utc(2026, 10, 1),
      ) as Success<BillDraft>).value;
      await billing.finalize(october.bill.id);
      final PaymentPosting partial = (await payments.record(
        tenancy: tenancy,
        input: PaymentInput(
          amount: Money.fromTaka(6000),
          paymentDate: DateTime.utc(2026, 10, 5),
          method: PaymentMethod.bkash,
        ),
      ) as Success<PaymentPosting>).value;
      final ReceiptSnapshot receipt = (await DriftReceiptRepository(
        database,
      ).createForPayment(partial.payment.id) as Success<ReceiptSnapshot>).value;

      expect(receipt.tenantName, 'আব্দুল করিম');
      expect(receipt.paymentAmount, Money.fromTaka(6000));
      expect(receipt.remainingDue, Money.fromTaka(9000));

      final BillDraft november = (await billing.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 11),
        issueDate: DateTime.utc(2026, 11, 1),
      ) as Success<BillDraft>).value;
      expect(november.bill.openingDue, Money.fromTaka(9000));
      await billing.finalize(november.bill.id);
      final PaymentPosting settlement = (await payments.record(
        tenancy: tenancy,
        input: PaymentInput(
          amount: Money.fromTaka(24000),
          paymentDate: DateTime.utc(2026, 11, 5),
          method: PaymentMethod.cash,
        ),
      ) as Success<PaymentPosting>).value;

      expect(settlement.allocations, hasLength(2));
      expect(settlement.allocations.first.amount, Money.fromTaka(9000));
      expect(settlement.allocations.last.amount, Money.fromTaka(15000));
      final MoveOutSettlement moveOut = DepositSettlement.calculate(
        outstanding: Money.zero,
        repairCharges: Money.fromTaka(3000),
        credits: Money.zero,
        depositBalance: Money.fromTaka(10000),
      );
      expect(moveOut.depositApplied, Money.fromTaka(3000));
      expect(moveOut.finalPayable, Money.zero);

      expect(
        await TenancyUseCases(tenancies)
            .moveOut(tenancy, DateTime.utc(2026, 11, 30)),
        isA<Success<void>>(),
      );
      expect(
        (await tenancies.findActiveByUnit(unit.id) as Success<Tenancy?>).value,
        isNull,
      );
      expect(
        (await tenancies.listByTenant(
          tenant.id,
        ) as Success<List<Tenancy>>).value.single.status,
        TenancyStatus.movedOut,
      );
    },
  );
}

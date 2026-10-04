import 'package:barivara/core/database/app_database.dart'
    hide
        MonthlyBill,
        Payment,
        PaymentAllocation,
        Property,
        RecurringChargeRule,
        Repair,
        Tenant,
        Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/payments/application/payment_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/reports/application/dashboard_query_service.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'calculates dashboard and report totals from the financial dataset',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
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
      final Tenancy tenancy =
          (await TenancyUseCases(DriftTenancyRepository(database)).create(
            TenancyInput(
              tenantId: tenant.id,
              unitId: unit.id,
              moveInDate: DateTime.utc(2026, 10, 1),
              agreedRent: Money.fromTaka(15000),
              billingDay: 5,
            ),
          ) as Success<Tenancy>).value;
      final BillingUseCases billing = BillingUseCases(
        DriftBillingRepository(database),
        DriftChargeConfigurationRepository(database),
        DriftUnitRepository(database),
      );
      final BillDraft draft = (await billing.generateDraft(
        tenancy: tenancy,
        period: BillingMonth(2026, 10),
        issueDate: DateTime.utc(2026, 10, 1),
      ) as Success<BillDraft>).value;
      await billing.finalize(draft.bill.id);
      await PaymentUseCases(
        DriftPaymentRepository(database),
        DriftBillingRepository(database),
      ).record(
        tenancy: tenancy,
        input: PaymentInput(
          amount: Money.fromTaka(10000),
          paymentDate: DateTime.utc(2026, 10, 5),
          method: PaymentMethod.bkash,
        ),
      );
      await DriftRepairRepository(database).save(
        Repair(
          id: EntityId('repair-1'),
          propertyId: property.id,
          title: 'Pipe repair',
          reportedDate: DateTime.utc(2026, 10, 8),
          cost: Money.fromTaka(500),
        ),
      );

      final DashboardQueryService reports = DashboardQueryService(database);
      final DashboardData dashboard = (await reports.dashboard(
        month: BillingMonth(2026, 10),
      ) as Success<DashboardData>).value;
      expect(dashboard.activeProperties, 1);
      expect(dashboard.totalUnits, 1);
      expect(dashboard.occupiedUnits, 1);
      expect(dashboard.vacantUnits, 0);
      expect(dashboard.expected, Money.fromTaka(15000));
      expect(dashboard.collected, Money.fromTaka(10000));
      expect(dashboard.currentOutstanding, Money.fromTaka(5000));
      expect(dashboard.overdue, Money.zero);
      expect(dashboard.recentPayments.single.method, PaymentMethod.bkash);

      final TenantDueReportRow due =
          (await reports.tenantDues() as Success<List<TenantDueReportRow>>)
              .value
              .single;
      expect(due.tenantName, 'Rahim Uddin');
      expect(due.oldestUnpaidMonth, BillingMonth(2026, 10));
      expect(due.outstanding, Money.fromTaka(5000));
      final PropertyOperationalReport propertyReport =
          (await reports.propertyIncome(
            propertyId: property.id.value,
            range: DateRange(
              DateTime.utc(2026, 10, 1),
              DateTime.utc(2026, 10, 31),
            ),
          ) as Success<PropertyOperationalReport>).value;
      expect(propertyReport.rentBilled, Money.fromTaka(15000));
      expect(propertyReport.received, Money.fromTaka(10000));
      expect(propertyReport.repairExpenses, Money.fromTaka(500));
      expect(propertyReport.netOperationalCash, Money.fromTaka(9500));
      final List<PaymentMethodTotal> methods = (await reports.paymentMethods(
        DateRange(DateTime.utc(2026, 10, 1), DateTime.utc(2026, 10, 31)),
      ) as Success<List<PaymentMethodTotal>>).value;
      expect(methods.single.amount, Money.fromTaka(10000));
      expect(methods.single.method, PaymentMethod.bkash);
      expect(
        (await reports.search(
          'Rahim',
        ) as Success<List<GlobalSearchResult>>).value.single.kind,
        'tenant',
      );
      expect(
        ReportsCsvExporter.tenantDues(<TenantDueReportRow>[due]).take(3),
        orderedEquals(<int>[0xEF, 0xBB, 0xBF]),
      );
    },
  );
}

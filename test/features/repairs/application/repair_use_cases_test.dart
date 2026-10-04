import 'dart:io';

import 'package:barivara/core/database/app_database.dart'
    hide
        MonthlyBill,
        Payment,
        PaymentAllocation,
        Property,
        Repair,
        RepairAttachment,
        RecurringChargeRule,
        Tenant,
        Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/repairs/application/repair_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'stores repair history, filters expenses, and links a tenant charge',
    () async {
      final _RepairFixture fixture = await _fixture();
      final RepairUseCases repairs = RepairUseCases(
        DriftRepairRepository(fixture.database),
        DriftBillingRepository(fixture.database),
      );

      final Repair repair = (await repairs.save(
        RepairInput(
          propertyId: fixture.property.id,
          unitId: fixture.unit.id,
          tenancyId: fixture.tenancy.id,
          category: RepairCategory.plumbing,
          title: 'Kitchen pipe leak',
          description: 'Leak under the kitchen sink.',
          reportedDate: DateTime.utc(2026, 10, 4),
          estimatedCost: Money.fromTaka(1000),
          cost: Money.fromTaka(1200),
          recoverableFromTenant: true,
          status: RepairStatus.completed,
        ),
      ) as Success<Repair>).value;

      expect(repair.tenantChargeBillId, fixture.bill.id);
      final BillDraft draft = (await DriftBillingRepository(
        fixture.database,
      ).findDraft(fixture.bill.id) as Success<BillDraft?>).value!;
      expect(draft.items.last.description, 'Repair charge: Kitchen pipe leak');
      expect(draft.bill.total, Money.fromTaka(16200));

      final List<Repair> filtered =
          (await DriftRepairRepository(fixture.database).list(
            RepairFilter(
              propertyId: fixture.property.id,
              category: RepairCategory.plumbing,
              status: RepairStatus.completed,
            ),
          ) as Success<List<Repair>>).value;
      expect(filtered.single.id, repair.id);
      final RepairExpenseSummary summary = (await repairs.expenseSummary(
        fixture.property.id,
        DateRange(DateTime.utc(2026, 10, 1), DateTime.utc(2026, 10, 31)),
      ) as Success<RepairExpenseSummary>).value;
      expect(summary.total, Money.fromTaka(1200));
      expect(summary.repairCount, 1);
      await TenancyUseCases(DriftTenancyRepository(fixture.database))
          .moveOut(fixture.tenancy, DateTime.utc(2026, 11, 1));
      expect(
        (await DriftRepairRepository(
          fixture.database,
        ).findById(repair.id) as Success<Repair?>).value?.title,
        'Kitchen pipe leak',
      );
    },
  );

  test('copies repair attachments into app-controlled storage', () async {
    final Directory root = await Directory.systemTemp.createTemp(
      'barivara-repair-test-',
    );
    addTearDown(() => root.delete(recursive: true));
    final File source = File('${root.path}/invoice.pdf');
    await source.writeAsString('invoice contents');
    final RepairAttachmentStorage storage = RepairAttachmentStorage(
      documentsDirectory: () async => root,
    );

    final RepairAttachment attachment = (await storage.importFile(
      repairId: EntityId('repair-1'),
      sourcePath: source.path,
      originalFileName: 'invoice.pdf',
    ) as Success<RepairAttachment>).value;
    await source.delete();

    expect(
      File('${root.path}/${attachment.relativePath}').exists(),
      completion(isTrue),
    );
    expect(attachment.mimeType, 'application/pdf');
    expect(attachment.checksum, isNotEmpty);
  });
}

class _RepairFixture {
  const _RepairFixture({
    required this.database,
    required this.property,
    required this.unit,
    required this.tenancy,
    required this.bill,
  });

  final AppDatabase database;
  final Property property;
  final RentalUnit unit;
  final Tenancy tenancy;
  final MonthlyBill bill;
}

Future<_RepairFixture> _fixture() async {
  final AppDatabase database = AppDatabase.forTesting(NativeDatabase.memory());
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
  final BillDraft bill =
      (await BillingUseCases(
                DriftBillingRepository(database),
                DriftChargeConfigurationRepository(database),
                DriftUnitRepository(database),
              ).generateDraft(
                tenancy: tenancy,
                period: BillingMonth(2026, 10),
                issueDate: DateTime.utc(2026, 10, 1),
              )
              as Success<BillDraft>)
          .value;
  return _RepairFixture(
    database: database,
    property: property,
    unit: unit,
    tenancy: tenancy,
    bill: bill.bill,
  );
}

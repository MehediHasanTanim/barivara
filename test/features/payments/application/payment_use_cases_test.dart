import 'package:barivara/core/database/app_database.dart'
    hide
        MonthlyBill,
        Payment,
        PaymentAllocation,
        Property,
        RecurringChargeRule,
        Tenant,
        Tenancy;
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/payments/application/payment_use_cases.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('allocates a partial payment to the oldest bill first', () async {
    final _PaymentFixture fixture = await _fixture();
    final Result<PaymentPosting> result = await fixture.payments.record(
      tenancy: fixture.tenancy,
      input: PaymentInput(
        amount: Money.fromTaka(10000),
        paymentDate: DateTime.utc(2026, 11, 5),
        method: PaymentMethod.cash,
      ),
    );
    final PaymentPosting posting = (result as Success<PaymentPosting>).value;
    expect(posting.allocations, hasLength(1));
    expect(posting.allocations.single.billId, fixture.october.id);
    expect(posting.allocations.single.amount, Money.fromTaka(10000));
    final MonthlyBill october = await fixture.bill(fixture.october.id);
    expect(october.status, BillStatus.partiallyPaid);
    expect(october.outstandingAmount, Money.fromTaka(5000));
  });

  test(
    'splits a multi-bill payment oldest first and rejects overpayment',
    () async {
      final _PaymentFixture fixture = await _fixture(includeNovember: true);
      final Result<PaymentPosting> result = await fixture.payments.record(
        tenancy: fixture.tenancy,
        input: PaymentInput(
          amount: Money.fromTaka(20000),
          paymentDate: DateTime.utc(2026, 11, 5),
          method: PaymentMethod.bkash,
        ),
      );
      final PaymentPosting posting = (result as Success<PaymentPosting>).value;
      expect(posting.allocations, hasLength(2));
      expect(posting.allocations[0].amount, Money.fromTaka(15000));
      expect(posting.allocations[1].amount, Money.fromTaka(5000));
      expect((await fixture.bill(fixture.october.id)).status, BillStatus.paid);
      expect(
        (await fixture.bill(fixture.november!.id)).status,
        BillStatus.partiallyPaid,
      );
      expect(
        fixture.payments.record(
          tenancy: fixture.tenancy,
          input: PaymentInput(
            amount: Money.fromTaka(99999),
            paymentDate: DateTime.utc(2026, 11, 6),
            method: PaymentMethod.cash,
          ),
        ),
        completion(isA<Failure<PaymentPosting>>()),
      );
    },
  );

  test(
    'reversal restores bill balance and retains the payment record',
    () async {
      final _PaymentFixture fixture = await _fixture();
      final PaymentPosting posting = (await fixture.payments.record(
        tenancy: fixture.tenancy,
        input: PaymentInput(
          amount: Money.fromTaka(15000),
          paymentDate: DateTime.utc(2026, 10, 5),
          method: PaymentMethod.nagad,
        ),
      ) as Success<PaymentPosting>).value;
      final Result<Payment> reversed = await fixture.payments.reverse(
        posting.payment.id,
        'Cash entry was duplicated.',
      );
      expect(
        (reversed as Success<Payment>).value.status,
        PaymentStatus.reversed,
      );
      final MonthlyBill october = await fixture.bill(fixture.october.id);
      expect(october.status, BillStatus.finalized);
      expect(october.outstandingAmount, Money.fromTaka(15000));
      final List<Payment> history =
          (await fixture.paymentRepository.listByTenancy(
            fixture.tenancy.id,
          ) as Success<List<Payment>>).value;
      expect(history.single.reversalReason, 'Cash entry was duplicated.');
    },
  );

  test(
    'rejects zero amount and rolls back an invalid direct allocation',
    () async {
      final _PaymentFixture fixture = await _fixture();
      expect(
        fixture.payments.record(
          tenancy: fixture.tenancy,
          input: PaymentInput(
            amount: Money.zero,
            paymentDate: DateTime.utc(2026, 10, 5),
            method: PaymentMethod.cash,
          ),
        ),
        completion(isA<Failure<PaymentPosting>>()),
      );
      final Payment invalid = Payment(
        id: EntityId('invalid-payment'),
        tenancyId: fixture.tenancy.id,
        tenantId: fixture.tenancy.tenantId,
        amount: Money.fromTaka(1),
        paymentDate: DateTime.utc(2026, 10, 6),
        method: PaymentMethod.cash,
        createdAt: DateTime.utc(2026, 10, 6),
      );
      final Result<void> posted = await fixture.paymentRepository.post(
        PaymentPosting(
          payment: invalid,
          allocations: <PaymentAllocation>[
            PaymentAllocation(
              id: EntityId('invalid-allocation'),
              paymentId: invalid.id,
              billId: fixture.october.id,
              amount: Money.fromTaka(2),
            ),
          ],
        ),
      );
      expect(posted, isA<Failure<void>>());
      expect(
        (await fixture.paymentRepository.listAll() as Success<List<Payment>>)
            .value,
        isEmpty,
      );
    },
  );
}

class _PaymentFixture {
  _PaymentFixture({
    required this.database,
    required this.tenancy,
    required this.october,
    required this.paymentRepository,
    this.november,
  });
  final AppDatabase database;
  final Tenancy tenancy;
  final MonthlyBill october;
  final MonthlyBill? november;
  final DriftPaymentRepository paymentRepository;
  PaymentUseCases get payments =>
      PaymentUseCases(paymentRepository, DriftBillingRepository(database));
  Future<MonthlyBill> bill(EntityId id) async => (await DriftBillingRepository(
    database,
  ).findDraft(id) as Success<BillDraft?>).value!.bill;
}

Future<_PaymentFixture> _fixture({bool includeNovember = false}) async {
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
  final BillingUseCases billing = BillingUseCases(
    DriftBillingRepository(database),
    DriftChargeConfigurationRepository(database),
    DriftUnitRepository(database),
  );
  final BillDraft october = (await billing.generateDraft(
    tenancy: tenancy,
    period: BillingMonth(2026, 10),
    issueDate: DateTime.utc(2026, 10, 1),
  ) as Success<BillDraft>).value;
  await billing.finalize(october.bill.id);
  BillDraft? november;
  if (includeNovember) {
    november = (await billing.generateDraft(
      tenancy: tenancy,
      period: BillingMonth(2026, 11),
      issueDate: DateTime.utc(2026, 11, 1),
    ) as Success<BillDraft>).value;
    await billing.finalize(november.bill.id);
  }
  return _PaymentFixture(
    database: database,
    tenancy: tenancy,
    october: october.bill,
    november: november?.bill,
    paymentRepository: DriftPaymentRepository(database),
  );
}

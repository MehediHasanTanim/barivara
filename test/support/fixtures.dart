import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';

/// Deterministic Phase 1 domain fixtures for repository and financial tests.
abstract final class Fixtures {
  /// Stable timestamp used by all fixtures.
  static final DateTime createdAt = DateTime.utc(2026, 10, 1);

  /// Creates a property fixture.
  static Property property({String id = 'property-1'}) => Property(
    id: EntityId(id),
    name: 'Rahman Villa',
    createdAt: createdAt,
    updatedAt: createdAt,
  );

  /// Creates a unit fixture under [propertyId].
  static RentalUnit unit({
    String id = 'unit-1',
    String propertyId = 'property-1',
  }) => RentalUnit(
    id: EntityId(id),
    propertyId: EntityId(propertyId),
    name: 'A-1',
    defaultRent: Money.fromTaka(15000),
    createdAt: createdAt,
    updatedAt: createdAt,
  );

  /// Creates a tenant fixture.
  static Tenant tenant({String id = 'tenant-1'}) => Tenant(
    id: EntityId(id),
    fullName: 'Rahim Uddin',
    phone: PhoneNumber('01710000000'),
    createdAt: createdAt,
    updatedAt: createdAt,
  );

  /// Creates an active tenancy fixture.
  static Tenancy tenancy({
    String id = 'tenancy-1',
    String tenantId = 'tenant-1',
    String unitId = 'unit-1',
  }) => Tenancy(
    id: EntityId(id),
    tenantId: EntityId(tenantId),
    unitId: EntityId(unitId),
    moveInDate: createdAt,
    agreedRent: Money.fromTaka(15000),
    billingDay: 5,
    status: TenancyStatus.active,
  );

  /// Creates a monthly-bill fixture.
  static MonthlyBill bill({String id = 'bill-1'}) => MonthlyBill(
    id: EntityId(id),
    tenancyId: EntityId('tenancy-1'),
    propertyId: EntityId('property-1'),
    unitId: EntityId('unit-1'),
    period: BillingMonth(2026, 10),
    issueDate: createdAt,
    openingDue: Money.zero,
    currentCharges: Money.fromTaka(19510),
    total: Money.fromTaka(19510),
    paidAmount: Money.zero,
    outstandingAmount: Money.fromTaka(19510),
    status: BillStatus.draft,
    generatedAt: createdAt,
  );

  /// Creates a payment fixture.
  static Payment payment({String id = 'payment-1'}) => Payment(
    id: EntityId(id),
    tenancyId: EntityId('tenancy-1'),
    tenantId: EntityId('tenant-1'),
    amount: Money.fromTaka(8000),
    paymentDate: createdAt,
    method: PaymentMethod.cash,
    createdAt: createdAt,
  );

  /// Creates a deposit fixture.
  static Deposit deposit({String id = 'deposit-1'}) => Deposit(
    id: EntityId(id),
    tenancyId: EntityId('tenancy-1'),
    currentBalance: Money.fromTaka(30000),
  );

  /// Creates a repair fixture.
  static Repair repair({String id = 'repair-1'}) => Repair(
    id: EntityId(id),
    propertyId: EntityId('property-1'),
    title: 'Water leakage',
    reportedDate: createdAt,
    cost: Money.fromTaka(2500),
  );
}

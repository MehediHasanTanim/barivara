import 'package:barivara/core/domain/value_types.dart';

/// Minimal property aggregate used by Phase 1 repositories.
class Property {
  /// Creates a property.
  const Property({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  final EntityId id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
}

/// Minimal rentable-unit aggregate used by Phase 1 repositories.
class RentalUnit {
  /// Creates a unit.
  const RentalUnit({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.defaultRent,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  final EntityId id;
  final EntityId propertyId;
  final String name;
  final Money defaultRent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
}

/// Tenant identity aggregate.
class Tenant {
  /// Creates a tenant.
  const Tenant({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  final EntityId id;
  final String fullName;
  final PhoneNumber phone;
  final DateTime createdAt;
  final DateTime updatedAt;
}

/// A tenant's occupancy period in a specific unit.
class Tenancy {
  /// Creates a tenancy.
  const Tenancy({
    required this.id,
    required this.tenantId,
    required this.unitId,
    required this.moveInDate,
    required this.status,
  });

  final EntityId id;
  final EntityId tenantId;
  final EntityId unitId;
  final DateTime moveInDate;
  final String status;
}

/// A monthly billing snapshot.
class MonthlyBill {
  /// Creates a bill snapshot.
  const MonthlyBill({
    required this.id,
    required this.tenancyId,
    required this.period,
    required this.total,
    required this.status,
  });

  final EntityId id;
  final EntityId tenancyId;
  final BillingMonth period;
  final Money total;
  final String status;
}

/// A locally posted payment.
class Payment {
  /// Creates a payment.
  const Payment({
    required this.id,
    required this.tenancyId,
    required this.amount,
    required this.paymentDate,
    required this.method,
  });

  final EntityId id;
  final EntityId tenancyId;
  final Money amount;
  final DateTime paymentDate;
  final PaymentMethod method;
}

/// A tenant security-deposit account snapshot.
class Deposit {
  /// Creates a deposit account snapshot.
  const Deposit({
    required this.id,
    required this.tenancyId,
    required this.currentBalance,
  });

  final EntityId id;
  final EntityId tenancyId;
  final Money currentBalance;
}

/// A property maintenance record.
class Repair {
  /// Creates a repair record.
  const Repair({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.reportedDate,
    required this.cost,
  });

  final EntityId id;
  final EntityId propertyId;
  final String title;
  final DateTime reportedDate;
  final Money cost;
}

/// Metadata for a portable backup. Actual archive handling is introduced later.
class BackupDescriptor {
  /// Creates backup metadata.
  const BackupDescriptor({required this.fileName, required this.createdAt});

  final String fileName;
  final DateTime createdAt;
}

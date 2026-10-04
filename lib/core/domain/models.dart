import 'package:barivara/core/domain/value_types.dart';

/// High-level categories used to describe a landlord property.
enum PropertyType { residential, commercial, mixedUse, other }

/// Derived operational unit availability.
enum UnitAvailability { vacant, occupied, reserved, archived }

/// Filter options for the unit list.
enum UnitFilter { all, occupied, vacant, archived }

/// Property aggregate retained independently from its current unit activity.
class Property {
  /// Creates a property.
  const Property({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.type = PropertyType.residential,
    this.nickname,
    this.addressLine,
    this.area,
    this.cityDistrict,
    this.notes,
    this.isArchived = false,
  });

  final EntityId id;
  final String name;
  final PropertyType type;
  final String? nickname;
  final String? addressLine;
  final String? area;
  final String? cityDistrict;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
}

/// Rentable unit configuration, separate from occupancy history.
class RentalUnit {
  /// Creates a unit.
  const RentalUnit({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.defaultRent,
    required this.createdAt,
    required this.updatedAt,
    this.floorName,
    this.unitType = 'apartment',
    this.bedrooms,
    this.defaultServiceCharge = Money.zero,
    this.defaultGasCharge = Money.zero,
    this.defaultWaterCharge = Money.zero,
    this.manualAvailability = UnitAvailability.vacant,
    this.notes,
    this.isArchived = false,
  });

  final EntityId id;
  final EntityId propertyId;
  final String name;
  final Money defaultRent;
  final String? floorName;
  final String unitType;
  final int? bedrooms;
  final Money defaultServiceCharge;
  final Money defaultGasCharge;
  final Money defaultWaterCharge;
  final UnitAvailability manualAvailability;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
}

/// Property-list data with operating counts derived from local records.
class PropertySummary {
  /// Creates a property summary.
  const PropertySummary({
    required this.property,
    required this.unitCount,
    required this.occupiedCount,
    required this.vacantCount,
    required this.currentMonthDue,
  });

  final Property property;
  final int unitCount;
  final int occupiedCount;
  final int vacantCount;
  final Money currentMonthDue;
}

/// Unit-list data whose availability is derived from active tenancy records.
class UnitSummary {
  /// Creates a unit summary.
  const UnitSummary({
    required this.unit,
    required this.availability,
    this.activeTenantName,
  });

  final RentalUnit unit;
  final UnitAvailability availability;
  final String? activeTenantName;
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

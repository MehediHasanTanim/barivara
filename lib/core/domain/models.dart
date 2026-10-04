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

/// Ways a recurring charge becomes a monthly bill line item.
enum ChargeCalculationMethod { fixed, meterRate, manual, previousBalance }

/// Immutable versioned charge configuration used for a billing period.
class RecurringChargeRule {
  /// Creates a recurring charge rule.
  const RecurringChargeRule({
    required this.id,
    required this.tenancyId,
    required this.chargeType,
    required this.calculationMethod,
    required this.fixedAmount,
    required this.effectiveFrom,
    this.ratePerUnit,
    this.effectiveTo,
    this.isActive = true,
  });

  final EntityId id;
  final EntityId tenancyId;
  final ChargeType chargeType;
  final ChargeCalculationMethod calculationMethod;
  final Money fixedAmount;
  final Money? ratePerUnit;
  final BillingMonth effectiveFrom;
  final BillingMonth? effectiveTo;
  final bool isActive;
}

/// Stored electricity meter setup independent from monthly readings.
class UtilityMeterConfiguration {
  /// Creates a unit meter configuration.
  const UtilityMeterConfiguration({
    required this.id,
    required this.unitId,
    required this.billingMode,
    required this.ratePerUnit,
    required this.fixedFee,
    required this.initialReading,
    this.meterNumber,
    this.isActive = true,
  });

  final EntityId id;
  final EntityId unitId;
  final String billingMode;
  final Money ratePerUnit;
  final Money fixedFee;
  final MeterReading initialReading;
  final String? meterNumber;
  final bool isActive;
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
    this.alternativePhone,
    this.nidNumber,
    this.permanentAddress,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.notes,
    this.photoPath,
    this.isArchived = false,
  });

  final EntityId id;
  final String fullName;
  final PhoneNumber phone;
  final PhoneNumber? alternativePhone;
  final String? nidNumber;
  final String? permanentAddress;
  final String? emergencyContactName;
  final PhoneNumber? emergencyContactPhone;
  final String? notes;
  final String? photoPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
}

/// Tenancy lifecycle states retained as part of permanent occupancy history.
enum TenancyStatus { active, movedOut }

/// A tenant's occupancy period in a specific unit.
class Tenancy {
  /// Creates a tenancy.
  const Tenancy({
    required this.id,
    required this.tenantId,
    required this.unitId,
    required this.moveInDate,
    required this.agreedRent,
    required this.billingDay,
    this.expectedMoveOutDate,
    this.actualMoveOutDate,
    this.securityDepositTarget = Money.zero,
    this.advanceRent = Money.zero,
    this.agreementNotes,
    this.status = TenancyStatus.active,
  });

  final EntityId id;
  final EntityId tenantId;
  final EntityId unitId;
  final DateTime moveInDate;
  final DateTime? expectedMoveOutDate;
  final DateTime? actualMoveOutDate;
  final Money agreedRent;
  final int billingDay;
  final Money securityDepositTarget;
  final Money advanceRent;
  final String? agreementNotes;
  final TenancyStatus status;
}

/// Tenant-list information with derived current unit and non-financial status.
class TenantSummary {
  /// Creates a tenant-list summary.
  const TenantSummary({
    required this.tenant,
    this.currentTenancy,
    this.unitName,
    this.propertyName,
  });

  final Tenant tenant;
  final Tenancy? currentTenancy;
  final String? unitName;
  final String? propertyName;
}

/// Lifecycle state for an immutable monthly financial snapshot.
enum BillStatus { draft, finalized, partiallyPaid, paid, cancelled }

/// A single snapshotted bill component, including meter operands where used.
class BillLineItem {
  /// Creates a durable bill line item.
  const BillLineItem({
    required this.id,
    required this.billId,
    required this.type,
    required this.description,
    required this.amount,
    required this.displayOrder,
    this.quantity,
    this.unitRate,
    this.previousReading,
    this.currentReading,
    this.sourceRuleId,
  });

  final EntityId id;
  final EntityId billId;
  final ChargeType type;
  final String description;
  final int? quantity;
  final Money? unitRate;
  final Money amount;
  final MeterReading? previousReading;
  final MeterReading? currentReading;
  final EntityId? sourceRuleId;
  final int displayOrder;
}

/// A monthly billing snapshot, including its accounting totals and status.
class MonthlyBill {
  /// Creates a monthly bill header.
  const MonthlyBill({
    required this.id,
    required this.tenancyId,
    required this.propertyId,
    required this.unitId,
    required this.period,
    required this.issueDate,
    required this.openingDue,
    required this.currentCharges,
    required this.total,
    required this.paidAmount,
    required this.outstandingAmount,
    required this.status,
    required this.generatedAt,
    this.dueDate,
    this.finalizedAt,
  });

  final EntityId id;
  final EntityId tenancyId;
  final EntityId propertyId;
  final EntityId unitId;
  final BillingMonth period;
  final DateTime issueDate;
  final DateTime? dueDate;
  final Money openingDue;
  final Money currentCharges;
  final Money total;
  final Money paidAmount;
  final Money outstandingAmount;
  final BillStatus status;
  final DateTime generatedAt;
  final DateTime? finalizedAt;
}

/// A bill header and its immutable line snapshots prepared before persistence.
class BillDraft {
  /// Creates a deterministic draft result.
  const BillDraft({required this.bill, required this.items});

  final MonthlyBill bill;
  final List<BillLineItem> items;
}

/// Lifecycle state retained for posted and reversed ledger entries.
enum PaymentStatus { posted, reversed }

/// A locally posted payment. Reversed payments are retained for auditability.
class Payment {
  /// Creates a payment.
  const Payment({
    required this.id,
    required this.tenancyId,
    required this.tenantId,
    required this.amount,
    required this.paymentDate,
    required this.method,
    required this.createdAt,
    this.reference,
    this.note,
    this.status = PaymentStatus.posted,
    this.reversalReason,
    this.reversedAt,
  });

  final EntityId id;
  final EntityId tenancyId;
  final EntityId tenantId;
  final Money amount;
  final DateTime paymentDate;
  final PaymentMethod method;
  final String? reference;
  final String? note;
  final PaymentStatus status;
  final String? reversalReason;
  final DateTime? reversedAt;
  final DateTime createdAt;
}

/// Immutable link showing exactly which bill a payment settled.
class PaymentAllocation {
  /// Creates a payment-to-bill allocation.
  const PaymentAllocation({
    required this.id,
    required this.paymentId,
    required this.billId,
    required this.amount,
  });

  final EntityId id;
  final EntityId paymentId;
  final EntityId billId;
  final Money amount;
}

/// Atomic posted-payment request containing its bill allocations.
class PaymentPosting {
  /// Creates one auditable payment posting transaction.
  const PaymentPosting({required this.payment, required this.allocations});

  final Payment payment;
  final List<PaymentAllocation> allocations;
}

/// Language used for the fixed labels of a generated receipt.
enum ReceiptLanguage { english, bengali }

/// A displayed charge line frozen into a receipt.
class ReceiptLineItem {
  const ReceiptLineItem({required this.description, required this.amount});

  final String description;
  final Money amount;

  Map<String, Object> toJson() => <String, Object>{
    'description': description,
    'amountPoisha': amount.poisha,
  };

  factory ReceiptLineItem.fromJson(Map<String, dynamic> json) =>
      ReceiptLineItem(
        description: json['description']! as String,
        amount: Money.fromPoisha(json['amountPoisha']! as int),
      );
}

/// Immutable input used to render a receipt now or years later.
class ReceiptSnapshot {
  const ReceiptSnapshot({
    required this.id,
    required this.paymentId,
    required this.receiptNumber,
    required this.templateVersion,
    required this.createdAt,
    required this.propertyName,
    required this.tenantName,
    required this.unitName,
    required this.billingMonths,
    required this.chargeBreakdown,
    required this.paymentAmount,
    required this.remainingDue,
    required this.paymentMethod,
    required this.paymentDate,
    this.propertyAddress,
    this.landlordName,
    this.landlordPhone,
  });

  final EntityId id;
  final EntityId paymentId;
  final String receiptNumber;
  final int templateVersion;
  final DateTime createdAt;
  final String propertyName;
  final String? propertyAddress;
  final String? landlordName;
  final String? landlordPhone;
  final String tenantName;
  final String unitName;
  final List<BillingMonth> billingMonths;
  final List<ReceiptLineItem> chargeBreakdown;
  final Money paymentAmount;
  final Money remainingDue;
  final PaymentMethod paymentMethod;
  final DateTime paymentDate;

  Map<String, Object?> toJson() => <String, Object?>{
    'id': id.value,
    'paymentId': paymentId.value,
    'receiptNumber': receiptNumber,
    'templateVersion': templateVersion,
    'createdAt': createdAt.toUtc().toIso8601String(),
    'propertyName': propertyName,
    'propertyAddress': propertyAddress,
    'landlordName': landlordName,
    'landlordPhone': landlordPhone,
    'tenantName': tenantName,
    'unitName': unitName,
    'billingMonths': billingMonths
        .map(
          (BillingMonth value) => <String, int>{
            'year': value.year,
            'month': value.month,
          },
        )
        .toList(growable: false),
    'chargeBreakdown': chargeBreakdown
        .map((ReceiptLineItem value) => value.toJson())
        .toList(growable: false),
    'paymentAmountPoisha': paymentAmount.poisha,
    'remainingDuePoisha': remainingDue.poisha,
    'paymentMethod': paymentMethod.name,
    'paymentDate': paymentDate.toUtc().toIso8601String(),
  };

  factory ReceiptSnapshot.fromJson(Map<String, dynamic> json) {
    final List<dynamic> months = json['billingMonths']! as List<dynamic>;
    final List<dynamic> lines = json['chargeBreakdown']! as List<dynamic>;
    return ReceiptSnapshot(
      id: EntityId(json['id']! as String),
      paymentId: EntityId(json['paymentId']! as String),
      receiptNumber: json['receiptNumber']! as String,
      templateVersion: json['templateVersion']! as int,
      createdAt: DateTime.parse(json['createdAt']! as String),
      propertyName: json['propertyName']! as String,
      propertyAddress: json['propertyAddress'] as String?,
      landlordName: json['landlordName'] as String?,
      landlordPhone: json['landlordPhone'] as String?,
      tenantName: json['tenantName']! as String,
      unitName: json['unitName']! as String,
      billingMonths: months
          .map(
            (dynamic value) => BillingMonth(
              (value as Map<String, dynamic>)['year']! as int,
              value['month']! as int,
            ),
          )
          .toList(growable: false),
      chargeBreakdown: lines
          .map(
            (dynamic value) =>
                ReceiptLineItem.fromJson(value as Map<String, dynamic>),
          )
          .toList(growable: false),
      paymentAmount: Money.fromPoisha(json['paymentAmountPoisha']! as int),
      remainingDue: Money.fromPoisha(json['remainingDuePoisha']! as int),
      paymentMethod: PaymentMethod.values.firstWhere(
        (PaymentMethod method) => method.name == json['paymentMethod'],
        orElse: () => PaymentMethod.other,
      ),
      paymentDate: DateTime.parse(json['paymentDate']! as String),
    );
  }
}

/// Current due totals shown before posting a payment.
class DueSummary {
  /// Creates a tenancy-level due summary.
  const DueSummary({
    required this.currentMonthDue,
    required this.previousOverdue,
    required this.totalOutstanding,
  });

  final Money currentMonthDue;
  final Money previousOverdue;
  final Money totalOutstanding;
}

/// A tenant security-deposit account snapshot.
class Deposit {
  /// Creates a deposit account snapshot.
  const Deposit({
    required this.id,
    required this.tenancyId,
    required this.currentBalance,
    this.expected = Money.zero,
    this.advanceRentBalance = Money.zero,
  });

  final EntityId id;
  final EntityId tenancyId;
  final Money currentBalance;
  final Money expected;
  final Money advanceRentBalance;
}

/// Append-only categories for funds held outside rent income.
enum DepositTransactionType {
  received,
  additional,
  refund,
  deduction,
  transferToDue,
  correction,
}

/// A ledger entry for a tenancy deposit account.
class DepositTransaction {
  const DepositTransaction({
    required this.id,
    required this.depositId,
    required this.type,
    required this.amount,
    required this.date,
    this.note,
    this.method,
  });
  final EntityId id;
  final EntityId depositId;
  final DepositTransactionType type;
  final Money amount;
  final DateTime date;
  final String? note;
  final PaymentMethod? method;
}

/// Move-out calculation separated from normal rent-payment history.
class MoveOutSettlement {
  const MoveOutSettlement({
    required this.outstanding,
    required this.repairCharges,
    required this.credits,
    required this.depositApplied,
    required this.finalPayable,
  });
  final Money outstanding;
  final Money repairCharges;
  final Money credits;
  final Money depositApplied;
  final Money finalPayable;
}

/// Categories used to group landlord maintenance work.
enum RepairCategory {
  plumbing,
  electrical,
  appliance,
  painting,
  structural,
  cleaning,
  other,
}

/// Lifecycle states retained for a repair record.
enum RepairStatus { open, inProgress, completed, cancelled }

/// The party that actually paid the maintenance cost.
enum RepairResponsibility { landlord, tenant }

/// A property maintenance record, retained even after a related tenancy ends.
class Repair {
  /// Creates a repair record.
  const Repair({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.reportedDate,
    required this.cost,
    this.category = RepairCategory.other,
    this.status = RepairStatus.open,
    this.responsibility = RepairResponsibility.landlord,
    this.unitId,
    this.tenancyId,
    this.description,
    this.completedDate,
    this.estimatedCost,
    this.recoverableFromTenant = false,
    this.tenantChargeBillId,
    this.notes,
  });

  final EntityId id;
  final EntityId propertyId;
  final EntityId? unitId;
  final EntityId? tenancyId;
  final RepairCategory category;
  final String title;
  final String? description;
  final DateTime reportedDate;
  final DateTime? completedDate;
  final Money? estimatedCost;
  final Money cost;
  final RepairResponsibility responsibility;
  final bool recoverableFromTenant;

  /// The draft bill that received the explicit tenant repair adjustment.
  final EntityId? tenantChargeBillId;
  final RepairStatus status;
  final String? notes;
}

/// A copied local repair attachment; its path never points to the import source.
class RepairAttachment {
  const RepairAttachment({
    required this.id,
    required this.repairId,
    required this.fileName,
    required this.relativePath,
    required this.createdAt,
    this.mimeType,
    this.fileSize,
    this.checksum,
  });

  final EntityId id;
  final EntityId repairId;
  final String fileName;
  final String relativePath;
  final String? mimeType;
  final int? fileSize;
  final String? checksum;
  final DateTime createdAt;
}

/// Local filters applied to the repair list.
class RepairFilter {
  const RepairFilter({
    this.propertyId,
    this.unitId,
    this.status,
    this.category,
    this.dateRange,
  });

  final EntityId? propertyId;
  final EntityId? unitId;
  final RepairStatus? status;
  final RepairCategory? category;
  final DateRange? dateRange;
}

/// Landlord-paid maintenance cost for a property over an inclusive date range.
class RepairExpenseSummary {
  const RepairExpenseSummary({
    required this.propertyId,
    required this.range,
    required this.total,
    required this.repairCount,
  });

  final EntityId propertyId;
  final DateRange range;
  final Money total;
  final int repairCount;
}

/// Metadata for a portable backup. Actual archive handling is introduced later.
class BackupDescriptor {
  /// Creates backup metadata.
  const BackupDescriptor({required this.fileName, required this.createdAt});

  final String fileName;
  final DateTime createdAt;
}

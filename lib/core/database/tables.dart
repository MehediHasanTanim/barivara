import 'package:drift/drift.dart';

/// Landlord-owned properties.
class Properties extends Table {
  @override
  String get tableName => 'properties';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get propertyType =>
      text().withDefault(const Constant('residential'))();
  TextColumn get nickname => text().nullable()();
  TextColumn get addressLine => text().nullable()();
  TextColumn get area => text().nullable()();
  TextColumn get cityDistrict => text().nullable()();
  TextColumn get ownerName => text().nullable()();
  TextColumn get ownerPhone => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Rentable units belonging to a property.
@TableIndex(name: 'units_property_id_idx', columns: <Symbol>{#propertyId})
class Units extends Table {
  @override
  String get tableName => 'units';

  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get name => text()();
  TextColumn get floorName => text().nullable()();
  TextColumn get unitType => text().withDefault(const Constant('apartment'))();
  IntColumn get bedrooms => integer().nullable()();
  IntColumn get defaultRentPoisha => integer().withDefault(const Constant(0))();
  IntColumn get defaultServiceChargePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get defaultGasChargePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get defaultWaterChargePoisha =>
      integer().withDefault(const Constant(0))();
  TextColumn get occupancyStatus =>
      text().withDefault(const Constant('vacant'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {propertyId, name},
  ];
}

/// Tenant identity, retained independently from occupancy periods.
@TableIndex(name: 'tenants_status_idx', columns: <Symbol>{#status})
class Tenants extends Table {
  @override
  String get tableName => 'tenants';

  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get banglaName => text().nullable()();
  TextColumn get phone => text()();
  TextColumn get alternativePhone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get nidNumber => text().nullable()();
  TextColumn get permanentAddress => text().nullable()();
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Tenant occupancy periods, kept as history rather than rewritten on move-out.
@TableIndex(name: 'tenancies_tenant_id_idx', columns: <Symbol>{#tenantId})
@TableIndex(name: 'tenancies_unit_id_idx', columns: <Symbol>{#unitId})
class Tenancies extends Table {
  @override
  String get tableName => 'tenancies';

  TextColumn get id => text()();
  TextColumn get tenantId => text().references(Tenants, #id)();
  TextColumn get unitId => text().references(Units, #id)();
  DateTimeColumn get moveInDate => dateTime()();
  DateTimeColumn get expectedMoveOutDate => dateTime().nullable()();
  DateTimeColumn get actualMoveOutDate => dateTime().nullable()();
  IntColumn get agreedRentPoisha => integer().withDefault(const Constant(0))();
  IntColumn get billingDay => integer().withDefault(const Constant(5))();
  IntColumn get securityDepositTargetPoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get advanceRentPoisha => integer().withDefault(const Constant(0))();
  TextColumn get agreementNotes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Versioned recurring billing rules for a tenancy or unit.
@TableIndex(name: 'charge_rules_tenancy_id_idx', columns: <Symbol>{#tenancyId})
class RecurringChargeRules extends Table {
  @override
  String get tableName => 'recurring_charge_rules';

  TextColumn get id => text()();
  TextColumn get tenancyId => text().references(Tenancies, #id)();
  TextColumn get chargeType => text()();
  TextColumn get calculationMethod => text()();
  IntColumn get fixedAmountPoisha => integer().withDefault(const Constant(0))();
  IntColumn get ratePoisha => integer().nullable()();
  DateTimeColumn get effectiveFrom => dateTime()();
  DateTimeColumn get effectiveTo => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Unit electricity-meter setup.
@TableIndex(name: 'meter_configs_unit_id_idx', columns: <Symbol>{#unitId})
class UtilityMeterConfigs extends Table {
  @override
  String get tableName => 'utility_meter_configs';

  TextColumn get id => text()();
  TextColumn get unitId => text().references(Units, #id)();
  TextColumn get meterNumber => text().nullable()();
  TextColumn get billingMode => text()();
  IntColumn get ratePerUnitPoisha => integer().withDefault(const Constant(0))();
  IntColumn get additionalChargePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get initialReading => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// One snapshot bill per tenancy and billing month.
@TableIndex(name: 'bills_tenancy_id_idx', columns: <Symbol>{#tenancyId})
@TableIndex(
  name: 'bills_month_idx',
  columns: <Symbol>{#billingYear, #billingMonth},
)
@TableIndex(name: 'bills_status_idx', columns: <Symbol>{#status})
class MonthlyBills extends Table {
  @override
  String get tableName => 'monthly_bills';

  TextColumn get id => text()();
  TextColumn get tenancyId => text().references(Tenancies, #id)();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get unitId => text().references(Units, #id)();
  IntColumn get billingYear => integer()();
  IntColumn get billingMonth => integer()();
  // Nullable only for migration compatibility with pre-v4 local databases;
  // every newly written draft supplies this field explicitly.
  DateTimeColumn get issuedAt => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  IntColumn get previousDuePoisha => integer().withDefault(const Constant(0))();
  IntColumn get subtotalPoisha => integer().withDefault(const Constant(0))();
  IntColumn get totalPoisha => integer().withDefault(const Constant(0))();
  IntColumn get paidPoisha => integer().withDefault(const Constant(0))();
  IntColumn get balancePoisha => integer().withDefault(const Constant(0))();
  DateTimeColumn get finalizedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {tenancyId, billingYear, billingMonth},
  ];
}

/// Immutable line-item snapshots for a monthly bill.
@TableIndex(name: 'bill_items_bill_id_idx', columns: <Symbol>{#billId})
class BillLineItems extends Table {
  @override
  String get tableName => 'bill_line_items';

  TextColumn get id => text()();
  TextColumn get billId => text().references(MonthlyBills, #id)();
  TextColumn get itemType => text()();
  TextColumn get description => text()();
  IntColumn get quantity => integer().nullable()();
  IntColumn get unitRatePoisha => integer().nullable()();
  IntColumn get amountPoisha => integer()();
  TextColumn get sourceRuleId => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get metadataJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Posted or reversed payments.
@TableIndex(name: 'payments_tenancy_id_idx', columns: <Symbol>{#tenancyId})
@TableIndex(name: 'payments_date_idx', columns: <Symbol>{#paymentDate})
class Payments extends Table {
  @override
  String get tableName => 'payments';

  TextColumn get id => text()();
  TextColumn get tenancyId => text().references(Tenancies, #id)();
  TextColumn get tenantId => text().nullable().references(Tenants, #id)();
  TextColumn get paymentNumber => text()();
  DateTimeColumn get paymentDate => dateTime()();
  IntColumn get amountPoisha => integer()();
  TextColumn get paymentMethod => text()();
  TextColumn get reference => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('posted'))();
  TextColumn get reversalReason => text().nullable()();
  DateTimeColumn get reversedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Allocation of a payment across one or more bills.
@TableIndex(
  name: 'payment_allocations_payment_id_idx',
  columns: <Symbol>{#paymentId},
)
@TableIndex(name: 'payment_allocations_bill_id_idx', columns: <Symbol>{#billId})
class PaymentAllocations extends Table {
  @override
  String get tableName => 'payment_allocations';

  TextColumn get id => text()();
  TextColumn get paymentId => text().references(Payments, #id)();
  TextColumn get billId => text().references(MonthlyBills, #id)();
  IntColumn get amountPoisha => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A permanent, self-contained receipt snapshot for one posted payment.
///
/// The JSON payload intentionally includes the names and bill items displayed
/// on the receipt. This makes regenerated receipts independent of later edits
/// to tenant, property, unit, or recurring-charge configuration.
@TableIndex(name: 'receipts_payment_id_idx', columns: <Symbol>{#paymentId})
class Receipts extends Table {
  @override
  String get tableName => 'receipts';

  TextColumn get id => text()();
  TextColumn get paymentId => text().references(Payments, #id)();
  TextColumn get receiptNumber => text()();
  IntColumn get templateVersion => integer()();
  TextColumn get snapshotJson => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {paymentId},
    {receiptNumber},
  ];
}

/// Security-deposit account for a tenancy.
@TableIndex(name: 'deposits_tenancy_id_idx', columns: <Symbol>{#tenancyId})
class Deposits extends Table {
  @override
  String get tableName => 'deposits';

  TextColumn get id => text()();
  TextColumn get tenancyId => text().references(Tenancies, #id)();
  IntColumn get openingBalancePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get expectedBalancePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get advanceRentBalancePoisha =>
      integer().withDefault(const Constant(0))();
  IntColumn get currentBalancePoisha =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {tenancyId},
  ];
}

/// Append-only deposit movements.
@TableIndex(
  name: 'deposit_transactions_deposit_id_idx',
  columns: <Symbol>{#depositId},
)
class DepositTransactions extends Table {
  @override
  String get tableName => 'deposit_transactions';

  TextColumn get id => text()();
  TextColumn get depositId => text().references(Deposits, #id)();
  TextColumn get type => text()();
  IntColumn get amountPoisha => integer()();
  DateTimeColumn get transactionDate => dateTime()();
  TextColumn get referenceType => text().nullable()();
  TextColumn get referenceId => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get reference => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Property maintenance record.
@TableIndex(name: 'repairs_property_id_idx', columns: <Symbol>{#propertyId})
@TableIndex(name: 'repairs_unit_id_idx', columns: <Symbol>{#unitId})
class Repairs extends Table {
  @override
  String get tableName => 'repairs';

  TextColumn get id => text()();
  TextColumn get propertyId => text().references(Properties, #id)();
  TextColumn get unitId => text().nullable().references(Units, #id)();
  TextColumn get tenancyId => text().nullable().references(Tenancies, #id)();
  TextColumn get category => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get reportedDate => dateTime()();
  DateTimeColumn get completedDate => dateTime().nullable()();
  IntColumn get costPoisha => integer().withDefault(const Constant(0))();
  TextColumn get responsibility => text()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// App-private repair image and invoice metadata.
@TableIndex(
  name: 'repair_attachments_repair_id_idx',
  columns: <Symbol>{#repairId},
)
class RepairAttachments extends Table {
  @override
  String get tableName => 'repair_attachments';

  TextColumn get id => text()();
  TextColumn get repairId => text().references(Repairs, #id)();
  TextColumn get fileName => text()();
  TextColumn get relativePath => text()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get fileSize => integer().nullable()();
  TextColumn get checksum => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Application preferences and business-profile fields stored locally.
class AppSettings extends Table {
  @override
  String get tableName => 'app_settings';

  TextColumn get key => text()();
  TextColumn get valueJson => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// Append-only financial and data-management audit history.
@TableIndex(name: 'audit_events_created_at_idx', columns: <Symbol>{#createdAt})
class AuditEvents extends Table {
  @override
  String get tableName => 'audit_events';

  TextColumn get id => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get action => text()();
  TextColumn get summary => text()();
  TextColumn get beforeJson => text().nullable()();
  TextColumn get afterJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Schema lifecycle metadata used for health checks and recovery guidance.
class SchemaMetadata extends Table {
  @override
  String get tableName => 'schema_metadata';

  TextColumn get id => text()();
  IntColumn get schemaVersion => integer()();
  DateTimeColumn get lastMigrationAt => dateTime()();
  TextColumn get lastMigrationError => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

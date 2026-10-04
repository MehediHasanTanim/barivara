import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';

/// Application-facing property persistence contract.
abstract interface class PropertyRepository {
  Future<Result<List<Property>>> list();
  Future<Result<List<Property>>> listArchived();
  Future<Result<List<PropertySummary>>> listSummaries();
  Future<Result<Property?>> findById(EntityId id);
  Future<Result<bool>> hasDuplicateName(String name, {EntityId? excludingId});
  Future<Result<void>> save(Property property);
  Future<Result<void>> archive(EntityId id);
}

/// Application-facing unit persistence contract.
abstract interface class UnitRepository {
  Future<Result<List<RentalUnit>>> listByProperty(EntityId propertyId);
  Future<Result<List<UnitSummary>>> listSummariesByProperty(
    EntityId propertyId, {
    UnitFilter filter = UnitFilter.all,
  });
  Future<Result<RentalUnit?>> findById(EntityId id);
  Future<Result<void>> save(RentalUnit unit);
  Future<Result<void>> archive(EntityId id);
}

/// Application-facing tenant persistence contract.
abstract interface class TenantRepository {
  Future<Result<List<Tenant>>> search(String query);
  Future<Result<List<TenantSummary>>> searchSummaries(String query);
  Future<Result<Tenant?>> findById(EntityId id);
  Future<Result<void>> save(Tenant tenant);
  Future<Result<void>> archive(EntityId id);
}

/// Application-facing tenancy persistence contract.
abstract interface class TenancyRepository {
  Future<Result<Tenancy?>> findActiveByUnit(EntityId unitId);
  Future<Result<Tenancy?>> findActiveByTenant(EntityId tenantId);
  Future<Result<List<Tenancy>>> listByTenant(EntityId tenantId);
  Future<Result<List<Tenancy>>> listByUnit(EntityId unitId, {DateRange? range});
  Future<Result<void>> save(Tenancy tenancy);
  Future<Result<void>> moveOut(EntityId tenancyId, DateTime effectiveDate);
}

/// Persistence contract for versioned charge setup and unit meter settings.
abstract interface class ChargeConfigurationRepository {
  Future<Result<List<RecurringChargeRule>>> listRules(EntityId tenancyId);
  Future<Result<RecurringChargeRule?>> ruleForMonth(
    EntityId tenancyId,
    ChargeType chargeType,
    BillingMonth month,
  );
  Future<Result<void>> saveRule(RecurringChargeRule rule);
  Future<Result<UtilityMeterConfiguration?>> meterForUnit(EntityId unitId);
  Future<Result<void>> saveMeter(UtilityMeterConfiguration configuration);
}

/// Application-facing billing persistence contract.
abstract interface class BillingRepository {
  Future<Result<MonthlyBill?>> findForPeriod(
    EntityId tenancyId,
    BillingMonth period,
  );
  Future<Result<List<MonthlyBill>>> listForPeriod(BillingMonth period);
  Future<Result<List<MonthlyBill>>> listOutstandingByTenancy(
    EntityId tenancyId,
  );
  Future<Result<Money>> openingDue(EntityId tenancyId, BillingMonth period);
  Future<Result<MeterReading?>> lastElectricityReading(EntityId unitId);
  Future<Result<BillDraft?>> findDraft(EntityId billId);
  Future<Result<void>> saveDraft(BillDraft draft);
  Future<Result<MonthlyBill>> finalize(EntityId billId);
  Future<Result<MonthlyBill>> cancel(EntityId billId);
  Future<Result<MonthlyBill>> addAdjustment(
    EntityId billId,
    BillLineItem adjustment,
  );
}

/// Application-facing payment persistence contract.
abstract interface class PaymentRepository {
  Future<Result<List<Payment>>> listByTenancy(EntityId tenancyId);
  Future<Result<List<Payment>>> listAll();
  Future<Result<void>> post(PaymentPosting posting);
  Future<Result<Payment>> reverse(EntityId paymentId, String reason);
}

/// Persistence contract for immutable, payment-linked receipt snapshots.
abstract interface class ReceiptRepository {
  Future<Result<ReceiptSnapshot>> createForPayment(EntityId paymentId);
  Future<Result<ReceiptSnapshot?>> findByPayment(EntityId paymentId);
}

/// Application-facing security-deposit persistence contract.
abstract interface class DepositRepository {
  Future<Result<Deposit?>> findByTenancy(EntityId tenancyId);
  Future<Result<List<DepositTransaction>>> history(EntityId tenancyId);
  Future<Result<void>> post(Deposit deposit, DepositTransaction transaction);
}

/// Application-facing repair persistence contract.
abstract interface class RepairRepository {
  Future<Result<Repair?>> findById(EntityId id);
  Future<Result<List<Repair>>> list(RepairFilter filter);
  Future<Result<List<Repair>>> listByProperty(EntityId propertyId);
  Future<Result<void>> save(Repair repair);
  Future<Result<void>> linkTenantCharge(EntityId repairId, EntityId billId);
  Future<Result<List<RepairAttachment>>> attachments(EntityId repairId);
  Future<Result<void>> saveAttachment(RepairAttachment attachment);
  Future<Result<RepairExpenseSummary>> expenseSummary(
    EntityId propertyId,
    DateRange range,
  );
}

/// Application-facing settings persistence contract.
abstract interface class SettingsRepository {
  Future<Result<String?>> getValue(String key);
  Future<Result<void>> setValue(String key, String valueJson);
}

/// Contract reserved for the Phase 13 backup implementation.
abstract interface class BackupRepository {
  Future<Result<BackupDescriptor>> createBackup();
  Future<Result<void>> restoreBackup(BackupDescriptor backup);
}

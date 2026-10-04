import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_engine.dart';
import 'package:uuid/uuid.dart';

/// Current values entered by the landlord while generating a bill.
class BillGenerationValues {
  /// Creates manual and meter values for a bill period.
  const BillGenerationValues({
    this.manualAmounts = const <ChargeType, Money>{},
    this.meterReadings = const <ChargeType, BillMeterReadings>{},
  });

  final Map<ChargeType, Money> manualAmounts;
  final Map<ChargeType, BillMeterReadings> meterReadings;
}

/// Result of a bulk draft run with safe per-tenancy failures for missing input.
class BulkBillGeneration {
  /// Creates an aggregate result for the property workflow.
  const BulkBillGeneration({required this.created, required this.skipped});

  final List<MonthlyBill> created;
  final Map<EntityId, AppFailure> skipped;
}

/// Coordinates stable repository inputs with the pure [BillingEngine].
class BillingUseCases {
  /// Creates billing commands.
  BillingUseCases(this._bills, this._charges, this._units, {Uuid? uuid})
    : _uuid = uuid ?? Uuid();

  final BillingRepository _bills;
  final ChargeConfigurationRepository _charges;
  final UnitRepository _units;
  final Uuid _uuid;

  /// Generates one idempotent, editable bill draft for a tenancy and month.
  Future<Result<BillDraft>> generateDraft({
    required Tenancy tenancy,
    required BillingMonth period,
    BillGenerationValues values = const BillGenerationValues(),
    DateTime? issueDate,
    DateTime? dueDate,
  }) async {
    final Result<MonthlyBill?> existing = await _bills.findForPeriod(
      tenancy.id,
      period,
    );
    if (existing case Failure<MonthlyBill?>(:final failure)) {
      return Result<BillDraft>.failure(failure);
    }
    if ((existing as Success<MonthlyBill?>).value != null) {
      return Result<BillDraft>.failure(
        const ConflictError(
          'A bill already exists for this tenancy and month.',
        ),
      );
    }
    final Result<RentalUnit?> unitResult = await _units.findById(
      tenancy.unitId,
    );
    if (unitResult case Failure<RentalUnit?>(:final failure)) {
      return Result<BillDraft>.failure(failure);
    }
    final RentalUnit? unit = (unitResult as Success<RentalUnit?>).value;
    if (unit == null) {
      return Result<BillDraft>.failure(const NotFoundError('Unit not found.'));
    }
    final Result<List<RecurringChargeRule>> rulesResult = await _charges
        .listRules(tenancy.id);
    if (rulesResult case Failure<List<RecurringChargeRule>>(:final failure)) {
      return Result<BillDraft>.failure(failure);
    }
    final Result<Money> dueResult = await _bills.openingDue(tenancy.id, period);
    if (dueResult case Failure<Money>(:final failure)) {
      return Result<BillDraft>.failure(failure);
    }
    final DateTime generatedAt = (issueDate ?? DateTime.now()).toUtc();
    final Result<BillDraft> calculated = BillingEngine.calculate(
      BillingCalculationInput(
        billId: EntityId(_uuid.v4()),
        tenancy: tenancy,
        propertyId: unit.propertyId,
        period: period,
        issueDate: generatedAt,
        dueDate: dueDate,
        openingDue: (dueResult as Success<Money>).value,
        rules: (rulesResult as Success<List<RecurringChargeRule>>).value
            .where((RecurringChargeRule rule) => _effective(rule, period))
            .toList(growable: false),
        manualAmounts: values.manualAmounts,
        meterReadings: values.meterReadings,
      ),
    );
    if (calculated case Failure<BillDraft>(:final failure)) {
      return Result<BillDraft>.failure(failure);
    }
    final BillDraft draft = (calculated as Success<BillDraft>).value;
    final Result<void> saved = await _bills.saveDraft(draft);
    return switch (saved) {
      Success<void>() => Result<BillDraft>.success(draft),
      Failure<void>(:final failure) => Result<BillDraft>.failure(failure),
    };
  }

  /// Finalizes a draft; finalized snapshots are never recalculated in place.
  Future<Result<MonthlyBill>> finalize(EntityId billId) =>
      _bills.finalize(billId);

  /// Cancels a bill without deleting its audit-preserving snapshot.
  Future<Result<MonthlyBill>> cancel(EntityId billId) => _bills.cancel(billId);

  /// Creates drafts for all active tenancies in a property, retaining failures
  /// so the UI can highlight missing manual/meter values instead of aborting.
  Future<Result<BulkBillGeneration>> generateBulk({
    required EntityId propertyId,
    required BillingMonth period,
    required List<Tenancy> activeTenancies,
    Map<EntityId, BillGenerationValues> values =
        const <EntityId, BillGenerationValues>{},
  }) async {
    final List<MonthlyBill> created = <MonthlyBill>[];
    final Map<EntityId, AppFailure> skipped = <EntityId, AppFailure>{};
    for (final Tenancy tenancy in activeTenancies) {
      final Result<RentalUnit?> unitResult = await _units.findById(
        tenancy.unitId,
      );
      if (unitResult case Failure<RentalUnit?>(:final failure)) {
        skipped[tenancy.id] = failure;
        continue;
      }
      final RentalUnit? unit = (unitResult as Success<RentalUnit?>).value;
      if (unit == null || unit.propertyId != propertyId) {
        continue;
      }
      final Result<BillDraft> result = await generateDraft(
        tenancy: tenancy,
        period: period,
        values: values[tenancy.id] ?? const BillGenerationValues(),
      );
      switch (result) {
        case Success<BillDraft>(:final value):
          created.add(value.bill);
        case Failure<BillDraft>(:final failure):
          skipped[tenancy.id] = failure;
      }
    }
    return Result<BulkBillGeneration>.success(
      BulkBillGeneration(created: created, skipped: skipped),
    );
  }

  static bool _effective(RecurringChargeRule rule, BillingMonth period) =>
      rule.isActive &&
      rule.effectiveFrom.compareTo(period) <= 0 &&
      (rule.effectiveTo == null || rule.effectiveTo!.compareTo(period) >= 0);
}

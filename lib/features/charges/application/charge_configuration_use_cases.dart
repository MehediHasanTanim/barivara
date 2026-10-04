import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:uuid/uuid.dart';

/// Exact calculation result for a meter-based electricity period.
class MeterChargeCalculation {
  /// Creates an auditable meter calculation result.
  const MeterChargeCalculation({
    required this.consumption,
    required this.amount,
  });

  final int consumption;
  final Money amount;
}

/// Pure, integer-safe utility arithmetic shared by billing and UI previews.
abstract final class UtilityChargeCalculator {
  /// Calculates consumption × rate plus a fixed fee without floating point.
  static Result<MeterChargeCalculation> electricity({
    required MeterReading previous,
    required MeterReading current,
    required Money ratePerUnit,
    Money fixedFee = Money.zero,
  }) {
    if (current.value < previous.value) {
      return Result<MeterChargeCalculation>.failure(
        const ValidationError(
          'Current meter reading cannot be lower than the previous reading.',
        ),
      );
    }
    if (ratePerUnit.isNegative || fixedFee.isNegative) {
      return Result<MeterChargeCalculation>.failure(
        const ValidationError('Meter rate and fixed fee cannot be negative.'),
      );
    }
    final int consumption = current.value - previous.value;
    return Result<MeterChargeCalculation>.success(
      MeterChargeCalculation(
        consumption: consumption,
        amount: Money.fromPoisha(
          consumption * ratePerUnit.poisha + fixedFee.poisha,
        ),
      ),
    );
  }
}

/// Versioned configuration commands. They never rewrite bill snapshots.
class ChargeConfigurationUseCases {
  /// Creates charge configuration operations.
  ChargeConfigurationUseCases(this._repository, {Uuid? uuid})
    : _uuid = uuid ?? Uuid();

  final ChargeConfigurationRepository _repository;
  final Uuid _uuid;

  /// Saves a new effective-dated rule and closes the preceding open rule.
  Future<Result<RecurringChargeRule>> configureRule({
    required EntityId tenancyId,
    required ChargeType type,
    required ChargeCalculationMethod method,
    required Money fixedAmount,
    Money? ratePerUnit,
    required BillingMonth effectiveFrom,
  }) async {
    if (fixedAmount.isNegative || (ratePerUnit?.isNegative ?? false)) {
      return Result<RecurringChargeRule>.failure(
        const ValidationError('Charge amounts cannot be negative.'),
      );
    }
    if (method == ChargeCalculationMethod.meterRate && ratePerUnit == null) {
      return Result<RecurringChargeRule>.failure(
        const ValidationError('A meter-based rule requires a unit rate.'),
      );
    }
    final Result<List<RecurringChargeRule>> existing = await _repository
        .listRules(tenancyId);
    if (existing case Failure<List<RecurringChargeRule>>(:final failure)) {
      return Result<RecurringChargeRule>.failure(failure);
    }
    final List<RecurringChargeRule> prior =
        (existing as Success<List<RecurringChargeRule>>).value
            .where(
              (RecurringChargeRule rule) =>
                  rule.chargeType == type &&
                  rule.isActive &&
                  rule.effectiveFrom.compareTo(effectiveFrom) < 0 &&
                  rule.effectiveTo == null,
            )
            .toList(growable: false);
    for (final RecurringChargeRule old in prior) {
      final BillingMonth previousMonth = _previousMonth(effectiveFrom);
      final Result<void> closed = await _repository.saveRule(
        RecurringChargeRule(
          id: old.id,
          tenancyId: old.tenancyId,
          chargeType: old.chargeType,
          calculationMethod: old.calculationMethod,
          fixedAmount: old.fixedAmount,
          ratePerUnit: old.ratePerUnit,
          effectiveFrom: old.effectiveFrom,
          effectiveTo: previousMonth,
          isActive: old.isActive,
        ),
      );
      if (closed case Failure<void>(:final failure)) {
        return Result<RecurringChargeRule>.failure(failure);
      }
    }
    final RecurringChargeRule rule = RecurringChargeRule(
      id: EntityId(_uuid.v4()),
      tenancyId: tenancyId,
      chargeType: type,
      calculationMethod: method,
      fixedAmount: fixedAmount,
      ratePerUnit: ratePerUnit,
      effectiveFrom: effectiveFrom,
    );
    final Result<void> saved = await _repository.saveRule(rule);
    return switch (saved) {
      Success<void>() => Result<RecurringChargeRule>.success(rule),
      Failure<void>(:final failure) => Result<RecurringChargeRule>.failure(
        failure,
      ),
    };
  }

  /// Resolves the one rule applicable to a month, without touching bills.
  Future<Result<RecurringChargeRule?>> ruleForMonth(
    EntityId tenancyId,
    ChargeType type,
    BillingMonth month,
  ) => _repository.ruleForMonth(tenancyId, type, month);

  static BillingMonth _previousMonth(BillingMonth month) => month.month == 1
      ? BillingMonth(month.year - 1, 12)
      : BillingMonth(month.year, month.month - 1);
}

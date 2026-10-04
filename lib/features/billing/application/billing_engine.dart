import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/charges/application/charge_configuration_use_cases.dart';

/// Meter operands supplied for a single billing-period calculation.
class BillMeterReadings {
  /// Creates validated prior and current readings for a monthly bill.
  const BillMeterReadings({required this.previous, required this.current});

  final MeterReading previous;
  final MeterReading current;
}

/// All stable inputs required to calculate a bill with no database or UI work.
class BillingCalculationInput {
  /// Creates a bill calculation request.
  const BillingCalculationInput({
    required this.billId,
    required this.tenancy,
    required this.propertyId,
    required this.period,
    required this.issueDate,
    required this.openingDue,
    required this.rules,
    this.dueDate,
    this.manualAmounts = const <ChargeType, Money>{},
    this.meterReadings = const <ChargeType, BillMeterReadings>{},
  });

  final EntityId billId;
  final Tenancy tenancy;
  final EntityId propertyId;
  final BillingMonth period;
  final DateTime issueDate;
  final DateTime? dueDate;
  final Money openingDue;
  final List<RecurringChargeRule> rules;
  final Map<ChargeType, Money> manualAmounts;
  final Map<ChargeType, BillMeterReadings> meterReadings;
}

/// A pure deterministic billing engine. It never queries persistence or UI.
abstract final class BillingEngine {
  /// Builds an itemized bill snapshot using integer-poisha arithmetic only.
  static Result<BillDraft> calculate(BillingCalculationInput input) {
    if (input.openingDue.isNegative) {
      return Result<BillDraft>.failure(
        const ValidationError('Opening due cannot be negative.'),
      );
    }
    final BillingMonth moveInMonth = BillingMonth.fromDate(
      input.tenancy.moveInDate,
    );
    if (input.period.compareTo(moveInMonth) < 0) {
      return Result<BillDraft>.failure(
        const ValidationError(
          'A bill cannot be created before the move-in month.',
        ),
      );
    }
    final DateTime? movedOut = input.tenancy.actualMoveOutDate;
    if (movedOut != null &&
        input.period.compareTo(BillingMonth.fromDate(movedOut)) > 0) {
      return Result<BillDraft>.failure(
        const ValidationError(
          'A bill cannot be created after the move-out month.',
        ),
      );
    }

    final List<BillLineItem> items = <BillLineItem>[];
    void add({
      required ChargeType type,
      required String description,
      required Money amount,
      EntityId? ruleId,
      int? quantity,
      Money? unitRate,
      MeterReading? previous,
      MeterReading? current,
    }) {
      items.add(
        BillLineItem(
          id: EntityId('${input.billId.value}-${type.name}-${items.length}'),
          billId: input.billId,
          type: type,
          description: description,
          amount: amount,
          displayOrder: items.length,
          sourceRuleId: ruleId,
          quantity: quantity,
          unitRate: unitRate,
          previousReading: previous,
          currentReading: current,
        ),
      );
    }

    // MVP policy: charge the agreed full month from move-in. Proration is an
    // explicit future policy, not an implicit rounding decision.
    add(
      type: ChargeType.rent,
      description: 'Rent',
      amount: input.tenancy.agreedRent,
    );
    for (final RecurringChargeRule rule in input.rules) {
      if (rule.chargeType == ChargeType.rent ||
          rule.chargeType == ChargeType.previousDue ||
          !rule.isActive) {
        continue;
      }
      switch (rule.calculationMethod) {
        case ChargeCalculationMethod.fixed:
          add(
            type: rule.chargeType,
            description: _label(rule.chargeType),
            amount: rule.fixedAmount,
            ruleId: rule.id,
          );
        case ChargeCalculationMethod.manual:
          final Money? amount = input.manualAmounts[rule.chargeType];
          if (amount == null) {
            return Result<BillDraft>.failure(
              ValidationError('${_label(rule.chargeType)} amount is required.'),
            );
          }
          if (amount.isNegative) {
            return Result<BillDraft>.failure(
              ValidationError('${_label(rule.chargeType)} cannot be negative.'),
            );
          }
          add(
            type: rule.chargeType,
            description: _label(rule.chargeType),
            amount: amount,
            ruleId: rule.id,
          );
        case ChargeCalculationMethod.meterRate:
          final BillMeterReadings? readings =
              input.meterReadings[rule.chargeType];
          if (readings == null || rule.ratePerUnit == null) {
            return Result<BillDraft>.failure(
              ValidationError(
                '${_label(rule.chargeType)} reading is required.',
              ),
            );
          }
          final Result<MeterChargeCalculation> result =
              UtilityChargeCalculator.electricity(
                previous: readings.previous,
                current: readings.current,
                ratePerUnit: rule.ratePerUnit!,
                fixedFee: rule.fixedAmount,
              );
          if (result case Failure<MeterChargeCalculation>(:final failure)) {
            return Result<BillDraft>.failure(failure);
          }
          final MeterChargeCalculation calculation =
              (result as Success<MeterChargeCalculation>).value;
          add(
            type: rule.chargeType,
            description: _label(rule.chargeType),
            amount: calculation.amount,
            ruleId: rule.id,
            quantity: calculation.consumption,
            unitRate: rule.ratePerUnit,
            previous: readings.previous,
            current: readings.current,
          );
        case ChargeCalculationMethod.previousBalance:
          // Opening due is calculated once from finalized source bills below.
          break;
      }
    }
    if (input.openingDue.poisha > 0) {
      add(
        type: ChargeType.previousDue,
        description: 'Previous due',
        amount: input.openingDue,
      );
    }
    final Money currentCharges = items
        .where((BillLineItem item) => item.type != ChargeType.previousDue)
        .fold(
          Money.zero,
          (Money total, BillLineItem item) => total + item.amount,
        );
    final Money total = items.fold(
      Money.zero,
      (Money value, BillLineItem item) => value + item.amount,
    );
    return Result<BillDraft>.success(
      BillDraft(
        bill: MonthlyBill(
          id: input.billId,
          tenancyId: input.tenancy.id,
          propertyId: input.propertyId,
          unitId: input.tenancy.unitId,
          period: input.period,
          issueDate: input.issueDate,
          dueDate: input.dueDate,
          openingDue: input.openingDue,
          currentCharges: currentCharges,
          total: total,
          paidAmount: Money.zero,
          outstandingAmount: total,
          status: BillStatus.draft,
          generatedAt: input.issueDate,
        ),
        items: List<BillLineItem>.unmodifiable(items),
      ),
    );
  }

  static String _label(ChargeType type) => switch (type) {
    ChargeType.rent => 'Rent',
    ChargeType.electricity => 'Electricity',
    ChargeType.gas => 'Gas',
    ChargeType.water => 'Water',
    ChargeType.serviceCharge => 'Service charge',
    ChargeType.previousDue => 'Previous due',
    ChargeType.repairCharge => 'Repair charge',
    ChargeType.discount => 'Discount',
    ChargeType.adjustment => 'Adjustment',
    ChargeType.other => 'Other charge',
  };
}

import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds exact fixed-charge, opening-due bill totals', () {
    final BillDraft draft = _success(
      _calculate(
        openingDue: Money.fromTaka(2000),
        rules: <RecurringChargeRule>[
          _rule(ChargeType.gas, ChargeCalculationMethod.fixed, 1080),
          _rule(ChargeType.water, ChargeCalculationMethod.fixed, 500),
        ],
      ),
    );
    expect(draft.bill.currentCharges, Money.fromTaka(16580));
    expect(draft.bill.total, Money.fromTaka(18580));
    expect(draft.items.last.type, ChargeType.previousDue);
  });

  test('calculates metered electricity with exact integer poisha', () {
    final BillDraft draft = _success(
      _calculate(
        rules: <RecurringChargeRule>[
          _rule(
            ChargeType.electricity,
            ChargeCalculationMethod.meterRate,
            50,
            rate: Money.fromPoisha(1250),
          ),
        ],
        readings: <ChargeType, BillMeterReadings>{
          ChargeType.electricity: BillMeterReadings(
            previous: MeterReading(450),
            current: MeterReading(500),
          ),
        },
      ),
    );
    final BillLineItem electricity = draft.items.singleWhere(
      (BillLineItem item) => item.type == ChargeType.electricity,
    );
    expect(electricity.quantity, 50);
    expect(electricity.amount, Money.fromTaka(675));
    expect(electricity.previousReading?.value, 450);
  });

  test('requires manual amounts and rejects invalid meter consumption', () {
    expect(
      _calculate(
        rules: <RecurringChargeRule>[
          _rule(ChargeType.water, ChargeCalculationMethod.manual, 0),
        ],
      ),
      isA<Failure<BillDraft>>(),
    );
    expect(
      _calculate(
        rules: <RecurringChargeRule>[
          _rule(
            ChargeType.electricity,
            ChargeCalculationMethod.meterRate,
            0,
            rate: Money.fromTaka(8),
          ),
        ],
        readings: <ChargeType, BillMeterReadings>{
          ChargeType.electricity: BillMeterReadings(
            previous: MeterReading(50),
            current: MeterReading(49),
          ),
        },
      ),
      isA<Failure<BillDraft>>(),
    );
  });

  test('uses the supplied effective rent and applies full move-in month', () {
    final Tenancy tenancy = _tenancy(agreedRent: Money.fromTaka(16000));
    final BillDraft draft = _success(
      _calculate(tenancy: tenancy, period: BillingMonth(2026, 10)),
    );
    expect(draft.bill.currentCharges, Money.fromTaka(16000));
    expect(
      _calculate(tenancy: tenancy, period: BillingMonth(2026, 9)),
      isA<Failure<BillDraft>>(),
    );
  });

  test('permanent twelve-month golden dataset remains deterministic', () {
    final List<int> expectedTotals = <int>[
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
      16500,
    ];
    final List<int> totals = <int>[];
    for (int month = 1; month <= 12; month++) {
      final BillDraft draft = _success(
        _calculate(
          period: BillingMonth(2026, month),
          tenancy: _tenancy(moveInDate: DateTime.utc(2026, 1, 1)),
          rules: <RecurringChargeRule>[
            _rule(ChargeType.gas, ChargeCalculationMethod.fixed, 1000),
            _rule(ChargeType.water, ChargeCalculationMethod.fixed, 500),
          ],
        ),
      );
      totals.add(draft.bill.total.poisha ~/ Money.poishaPerTaka);
    }
    expect(totals, expectedTotals);
  });
}

Result<BillDraft> _calculate({
  Tenancy? tenancy,
  BillingMonth? period,
  Money openingDue = Money.zero,
  List<RecurringChargeRule> rules = const <RecurringChargeRule>[],
  Map<ChargeType, BillMeterReadings> readings =
      const <ChargeType, BillMeterReadings>{},
}) => BillingEngine.calculate(
  BillingCalculationInput(
    billId: EntityId('bill-${period?.key ?? '2026-10'}'),
    tenancy: tenancy ?? _tenancy(),
    propertyId: EntityId('property-1'),
    period: period ?? BillingMonth(2026, 10),
    issueDate: DateTime.utc(2026, 10, 1),
    openingDue: openingDue,
    rules: rules,
    meterReadings: readings,
  ),
);

BillDraft _success(Result<BillDraft> result) =>
    (result as Success<BillDraft>).value;

Tenancy _tenancy({
  Money agreedRent = const Money.fromPoisha(1500000),
  DateTime? moveInDate,
}) => Tenancy(
  id: EntityId('tenancy-1'),
  tenantId: EntityId('tenant-1'),
  unitId: EntityId('unit-1'),
  moveInDate: moveInDate ?? DateTime.utc(2026, 10, 16),
  agreedRent: agreedRent,
  billingDay: 5,
);

RecurringChargeRule _rule(
  ChargeType type,
  ChargeCalculationMethod method,
  int taka, {
  Money? rate,
}) => RecurringChargeRule(
  id: EntityId('rule-${type.name}'),
  tenancyId: EntityId('tenancy-1'),
  chargeType: type,
  calculationMethod: method,
  fixedAmount: Money.fromTaka(taka),
  ratePerUnit: rate,
  effectiveFrom: BillingMonth(2026, 1),
);

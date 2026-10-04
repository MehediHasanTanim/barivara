import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/deposits/application/deposit_settlement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('records receipts, deductions and partial/full refunds safely', () {
    expect(
      (DepositSettlement.apply(
        balance: Money.zero,
        type: DepositTransactionType.received,
        amount: Money.fromTaka(30000),
      ) as Success<Money>).value,
      Money.fromTaka(30000),
    );
    expect(
      (DepositSettlement.apply(
        balance: Money.fromTaka(30000),
        type: DepositTransactionType.deduction,
        amount: Money.fromTaka(5000),
        reason: 'Damage',
      ) as Success<Money>).value,
      Money.fromTaka(25000),
    );
    expect(
      DepositSettlement.apply(
        balance: Money.fromTaka(1000),
        type: DepositTransactionType.refund,
        amount: Money.fromTaka(2000),
      ),
      isA<Failure<Money>>(),
    );
  });
  test('calculates move-out settlement', () {
    final value = DepositSettlement.calculate(
      outstanding: Money.fromTaka(12000),
      repairCharges: Money.fromTaka(3000),
      credits: Money.fromTaka(1000),
      depositBalance: Money.fromTaka(10000),
    );
    expect(value.depositApplied, Money.fromTaka(10000));
    expect(value.finalPayable, Money.fromTaka(4000));
  });
}

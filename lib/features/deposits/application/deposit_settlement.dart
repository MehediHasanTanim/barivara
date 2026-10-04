import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';

/// Pure deposit-ledger and move-out settlement arithmetic.
abstract final class DepositSettlement {
  /// Applies a deposit movement, rejecting refunds/deductions beyond funds held.
  static Result<Money> apply({
    required Money balance,
    required DepositTransactionType type,
    required Money amount,
    String? reason,
  }) {
    if (amount.poisha <= 0) {
      return Result<Money>.failure(
        const ValidationError('Deposit amount must be greater than zero.'),
      );
    }
    final bool outgoing =
        type == DepositTransactionType.refund ||
        type == DepositTransactionType.deduction ||
        type == DepositTransactionType.transferToDue;
    if ((type == DepositTransactionType.deduction ||
            type == DepositTransactionType.transferToDue) &&
        (reason == null || reason.trim().isEmpty)) {
      return Result<Money>.failure(
        const ValidationError('A deduction or transfer reason is required.'),
      );
    }
    if (outgoing && amount.compareTo(balance) > 0) {
      return Result<Money>.failure(
        const ValidationError('Amount exceeds the held deposit balance.'),
      );
    }
    return Result<Money>.success(
      outgoing ? balance - amount : balance + amount,
    );
  }

  /// Calculates outstanding rent/utilities plus repairs minus credits/deposit.
  static MoveOutSettlement calculate({
    required Money outstanding,
    required Money repairCharges,
    required Money credits,
    required Money depositBalance,
  }) {
    final Money net = outstanding + repairCharges - credits;
    final Money applied = net.poisha <= 0
        ? Money.zero
        : Money.fromPoisha(
            net.poisha < depositBalance.poisha
                ? net.poisha
                : depositBalance.poisha,
          );
    return MoveOutSettlement(
      outstanding: outstanding,
      repairCharges: repairCharges,
      credits: credits,
      depositApplied: applied,
      finalPayable: net - applied,
    );
  }
}

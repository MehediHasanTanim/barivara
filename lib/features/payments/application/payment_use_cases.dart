import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:uuid/uuid.dart';

/// User-entered details for a locally recorded payment.
class PaymentInput {
  /// Creates a payment-entry request.
  const PaymentInput({
    required this.amount,
    required this.paymentDate,
    required this.method,
    this.reference,
    this.note,
  });

  final Money amount;
  final DateTime paymentDate;
  final PaymentMethod method;
  final String? reference;
  final String? note;
}

/// Payment posting, allocation, due summary, and reversal commands.
class PaymentUseCases {
  /// Creates payment ledger operations.
  PaymentUseCases(this._payments, this._bills, {Uuid? uuid})
    : _uuid = uuid ?? Uuid();

  final PaymentRepository _payments;
  final BillingRepository _bills;
  final Uuid _uuid;

  /// Records a payment against the tenancy's oldest outstanding bills first.
  /// Excess money is rejected: an explicit advance/credit flow is required.
  Future<Result<PaymentPosting>> record({
    required Tenancy tenancy,
    required PaymentInput input,
  }) async {
    if (input.amount.poisha <= 0) {
      return Result<PaymentPosting>.failure(
        const ValidationError('Payment amount must be greater than zero.'),
      );
    }
    final Result<List<MonthlyBill>> outstandingResult = await _bills
        .listOutstandingByTenancy(tenancy.id);
    if (outstandingResult case Failure<List<MonthlyBill>>(:final failure)) {
      return Result<PaymentPosting>.failure(failure);
    }
    final List<MonthlyBill> outstanding =
        (outstandingResult as Success<List<MonthlyBill>>).value;
    final Money available = outstanding.fold(
      Money.zero,
      (Money total, MonthlyBill bill) => total + bill.outstandingAmount,
    );
    if (input.amount.compareTo(available) > 0) {
      return Result<PaymentPosting>.failure(
        const ValidationError(
          'Payment is greater than outstanding due. Record excess as advance credit instead.',
        ),
      );
    }
    final DateTime now = DateTime.now().toUtc();
    final Payment payment = Payment(
      id: EntityId(_uuid.v4()),
      tenancyId: tenancy.id,
      tenantId: tenancy.tenantId,
      amount: input.amount,
      paymentDate: input.paymentDate.toUtc(),
      method: input.method,
      reference: _optional(input.reference),
      note: _optional(input.note),
      createdAt: now,
    );
    int remaining = input.amount.poisha;
    final List<PaymentAllocation> allocations = <PaymentAllocation>[];
    for (final MonthlyBill bill in outstanding) {
      if (remaining == 0) {
        break;
      }
      final int amount = remaining < bill.outstandingAmount.poisha
          ? remaining
          : bill.outstandingAmount.poisha;
      allocations.add(
        PaymentAllocation(
          id: EntityId(_uuid.v4()),
          paymentId: payment.id,
          billId: bill.id,
          amount: Money.fromPoisha(amount),
        ),
      );
      remaining -= amount;
    }
    if (remaining != 0 || allocations.isEmpty) {
      return Result<PaymentPosting>.failure(
        const ConflictError(
          'No eligible finalized bill is available for payment.',
        ),
      );
    }
    final PaymentPosting posting = PaymentPosting(
      payment: payment,
      allocations: List<PaymentAllocation>.unmodifiable(allocations),
    );
    final Result<void> saved = await _payments.post(posting);
    return switch (saved) {
      Success<void>() => Result<PaymentPosting>.success(posting),
      Failure<void>(:final failure) => Result<PaymentPosting>.failure(failure),
    };
  }

  /// Provides a current/previous/total split for a tenancy's outstanding dues.
  Future<Result<DueSummary>> dueSummary(
    EntityId tenancyId, {
    BillingMonth? currentMonth,
  }) async {
    final Result<List<MonthlyBill>> result = await _bills
        .listOutstandingByTenancy(tenancyId);
    if (result case Failure<List<MonthlyBill>>(:final failure)) {
      return Result<DueSummary>.failure(failure);
    }
    final BillingMonth month =
        currentMonth ?? BillingMonth.fromDate(DateTime.now());
    Money current = Money.zero;
    Money previous = Money.zero;
    for (final MonthlyBill bill
        in (result as Success<List<MonthlyBill>>).value) {
      if (bill.period == month) {
        current += bill.outstandingAmount;
      } else if (bill.period.compareTo(month) < 0) {
        previous += bill.outstandingAmount;
      }
    }
    return Result<DueSummary>.success(
      DueSummary(
        currentMonthDue: current,
        previousOverdue: previous,
        totalOutstanding: current + previous,
      ),
    );
  }

  /// Reverses a posted payment without deleting its original ledger record.
  Future<Result<Payment>> reverse(EntityId paymentId, String reason) {
    if (reason.trim().isEmpty) {
      return Future<Result<Payment>>.value(
        Result<Payment>.failure(
          const ValidationError('A reversal reason is required.'),
        ),
      );
    }
    return _payments.reverse(paymentId, reason.trim());
  }

  Future<Result<List<Payment>>> history() => _payments.listAll();

  static String? _optional(String? value) {
    final String? normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}

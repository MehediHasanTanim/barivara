import 'package:collection/collection.dart';

/// Stable, portable identifier used by all user-owned records.
class EntityId {
  /// Creates an ID from a validated non-empty string.
  EntityId(String value) : value = _validate(value);

  static String _validate(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'An entity ID cannot be empty.',
      );
    }
    return value;
  }

  /// String representation persisted by repositories and backup files.
  final String value;

  @override
  bool operator ==(Object other) => other is EntityId && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}

/// Exact monetary amount stored as integer poisha, never floating point.
class Money implements Comparable<Money> {
  /// Creates an amount from integer poisha.
  const Money.fromPoisha(this.poisha);

  /// Creates an exact whole-taka amount.
  factory Money.fromTaka(int taka) => Money.fromPoisha(taka * poishaPerTaka);

  /// Number of poisha in one Bangladeshi Taka.
  static const int poishaPerTaka = 100;

  /// A zero amount.
  static const Money zero = Money.fromPoisha(0);

  /// Persisted amount in poisha.
  final int poisha;

  /// Adds two exact money amounts.
  Money operator +(Money other) => Money.fromPoisha(poisha + other.poisha);

  /// Subtracts two exact money amounts.
  Money operator -(Money other) => Money.fromPoisha(poisha - other.poisha);

  /// Returns the negative amount.
  Money operator -() => Money.fromPoisha(-poisha);

  /// Returns true for amounts below zero.
  bool get isNegative => poisha < 0;

  @override
  int compareTo(Money other) => poisha.compareTo(other.poisha);

  @override
  bool operator ==(Object other) => other is Money && other.poisha == poisha;

  @override
  int get hashCode => poisha.hashCode;
}

/// Gregorian billing period stored as a numeric year and month.
class BillingMonth implements Comparable<BillingMonth> {
  /// Creates a billing period.
  BillingMonth(this.year, this.month)
    : assert(year >= 2000),
      assert(month >= 1 && month <= 12);

  /// Creates a period from a date.
  factory BillingMonth.fromDate(DateTime value) =>
      BillingMonth(value.year, value.month);

  /// Calendar year.
  final int year;

  /// Calendar month from 1 through 12.
  final int month;

  /// Stable format for uniqueness keys and backup data.
  String get key => '$year-${month.toString().padLeft(2, '0')}';

  @override
  int compareTo(BillingMonth other) => key.compareTo(other.key);

  @override
  bool operator ==(Object other) =>
      other is BillingMonth && other.year == year && other.month == month;

  @override
  int get hashCode => Object.hash(year, month);
}

/// Inclusive local date range for a query or report.
class DateRange {
  /// Creates a date range where [start] is not after [end].
  DateRange(this.start, this.end)
    : assert(!start.isAfter(end), 'Start date must not be after end date.');

  /// First date in the range.
  final DateTime start;

  /// Last date in the range.
  final DateTime end;

  /// Whether [value] lies within the inclusive date range.
  bool contains(DateTime value) =>
      !value.isBefore(start) && !value.isAfter(end);
}

/// Loosely validated tenant phone number retained in canonical display form.
class PhoneNumber {
  /// Creates a phone number after removing ordinary display separators.
  PhoneNumber(String value) : value = _normalize(value);

  static String _normalize(String value) {
    final String normalized = value.replaceAll(RegExp(r'[\s()-]'), '');
    if (normalized.length < 7) {
      throw ArgumentError.value(value, 'value', 'A phone number is too short.');
    }
    return normalized;
  }

  /// Persistable phone representation.
  final String value;
}

/// Immutable meter-reading input used for validation and billing calculation.
class MeterReading {
  /// Creates a non-negative meter reading.
  MeterReading(this.value)
    : assert(value >= 0, 'Meter readings cannot be negative.');

  /// Raw meter value, kept separately from money values.
  final int value;
}

/// Canonical financial charge categories.
enum ChargeType {
  /// Monthly agreed rent.
  rent,

  /// Electricity charge.
  electricity,

  /// Gas charge.
  gas,

  /// Water charge.
  water,

  /// Building/service charge.
  serviceCharge,

  /// Carried-forward unpaid balance.
  previousDue,

  /// Repair amount recoverable from a tenant.
  repairCharge,

  /// Other charge.
  other,

  /// A deduction from a bill.
  discount,

  /// Explicit financial correction.
  adjustment,
}

/// Supported locally recorded payment methods.
enum PaymentMethod { cash, bkash, nagad, rocket, bankTransfer, cheque, other }

/// Equality helper reserved for future value-type collections.
const Equality<Object?> valueEquality = DeepCollectionEquality();

import 'package:barivara/core/domain/value_types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Money retains exact poisha arithmetic without floating point', () {
    const Money first = Money.fromPoisha(1951050);
    const Money second = Money.fromPoisha(49950);

    expect((first + second).poisha, 2001000);
    expect((first - second).poisha, 1901100);
    expect(Money.fromTaka(15000).poisha, 1500000);
  });

  test('BillingMonth has a sortable and stable persisted key', () {
    expect(BillingMonth(2026, 10).key, '2026-10');
    expect(
      BillingMonth(2026, 9).compareTo(BillingMonth(2026, 10)),
      lessThan(0),
    );
  });
}

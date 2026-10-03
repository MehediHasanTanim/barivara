import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BariVaraFormatters', () {
    test('formats exact BDT values with English or Bengali digits', () {
      const Money amount = Money.fromPoisha(1951000);

      expect(
        BariVaraFormatters.money(amount, digitStyle: DigitStyle.english),
        '৳19,510',
      );
      expect(
        BariVaraFormatters.money(amount, digitStyle: DigitStyle.bengali),
        '৳১৯,৫১০',
      );
      expect(
        BariVaraFormatters.money(
          const Money.fromPoisha(-125),
          digitStyle: DigitStyle.english,
          showMinorUnits: true,
        ),
        '-৳1.25',
      );
    });

    test('uses the shared Bengali and English billing-month presentation', () {
      final BillingMonth month = BillingMonth(2026, 10);

      expect(
        BariVaraFormatters.billingMonth(
          month,
          language: AppLanguage.english,
          digitStyle: DigitStyle.english,
        ),
        'October 2026',
      );
      expect(
        BariVaraFormatters.billingMonth(
          month,
          language: AppLanguage.bengali,
          digitStyle: DigitStyle.bengali,
        ),
        'অক্টোবর ২০২৬',
      );
    });
  });
}

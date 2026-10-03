import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:intl/intl.dart';

/// Centralized Bangladesh-aware formatting for UI, receipts, and reports.
abstract final class BariVaraFormatters {
  static const List<String> _bengaliMonths = <String>[
    'জানুয়ারি',
    'ফেব্রুয়ারি',
    'মার্চ',
    'এপ্রিল',
    'মে',
    'জুন',
    'জুলাই',
    'আগস্ট',
    'সেপ্টেম্বর',
    'অক্টোবর',
    'নভেম্বর',
    'ডিসেম্বর',
  ];

  /// Formats BDT from exact integer poisha without using floating point.
  static String money(
    Money value, {
    required DigitStyle digitStyle,
    bool showMinorUnits = false,
  }) {
    final bool negative = value.poisha < 0;
    final int absolutePoisha = value.poisha.abs();
    final int taka = absolutePoisha ~/ Money.poishaPerTaka;
    final int poisha = absolutePoisha % Money.poishaPerTaka;
    String result = NumberFormat.decimalPattern('en_US').format(taka);
    if (showMinorUnits && poisha != 0) {
      result = '$result.${poisha.toString().padLeft(2, '0')}';
    }
    if (digitStyle == DigitStyle.bengali) {
      result = bengaliDigits(result);
    }
    return '${negative ? '-' : ''}৳$result';
  }

  /// Formats an integer such as a meter reading using the selected digits.
  static String integer(int value, {required DigitStyle digitStyle}) {
    String result = NumberFormat.decimalPattern('en_US').format(value);
    if (digitStyle == DigitStyle.bengali) {
      result = bengaliDigits(result);
    }
    return result;
  }

  /// Formats a billing period consistently for screens and receipts.
  static String billingMonth(
    BillingMonth value, {
    required AppLanguage language,
    required DigitStyle digitStyle,
  }) {
    if (language == AppLanguage.bengali) {
      final String year = digitStyle == DigitStyle.bengali
          ? bengaliDigits(value.year.toString())
          : value.year.toString();
      return '${_bengaliMonths[value.month - 1]} $year';
    }
    return DateFormat(
      'MMMM y',
      'en_US',
    ).format(DateTime(value.year, value.month));
  }

  /// Converts Latin decimal digits to Bengali decimal digits.
  static String bengaliDigits(String value) {
    const String latin = '0123456789';
    const String bengali = '০১২৩৪৫৬৭৮৯';
    return value.split('').map((String character) {
      final int index = latin.indexOf(character);
      return index == -1 ? character : bengali[index];
    }).join();
  }
}

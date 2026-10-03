import 'package:barivara/app/app.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the English application shell without overflow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialAppSettingsProvider.overrideWithValue(
            const AppSettingsState(
              language: AppLanguage.english,
              digitStyle: DigitStyle.english,
              onboardingComplete: true,
            ),
          ),
        ],
        child: const BariVaraApp(),
      ),
    );

    expect(find.text('Bari Vara'), findsWidgets);
    expect(find.text('Rent management'), findsOneWidget);
    expect(find.text('Payments & Dues'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the Bengali application shell without overflow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialAppSettingsProvider.overrideWithValue(
            const AppSettingsState(onboardingComplete: true),
          ),
        ],
        child: const BariVaraApp(),
      ),
    );

    expect(find.text('বাড়ি ভাড়া'), findsWidgets);
    expect(find.text('বাড়ি ভাড়া ব্যবস্থাপনা'), findsOneWidget);
    expect(find.text('পেমেন্ট ও বকেয়া'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

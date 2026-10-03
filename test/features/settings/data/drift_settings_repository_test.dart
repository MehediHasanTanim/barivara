import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/settings/data/drift_settings_repository.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'persists complete application settings in the local database',
    () async {
      final AppDatabase database = AppDatabase.forTesting(
        NativeDatabase.memory(),
      );
      addTearDown(database.close);
      final DriftSettingsRepository repository = DriftSettingsRepository(
        database,
      );
      const AppSettingsState configured = AppSettingsState(
        language: AppLanguage.english,
        digitStyle: DigitStyle.english,
        theme: AppThemePreference.dark,
        receiptLanguage: AppLanguage.english,
        defaultPaymentMethod: 'bkash',
        defaultPropertyId: 'property-1',
        reminders: ReminderPreferences(
          rentDueEnabled: true,
          backupEnabled: true,
        ),
        onboardingComplete: true,
      );

      expect(await repository.save(configured), isA<Success<void>>());
      final Result<AppSettingsState> result = await repository.load();

      expect(result, isA<Success<AppSettingsState>>());
      final AppSettingsState saved =
          (result as Success<AppSettingsState>).value;
      expect(saved.language, AppLanguage.english);
      expect(saved.digitStyle, DigitStyle.english);
      expect(saved.theme, AppThemePreference.dark);
      expect(saved.receiptLanguage, AppLanguage.english);
      expect(saved.defaultPaymentMethod, 'bkash');
      expect(saved.defaultPropertyId, 'property-1');
      expect(saved.reminders.rentDueEnabled, isTrue);
      expect(saved.reminders.backupEnabled, isTrue);
      expect(saved.onboardingComplete, isTrue);
    },
  );
}

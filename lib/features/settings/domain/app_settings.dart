/// Supported application interface languages.
enum AppLanguage {
  /// English interface text.
  english('en'),

  /// Bengali interface text.
  bengali('bn');

  const AppLanguage(this.localeCode);

  /// Persisted BCP-47 locale code.
  final String localeCode;

  /// Parses a stored locale code, falling back to Bengali for the local MVP.
  static AppLanguage fromCode(String? value) => switch (value) {
    'en' => AppLanguage.english,
    _ => AppLanguage.bengali,
  };
}

/// Preferred numeral glyphs for user-visible values.
enum DigitStyle {
  /// Latin digits, for example 15,000.
  english('en'),

  /// Bengali digits, for example ১৫,০০০.
  bengali('bn');

  const DigitStyle(this.storageValue);

  /// Stable preference representation.
  final String storageValue;

  /// Parses a stored digit-style preference.
  static DigitStyle fromValue(String? value) => switch (value) {
    'bn' => DigitStyle.bengali,
    _ => DigitStyle.english,
  };
}

/// Persisted visual theme choice.
enum AppThemePreference {
  /// Always use the light theme.
  light,

  /// Always use the dark theme.
  dark,

  /// Follow the operating-system theme.
  system;

  /// Parses a stored preference, falling back to the system choice.
  static AppThemePreference fromValue(String? value) => switch (value) {
    'light' => AppThemePreference.light,
    'dark' => AppThemePreference.dark,
    _ => AppThemePreference.system,
  };
}

/// Reminder switches stored locally before scheduling is introduced.
class ReminderPreferences {
  /// Creates local reminder preferences.
  const ReminderPreferences({
    this.rentDueEnabled = false,
    this.backupEnabled = false,
  });

  /// Whether rent due reminders are enabled.
  final bool rentDueEnabled;

  /// Whether backup reminders are enabled.
  final bool backupEnabled;

  /// Returns a copy with the supplied values replaced.
  ReminderPreferences copyWith({bool? rentDueEnabled, bool? backupEnabled}) {
    return ReminderPreferences(
      rentDueEnabled: rentDueEnabled ?? this.rentDueEnabled,
      backupEnabled: backupEnabled ?? this.backupEnabled,
    );
  }
}

/// Non-financial application preferences persisted in the local database.
class AppSettingsState {
  /// Creates application settings.
  const AppSettingsState({
    this.language = AppLanguage.bengali,
    this.digitStyle = DigitStyle.bengali,
    this.theme = AppThemePreference.system,
    this.receiptLanguage = AppLanguage.bengali,
    this.defaultPaymentMethod = 'cash',
    this.defaultPropertyId,
    this.reminders = const ReminderPreferences(),
    this.onboardingComplete = false,
  });

  /// Bengali-first UI preference.
  final AppLanguage language;

  /// Display numeral preference; stored data always remains numeric.
  final DigitStyle digitStyle;

  /// Light, dark, or system display preference.
  final AppThemePreference theme;

  /// Language to use for generated receipts.
  final AppLanguage receiptLanguage;

  /// Default method suggested when entering a payment.
  final String defaultPaymentMethod;

  /// Optional property selected as the default context.
  final String? defaultPropertyId;

  /// Locally managed reminder switches.
  final ReminderPreferences reminders;

  /// Whether first-run language selection has been completed.
  final bool onboardingComplete;

  /// Reconstructs settings from key/value storage.
  factory AppSettingsState.fromStorage(Map<String, String> values) {
    bool readBool(String key) => values[key] == 'true';
    return AppSettingsState(
      language: AppLanguage.fromCode(values[AppSettingsKey.language]),
      digitStyle: DigitStyle.fromValue(values[AppSettingsKey.digitStyle]),
      theme: AppThemePreference.fromValue(values[AppSettingsKey.theme]),
      receiptLanguage: AppLanguage.fromCode(
        values[AppSettingsKey.receiptLanguage],
      ),
      defaultPaymentMethod:
          values[AppSettingsKey.defaultPaymentMethod] ?? 'cash',
      defaultPropertyId: values[AppSettingsKey.defaultPropertyId],
      reminders: ReminderPreferences(
        rentDueEnabled: readBool(AppSettingsKey.rentDueReminder),
        backupEnabled: readBool(AppSettingsKey.backupReminder),
      ),
      onboardingComplete: readBool(AppSettingsKey.onboardingComplete),
    );
  }

  /// Produces the stable local values needed for the settings table.
  Map<String, String> toStorage() {
    final Map<String, String> values = <String, String>{
      AppSettingsKey.language: language.localeCode,
      AppSettingsKey.digitStyle: digitStyle.storageValue,
      AppSettingsKey.theme: theme.name,
      AppSettingsKey.receiptLanguage: receiptLanguage.localeCode,
      AppSettingsKey.defaultPaymentMethod: defaultPaymentMethod,
      AppSettingsKey.rentDueReminder: reminders.rentDueEnabled.toString(),
      AppSettingsKey.backupReminder: reminders.backupEnabled.toString(),
      AppSettingsKey.onboardingComplete: onboardingComplete.toString(),
    };
    if (defaultPropertyId != null) {
      values[AppSettingsKey.defaultPropertyId] = defaultPropertyId!;
    }
    return values;
  }

  /// Returns a copy with selected settings updated.
  AppSettingsState copyWith({
    AppLanguage? language,
    DigitStyle? digitStyle,
    AppThemePreference? theme,
    AppLanguage? receiptLanguage,
    String? defaultPaymentMethod,
    String? defaultPropertyId,
    bool clearDefaultProperty = false,
    ReminderPreferences? reminders,
    bool? onboardingComplete,
  }) {
    return AppSettingsState(
      language: language ?? this.language,
      digitStyle: digitStyle ?? this.digitStyle,
      theme: theme ?? this.theme,
      receiptLanguage: receiptLanguage ?? this.receiptLanguage,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      defaultPropertyId: clearDefaultProperty
          ? null
          : defaultPropertyId ?? this.defaultPropertyId,
      reminders: reminders ?? this.reminders,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}

/// Stable settings-table keys, isolated from presentation labels.
abstract final class AppSettingsKey {
  static const String language = 'preferred_language';
  static const String digitStyle = 'digit_style';
  static const String theme = 'theme_mode';
  static const String receiptLanguage = 'receipt_language';
  static const String defaultPaymentMethod = 'default_payment_method';
  static const String defaultPropertyId = 'default_property_id';
  static const String rentDueReminder = 'rent_due_reminder';
  static const String backupReminder = 'backup_reminder';
  static const String onboardingComplete = 'onboarding_complete';
}

import 'dart:convert';

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

/// A landlord-created monthly reminder, stored entirely on device.
class CustomReminder {
  const CustomReminder({
    required this.id,
    required this.title,
    required this.dayOfMonth,
    required this.hour,
    required this.minute,
    this.enabled = true,
  });

  final String id;
  final String title;
  final int dayOfMonth;
  final int hour;
  final int minute;
  final bool enabled;

  Map<String, Object> toJson() => <String, Object>{
    'id': id,
    'title': title,
    'day': dayOfMonth,
    'hour': hour,
    'minute': minute,
    'enabled': enabled,
  };

  factory CustomReminder.fromJson(Map<String, dynamic> json) => CustomReminder(
    id: json['id']! as String,
    title: json['title']! as String,
    dayOfMonth: (json['day']! as int).clamp(1, 31).toInt(),
    hour: (json['hour']! as int).clamp(0, 23).toInt(),
    minute: (json['minute']! as int).clamp(0, 59).toInt(),
    enabled: json['enabled'] as bool? ?? true,
  );
}

/// Locally persisted schedule choices. Permissions are requested only on enable.
class ReminderPreferences {
  /// Creates local reminder preferences.
  const ReminderPreferences({
    this.billGenerationEnabled = false,
    this.rentDueEnabled = false,
    this.unpaidFollowUpEnabled = false,
    this.backupEnabled = false,
    this.billGenerationDay = 1,
    this.rentDueDay = 5,
    this.hour = 9,
    this.minute = 0,
    this.rentDueOffsetDays = 0,
    this.unpaidFollowUpDays = 3,
    this.customReminders = const <CustomReminder>[],
  });

  final bool billGenerationEnabled;

  /// Whether rent due reminders are enabled.
  final bool rentDueEnabled;

  final bool unpaidFollowUpEnabled;

  /// Whether backup reminders are enabled.
  final bool backupEnabled;

  final int billGenerationDay;
  final int rentDueDay;
  final int hour;
  final int minute;

  /// Negative values remind before the due date; positive values after it.
  final int rentDueOffsetDays;
  final int unpaidFollowUpDays;
  final List<CustomReminder> customReminders;

  /// Returns a copy with the supplied values replaced.
  ReminderPreferences copyWith({
    bool? billGenerationEnabled,
    bool? rentDueEnabled,
    bool? unpaidFollowUpEnabled,
    bool? backupEnabled,
    int? billGenerationDay,
    int? rentDueDay,
    int? hour,
    int? minute,
    int? rentDueOffsetDays,
    int? unpaidFollowUpDays,
    List<CustomReminder>? customReminders,
  }) {
    return ReminderPreferences(
      billGenerationEnabled:
          billGenerationEnabled ?? this.billGenerationEnabled,
      rentDueEnabled: rentDueEnabled ?? this.rentDueEnabled,
      unpaidFollowUpEnabled:
          unpaidFollowUpEnabled ?? this.unpaidFollowUpEnabled,
      backupEnabled: backupEnabled ?? this.backupEnabled,
      billGenerationDay: billGenerationDay ?? this.billGenerationDay,
      rentDueDay: rentDueDay ?? this.rentDueDay,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      rentDueOffsetDays: rentDueOffsetDays ?? this.rentDueOffsetDays,
      unpaidFollowUpDays: unpaidFollowUpDays ?? this.unpaidFollowUpDays,
      customReminders: customReminders ?? this.customReminders,
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
        billGenerationEnabled: readBool(AppSettingsKey.billGenerationReminder),
        rentDueEnabled: readBool(AppSettingsKey.rentDueReminder),
        unpaidFollowUpEnabled: readBool(AppSettingsKey.unpaidFollowUpReminder),
        backupEnabled: readBool(AppSettingsKey.backupReminder),
        billGenerationDay: _int(
          values[AppSettingsKey.billGenerationDay],
          1,
          1,
          31,
        ),
        rentDueDay: _int(values[AppSettingsKey.rentDueDay], 5, 1, 31),
        hour: _int(values[AppSettingsKey.reminderHour], 9, 0, 23),
        minute: _int(values[AppSettingsKey.reminderMinute], 0, 0, 59),
        rentDueOffsetDays: _int(
          values[AppSettingsKey.rentDueOffsetDays],
          0,
          -14,
          31,
        ),
        unpaidFollowUpDays: _int(
          values[AppSettingsKey.unpaidFollowUpDays],
          3,
          1,
          31,
        ),
        customReminders: _customReminders(
          values[AppSettingsKey.customReminders],
        ),
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
      AppSettingsKey.billGenerationReminder: reminders.billGenerationEnabled
          .toString(),
      AppSettingsKey.unpaidFollowUpReminder: reminders.unpaidFollowUpEnabled
          .toString(),
      AppSettingsKey.backupReminder: reminders.backupEnabled.toString(),
      AppSettingsKey.billGenerationDay: reminders.billGenerationDay.toString(),
      AppSettingsKey.rentDueDay: reminders.rentDueDay.toString(),
      AppSettingsKey.reminderHour: reminders.hour.toString(),
      AppSettingsKey.reminderMinute: reminders.minute.toString(),
      AppSettingsKey.rentDueOffsetDays: reminders.rentDueOffsetDays.toString(),
      AppSettingsKey.unpaidFollowUpDays: reminders.unpaidFollowUpDays
          .toString(),
      AppSettingsKey.customReminders: jsonEncode(
        reminders.customReminders
            .map((CustomReminder item) => item.toJson())
            .toList(),
      ),
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

int _int(String? value, int fallback, int min, int max) =>
    (int.tryParse(value ?? '') ?? fallback).clamp(min, max).toInt();

List<CustomReminder> _customReminders(String? value) {
  if (value == null) return const <CustomReminder>[];
  try {
    return (jsonDecode(value) as List<dynamic>)
        .map(
          (dynamic item) =>
              CustomReminder.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false);
  } on Object {
    return const <CustomReminder>[];
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
  static const String billGenerationReminder = 'bill_generation_reminder';
  static const String unpaidFollowUpReminder = 'unpaid_follow_up_reminder';
  static const String backupReminder = 'backup_reminder';
  static const String billGenerationDay = 'bill_generation_day';
  static const String rentDueDay = 'rent_due_day';
  static const String reminderHour = 'reminder_hour';
  static const String reminderMinute = 'reminder_minute';
  static const String rentDueOffsetDays = 'rent_due_offset_days';
  static const String unpaidFollowUpDays = 'unpaid_follow_up_days';
  static const String customReminders = 'custom_reminders';
  static const String onboardingComplete = 'onboarding_complete';
}

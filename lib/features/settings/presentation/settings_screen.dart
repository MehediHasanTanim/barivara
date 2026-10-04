import 'dart:async';

import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/notifications/local_notification_service.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// First-run language selection specified by the Bari Vara mobile UX guide.
class LanguageSelectionScreen extends ConsumerWidget {
  /// Creates the first-run language selection screen.
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              Icon(
                Icons.home_rounded,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
                semanticLabel: text.appTitle,
              ),
              const SizedBox(height: 20),
              Text(
                text.chooseLanguage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 28),
              _LanguageCard(
                label: text.bangla,
                selected: settings.language == AppLanguage.bengali,
                onTap: () => _update(
                  context,
                  ref,
                  settings.copyWith(language: AppLanguage.bengali),
                ),
              ),
              const SizedBox(height: 12),
              _LanguageCard(
                label: text.english,
                selected: settings.language == AppLanguage.english,
                onTap: () => _update(
                  context,
                  ref,
                  settings.copyWith(language: AppLanguage.english),
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(text.useBengaliDigits),
                value: settings.digitStyle == DigitStyle.bengali,
                onChanged: (bool enabled) {
                  _update(
                    context,
                    ref,
                    settings.copyWith(
                      digitStyle: enabled
                          ? DigitStyle.bengali
                          : DigitStyle.english,
                    ),
                  );
                },
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  _update(
                    context,
                    ref,
                    settings.copyWith(onboardingComplete: true),
                  );
                },
                child: Text(text.continueLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Settings home organized with the exact sections from the UX specification.
class SettingsScreen extends ConsumerWidget {
  /// Creates the settings home screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: <Widget>[
          _Section(
            title: text.language,
            children: <Widget>[
              _SettingTile(
                icon: Icons.translate_rounded,
                title: text.language,
                subtitle: settings.language == AppLanguage.bengali
                    ? text.bangla
                    : text.english,
                onTap: () => _open(context, const LanguageSettingsScreen()),
              ),
            ],
          ),
          _Section(
            title: text.appearance,
            children: <Widget>[
              _SettingTile(
                icon: Icons.palette_outlined,
                title: text.appearance,
                subtitle: _themeLabel(text, settings.theme),
                onTap: () => _open(context, const AppearanceSettingsScreen()),
              ),
            ],
          ),
          _Section(
            title: text.receiptDefaults,
            children: <Widget>[
              _SettingTile(
                icon: Icons.receipt_long_outlined,
                title: text.receiptDefaults,
                subtitle: settings.receiptLanguage == AppLanguage.bengali
                    ? text.bangla
                    : text.english,
                onTap: () => _open(context, const ReceiptSettingsScreen()),
              ),
            ],
          ),
          _Section(
            title: text.reminders,
            children: <Widget>[
              _SettingTile(
                icon: Icons.notifications_outlined,
                title: text.reminders,
                onTap: () => _open(context, const ReminderSettingsScreen()),
              ),
            ],
          ),
          _Section(
            title: text.dataAndBackup,
            children: <Widget>[
              _SettingTile(
                icon: Icons.backup_outlined,
                title: text.dataAndBackup,
                subtitle: text.backupRestorePlaceholder,
                onTap: () => _placeholder(context, text.dataAndBackup),
              ),
            ],
          ),
          _Section(
            title: text.security,
            children: <Widget>[
              _SettingTile(
                icon: Icons.lock_outline_rounded,
                title: text.security,
                subtitle: text.securityPlaceholder,
                onTap: () => _placeholder(context, text.security),
              ),
            ],
          ),
          _Section(
            title: text.about,
            children: <Widget>[
              _SettingTile(
                icon: Icons.info_outline_rounded,
                title: text.appTitle,
                subtitle: '1.0.0',
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Language and numeral-style controls with an immediate localized preview.
class LanguageSettingsScreen extends ConsumerWidget {
  /// Creates the language settings screen.
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.language)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          RadioGroup<AppLanguage>(
            groupValue: settings.language,
            onChanged: (AppLanguage? value) {
              if (value != null) {
                _update(context, ref, settings.copyWith(language: value));
              }
            },
            child: Column(
              children: <Widget>[
                _ChoiceTile<AppLanguage>(
                  value: AppLanguage.bengali,
                  title: text.bangla,
                ),
                _ChoiceTile<AppLanguage>(
                  value: AppLanguage.english,
                  title: text.english,
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          Text(text.digitStyle, style: Theme.of(context).textTheme.titleMedium),
          RadioGroup<DigitStyle>(
            groupValue: settings.digitStyle,
            onChanged: (DigitStyle? value) {
              if (value != null) {
                _update(context, ref, settings.copyWith(digitStyle: value));
              }
            },
            child: Column(
              children: <Widget>[
                _ChoiceTile<DigitStyle>(
                  value: DigitStyle.bengali,
                  title: text.bengaliDigits,
                ),
                _ChoiceTile<DigitStyle>(
                  value: DigitStyle.english,
                  title: text.englishDigits,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                text.languagePreview,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Appearance controls for light, dark, and system themes.
class AppearanceSettingsScreen extends ConsumerWidget {
  /// Creates the appearance settings screen.
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.appearance)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(text.theme, style: Theme.of(context).textTheme.titleMedium),
          RadioGroup<AppThemePreference>(
            groupValue: settings.theme,
            onChanged: (AppThemePreference? value) {
              if (value != null) {
                _update(context, ref, settings.copyWith(theme: value));
              }
            },
            child: Column(
              children: <Widget>[
                for (final AppThemePreference choice
                    in AppThemePreference.values)
                  _ChoiceTile<AppThemePreference>(
                    value: choice,
                    title: _themeLabel(text, choice),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Receipt language and default payment-method controls.
class ReceiptSettingsScreen extends ConsumerWidget {
  /// Creates the receipt settings screen.
  const ReceiptSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.receiptDefaults)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            text.defaultReceiptLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          RadioGroup<AppLanguage>(
            groupValue: settings.receiptLanguage,
            onChanged: (AppLanguage? value) {
              if (value != null) {
                _update(
                  context,
                  ref,
                  settings.copyWith(receiptLanguage: value),
                );
              }
            },
            child: Column(
              children: <Widget>[
                _ChoiceTile<AppLanguage>(
                  value: AppLanguage.bengali,
                  title: text.bangla,
                ),
                _ChoiceTile<AppLanguage>(
                  value: AppLanguage.english,
                  title: text.english,
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          Text(
            text.defaultPaymentMethod,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          DropdownButtonFormField<String>(
            initialValue: settings.defaultPaymentMethod,
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(value: 'cash', child: Text(text.cash)),
              DropdownMenuItem<String>(value: 'bkash', child: Text(text.bkash)),
              DropdownMenuItem<String>(value: 'nagad', child: Text(text.nagad)),
              DropdownMenuItem<String>(
                value: 'bank_transfer',
                child: Text(text.bankTransfer),
              ),
              DropdownMenuItem<String>(value: 'other', child: Text(text.other)),
            ],
            onChanged: (String? value) {
              if (value != null) {
                _update(
                  context,
                  ref,
                  settings.copyWith(defaultPaymentMethod: value),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Local reminder preference controls.
class ReminderSettingsScreen extends ConsumerWidget {
  /// Creates the reminder settings screen.
  const ReminderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.reminders)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Reminders are created only on this device. We ask for notification permission when you turn one on.',
              ),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile.adaptive(
            title: const Text('Monthly bill generation'),
            subtitle: const Text('Remind me to generate this month\'s bills.'),
            value: settings.reminders.billGenerationEnabled,
            onChanged: (bool enabled) => _updateReminders(
              context,
              ref,
              settings,
              settings.reminders.copyWith(billGenerationEnabled: enabled),
              requestPermission: enabled,
            ),
          ),
          SwitchListTile.adaptive(
            title: Text(text.rentDueReminder),
            subtitle: const Text(
              'Remind me before or after the monthly due date.',
            ),
            value: settings.reminders.rentDueEnabled,
            onChanged: (bool enabled) => _updateReminders(
              context,
              ref,
              settings,
              settings.reminders.copyWith(rentDueEnabled: enabled),
              requestPermission: enabled,
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text('Unpaid rent follow-up'),
            subtitle: const Text('Review unpaid tenants after the due date.'),
            value: settings.reminders.unpaidFollowUpEnabled,
            onChanged: (bool enabled) => _updateReminders(
              context,
              ref,
              settings,
              settings.reminders.copyWith(unpaidFollowUpEnabled: enabled),
              requestPermission: enabled,
            ),
          ),
          const Divider(height: 28),
          DropdownButtonFormField<int>(
            initialValue: settings.reminders.billGenerationDay,
            decoration: const InputDecoration(labelText: 'Bill generation day'),
            items: List<DropdownMenuItem<int>>.generate(
              31,
              (int index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text('${index + 1}'),
              ),
            ),
            onChanged: (int? value) {
              if (value != null) {
                unawaited(
                  _updateReminders(
                    context,
                    ref,
                    settings,
                    settings.reminders.copyWith(billGenerationDay: value),
                  ),
                );
              }
            },
          ),
          DropdownButtonFormField<int>(
            initialValue: settings.reminders.rentDueDay,
            decoration: const InputDecoration(labelText: 'Rent due day'),
            items: List<DropdownMenuItem<int>>.generate(
              31,
              (int index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text('${index + 1}'),
              ),
            ),
            onChanged: (int? value) {
              if (value != null) {
                unawaited(
                  _updateReminders(
                    context,
                    ref,
                    settings,
                    settings.reminders.copyWith(rentDueDay: value),
                  ),
                );
              }
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Reminder time'),
            subtitle: Text(
              TimeOfDay(
                hour: settings.reminders.hour,
                minute: settings.reminders.minute,
              ).format(context),
            ),
            trailing: const Icon(Icons.schedule_rounded),
            onTap: () async {
              final TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: settings.reminders.hour,
                  minute: settings.reminders.minute,
                ),
              );
              if (time != null && context.mounted) {
                await _updateReminders(
                  context,
                  ref,
                  settings,
                  settings.reminders.copyWith(
                    hour: time.hour,
                    minute: time.minute,
                  ),
                );
              }
            },
          ),
          DropdownButtonFormField<int>(
            initialValue: settings.reminders.rentDueOffsetDays,
            decoration: const InputDecoration(labelText: 'Due reminder timing'),
            items: const <DropdownMenuItem<int>>[
              DropdownMenuItem<int>(
                value: -3,
                child: Text('3 days before due date'),
              ),
              DropdownMenuItem<int>(
                value: -1,
                child: Text('1 day before due date'),
              ),
              DropdownMenuItem<int>(value: 0, child: Text('On due date')),
              DropdownMenuItem<int>(
                value: 1,
                child: Text('1 day after due date'),
              ),
              DropdownMenuItem<int>(
                value: 3,
                child: Text('3 days after due date'),
              ),
            ],
            onChanged: (int? value) {
              if (value != null) {
                unawaited(
                  _updateReminders(
                    context,
                    ref,
                    settings,
                    settings.reminders.copyWith(rentDueOffsetDays: value),
                  ),
                );
              }
            },
          ),
          DropdownButtonFormField<int>(
            initialValue: settings.reminders.unpaidFollowUpDays,
            decoration: const InputDecoration(
              labelText: 'Unpaid follow-up after due date',
            ),
            items: List<DropdownMenuItem<int>>.generate(
              14,
              (int index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text('${index + 1} day(s)'),
              ),
            ),
            onChanged: (int? value) {
              if (value != null) {
                unawaited(
                  _updateReminders(
                    context,
                    ref,
                    settings,
                    settings.reminders.copyWith(unpaidFollowUpDays: value),
                  ),
                );
              }
            },
          ),
          const Divider(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Custom landlord reminders'),
              TextButton.icon(
                icon: const Icon(Icons.add_alert_rounded),
                label: const Text('Add'),
                onPressed: () => _addCustomReminder(context, ref, settings),
              ),
            ],
          ),
          ...settings.reminders.customReminders.map(
            (CustomReminder item) => ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: Text(item.title),
              subtitle: Text(
                'Day ${item.dayOfMonth} at ${item.hour.toString().padLeft(2, '0')}:${item.minute.toString().padLeft(2, '0')}',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Switch.adaptive(
                    value: item.enabled,
                    onChanged: (bool enabled) {
                      unawaited(
                        _updateReminders(
                          context,
                          ref,
                          settings,
                          settings.reminders.copyWith(
                            customReminders: settings.reminders.customReminders
                                .map(
                                  (CustomReminder current) =>
                                      current.id == item.id
                                      ? CustomReminder(
                                          id: current.id,
                                          title: current.title,
                                          dayOfMonth: current.dayOfMonth,
                                          hour: current.hour,
                                          minute: current.minute,
                                          enabled: enabled,
                                        )
                                      : current,
                                )
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () => unawaited(
                      _updateReminders(
                        context,
                        ref,
                        settings,
                        settings.reminders.copyWith(
                          customReminders: settings.reminders.customReminders
                              .where(
                                (CustomReminder current) =>
                                    current.id != item.id,
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(text.localReminderNote),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _updateReminders(
  BuildContext context,
  WidgetRef ref,
  AppSettingsState settings,
  ReminderPreferences reminders, {
  bool requestPermission = false,
}) async {
  final LocalNotificationService notifications = ref
      .read(appServicesProvider)
      .notifications;
  if (requestPermission && !await notifications.requestPermission()) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification permission was not granted.'),
        ),
      );
    }
    return;
  }
  final AppSettingsState next = settings.copyWith(reminders: reminders);
  final Result<void> result = await ref
      .read(settingsControllerProvider.notifier)
      .update(next);
  if (result.isSuccess) {
    await notifications.reschedule(reminders);
  }
  if (context.mounted && result is Failure<void>) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(result.failure.message)));
  }
}

Future<void> _addCustomReminder(
  BuildContext context,
  WidgetRef ref,
  AppSettingsState settings,
) async {
  final TextEditingController title = TextEditingController();
  final String? value = await showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Custom reminder'),
      content: TextField(
        controller: title,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Reminder title'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, title.text),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  title.dispose();
  if (value == null || value.trim().isEmpty || !context.mounted) return;
  final CustomReminder reminder = CustomReminder(
    id: Uuid().v4(),
    title: value.trim(),
    dayOfMonth: settings.reminders.rentDueDay,
    hour: settings.reminders.hour,
    minute: settings.reminders.minute,
  );
  await _updateReminders(
    context,
    ref,
    settings,
    settings.reminders.copyWith(
      customReminders: <CustomReminder>[
        ...settings.reminders.customReminders,
        reminder,
      ],
    ),
    requestPermission: true,
  );
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: selected ? colors.primaryContainer : colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (selected) Icon(Icons.check_circle, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          Card(child: Column(children: children)),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 12,
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: onTap == null ? null : const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}

class _ChoiceTile<T> extends StatelessWidget {
  const _ChoiceTile({required this.value, required this.title});

  final T value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      contentPadding: EdgeInsets.zero,
      value: value,
      title: Text(title),
    );
  }
}

String _themeLabel(AppLocalizations text, AppThemePreference value) {
  return switch (value) {
    AppThemePreference.light => text.light,
    AppThemePreference.dark => text.dark,
    AppThemePreference.system => text.system,
  };
}

void _open(BuildContext context, Widget screen) {
  Navigator.of(context).push<void>(
    MaterialPageRoute<void>(builder: (BuildContext context) => screen),
  );
}

void _placeholder(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}

Future<void> _update(
  BuildContext context,
  WidgetRef ref,
  AppSettingsState next,
) async {
  final AppLocalizations text = AppLocalizations.of(context)!;
  final Result<void> result = await ref
      .read(settingsControllerProvider.notifier)
      .update(next);
  if (!context.mounted) {
    return;
  }
  if (result case Failure<void>()) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text.couldNotSave)));
  }
}

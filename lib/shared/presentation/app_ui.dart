import 'package:barivara/core/domain/value_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Consistent, accessible busy state for local database and file operations.
class AppLoadingState extends StatelessWidget {
  const AppLoadingState({
    this.label = 'Loading…',
    this.compact = false,
    super.key,
  });

  final String label;
  final bool compact;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    liveRegion: true,
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(compact ? 16 : 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 12),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    ),
  );
}

/// Explains a lack of records with an optional direct next action.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: '$title. $message',
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 52, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null && onAction != null) ...<Widget>[
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  onPressed: onAction,
                  icon: const Icon(Icons.add_rounded),
                  label: Text(actionLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

/// Actionable local failure state; text explains the issue without color alone.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    required this.message,
    this.title = 'Could not complete this action',
    this.onRetry,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: '$title. $message',
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...<Widget>[
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try again'),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

/// One language-independent confirmation pattern for reversible/risky actions.
abstract final class AppConfirmationDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    bool destructive = false,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            SizedBox(
              height: 48,
              child: FilledButton(
                style: destructive
                    ? FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      )
                    : null,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

/// Whole-taka field used where the financial workflow intentionally avoids floats.
class MoneyInput extends StatelessWidget {
  const MoneyInput({
    required this.controller,
    required this.label,
    this.required = false,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool required;
  final bool enabled;

  static Money? parseWholeTaka(String raw) {
    final int? taka = int.tryParse(raw.trim());
    return taka == null || taka < 0 ? null : Money.fromTaka(taka);
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    enabled: enabled,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    decoration: InputDecoration(labelText: label, prefixText: '৳ '),
    validator: (String? value) {
      if (!required && (value == null || value.trim().isEmpty)) return null;
      return parseWholeTaka(value ?? '') == null
          ? 'Enter a valid amount.'
          : null;
    },
  );
}

/// Phone-specific input with an explicit numeric keypad and readable label.
class PhoneInput extends StatelessWidget {
  const PhoneInput({
    required this.controller,
    required this.label,
    this.required = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,
    autofillHints: const <String>[AutofillHints.telephoneNumber],
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.phone_outlined),
    ),
    validator: (String? value) {
      final String phone = value?.trim() ?? '';
      if (phone.isEmpty) return required ? 'Enter a phone number.' : null;
      return phone.length < 6 ? 'Enter a valid phone number.' : null;
    },
  );
}

/// A large, direct date action instead of a hidden text-date convention.
class AppDatePickerField extends StatelessWidget {
  const AppDatePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    super.key,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label:
        '$label: ${MaterialLocalizations.of(context).formatMediumDate(value)}',
    child: SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.calendar_today_outlined),
        label: Text(
          '$label: ${MaterialLocalizations.of(context).formatMediumDate(value)}',
        ),
        onPressed: () async {
          final DateTime? selected = await showDatePicker(
            context: context,
            initialDate: value,
            firstDate: firstDate,
            lastDate: lastDate,
          );
          if (selected != null) onChanged(selected);
        },
      ),
    ),
  );
}

/// Compact month control shared by bills and report filters.
class MonthPicker extends StatelessWidget {
  const MonthPicker({
    required this.value,
    required this.onPrevious,
    required this.onNext,
    super.key,
  });

  final BillingMonth value;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      IconButton(
        tooltip: 'Previous month',
        onPressed: onPrevious,
        icon: const Icon(Icons.chevron_left_rounded),
      ),
      Semantics(
        label: 'Selected month ${value.key}',
        child: Text(value.key, style: Theme.of(context).textTheme.titleMedium),
      ),
      IconButton(
        tooltip: 'Next month',
        onPressed: onNext,
        icon: const Icon(Icons.chevron_right_rounded),
      ),
    ],
  );
}

/// Standard selector base for property, unit, tenant, and other records.
class AppSelector<T> extends StatelessWidget {
  const AppSelector({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    initialValue: value,
    decoration: InputDecoration(labelText: label),
    items: items,
    onChanged: onChanged,
  );
}

/// Reusable payment method selector with familiar local payment names.
class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final PaymentMethod value;
  final ValueChanged<PaymentMethod?> onChanged;

  @override
  Widget build(BuildContext context) => AppSelector<PaymentMethod>(
    label: 'Payment method',
    value: value,
    onChanged: onChanged,
    items: PaymentMethod.values
        .map(
          (PaymentMethod method) => DropdownMenuItem<PaymentMethod>(
            value: method,
            child: Text(_paymentMethodLabel(method)),
          ),
        )
        .toList(growable: false),
  );

  static String _paymentMethodLabel(PaymentMethod value) => switch (value) {
    PaymentMethod.bankTransfer => 'Bank transfer',
    _ => value.name[0].toUpperCase() + value.name.substring(1),
  };
}

/// Integer-only meter reading field, retaining the domain's exact consumption model.
class MeterReadingInput extends StatelessWidget {
  const MeterReadingInput({
    required this.controller,
    required this.label,
    super.key,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    decoration: InputDecoration(labelText: label, suffixText: 'units'),
    validator: (String? value) => int.tryParse(value?.trim() ?? '') == null
        ? 'Enter a valid meter reading.'
        : null,
  );
}

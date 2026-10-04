import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/charges/application/charge_configuration_use_cases.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Effective-dated recurring charge configuration for one tenancy.
class ChargeConfigurationScreen extends ConsumerStatefulWidget {
  /// Creates the charge configuration screen.
  const ChargeConfigurationScreen({required this.tenancy, super.key});
  final Tenancy tenancy;
  @override
  ConsumerState<ChargeConfigurationScreen> createState() =>
      _ChargeConfigurationScreenState();
}

class _ChargeConfigurationScreenState
    extends ConsumerState<ChargeConfigurationScreen> {
  late Future<Result<List<RecurringChargeRule>>> _rules;
  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _rules = DriftChargeConfigurationRepository(
      ref.read(appServicesProvider).database,
    ).listRules(widget.tenancy.id);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.chargeConfiguration)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add_rounded),
        label: Text(text.saveCharge),
      ),
      body: FutureBuilder<Result<List<RecurringChargeRule>>>(
        future: _rules,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Result<List<RecurringChargeRule>>> snapshot,
            ) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data case Success<List<RecurringChargeRule>>(
                :final value,
              )) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                  children: <Widget>[
                    _RuleTile(
                      rule: RecurringChargeRule(
                        id: EntityId('agreed-rent'),
                        tenancyId: widget.tenancy.id,
                        chargeType: ChargeType.rent,
                        calculationMethod: ChargeCalculationMethod.fixed,
                        fixedAmount: widget.tenancy.agreedRent,
                        effectiveFrom: BillingMonth.fromDate(
                          widget.tenancy.moveInDate,
                        ),
                      ),
                      title: text.monthlyRent,
                    ),
                    ...value.map(
                      (RecurringChargeRule rule) => _RuleTile(
                        rule: rule,
                        title: _label(text, rule.chargeType),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
      ),
    );
  }

  Future<void> _add() async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    ChargeType type = ChargeType.electricity;
    ChargeCalculationMethod method = ChargeCalculationMethod.fixed;
    final TextEditingController amount = TextEditingController(text: '0');
    final TextEditingController rate = TextEditingController(text: '0');
    final bool? save = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) =>
            AlertDialog(
              title: Text(text.chargeConfiguration),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<ChargeType>(
                    initialValue: type,
                    items:
                        <ChargeType>[
                              ChargeType.electricity,
                              ChargeType.gas,
                              ChargeType.water,
                              ChargeType.serviceCharge,
                              ChargeType.other,
                            ]
                            .map(
                              (ChargeType value) =>
                                  DropdownMenuItem<ChargeType>(
                                    value: value,
                                    child: Text(_label(text, value)),
                                  ),
                            )
                            .toList(growable: false),
                    onChanged: (ChargeType? value) {
                      if (value != null) {
                        setDialogState(() => type = value);
                      }
                    },
                  ),
                  DropdownButtonFormField<ChargeCalculationMethod>(
                    initialValue: method,
                    decoration: InputDecoration(
                      labelText: text.calculationMethod,
                    ),
                    items: ChargeCalculationMethod.values
                        .map(
                          (ChargeCalculationMethod value) =>
                              DropdownMenuItem<ChargeCalculationMethod>(
                                value: value,
                                child: Text(_methodLabel(text, value)),
                              ),
                        )
                        .toList(growable: false),
                    onChanged: (ChargeCalculationMethod? value) {
                      if (value != null) {
                        setDialogState(() => method = value);
                      }
                    },
                  ),
                  TextField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: text.fixedMonthly,
                      prefixText: '৳ ',
                    ),
                  ),
                  if (method == ChargeCalculationMethod.meterRate)
                    TextField(
                      controller: rate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: text.meterBased,
                        prefixText: '৳ ',
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(text.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(text.saveCharge),
                ),
              ],
            ),
      ),
    );
    if (!(save ?? false)) {
      amount.dispose();
      rate.dispose();
      return;
    }
    final Result<RecurringChargeRule> result =
        await ChargeConfigurationUseCases(
          DriftChargeConfigurationRepository(
            ref.read(appServicesProvider).database,
          ),
        ).configureRule(
          tenancyId: widget.tenancy.id,
          type: type,
          method: method,
          fixedAmount: Money.fromTaka(int.tryParse(amount.text) ?? 0),
          ratePerUnit: method == ChargeCalculationMethod.meterRate
              ? Money.fromTaka(int.tryParse(rate.text) ?? 0)
              : null,
          effectiveFrom: BillingMonth.fromDate(DateTime.now()),
        );
    amount.dispose();
    rate.dispose();
    if (!mounted) return;
    if (result.isSuccess) {
      setState(_reload);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (result as Failure<RecurringChargeRule>).failure.message,
          ),
        ),
      );
    }
  }
}

class _RuleTile extends ConsumerWidget {
  const _RuleTile({required this.rule, required this.title});
  final RecurringChargeRule rule;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          '${rule.calculationMethod.name} · ${rule.effectiveFrom.key}',
        ),
        trailing: Text(
          BariVaraFormatters.money(
            rule.fixedAmount,
            digitStyle: settings.digitStyle,
          ),
        ),
      ),
    );
  }
}

String _label(AppLocalizations text, ChargeType type) => switch (type) {
  ChargeType.rent => text.monthlyRent,
  ChargeType.electricity => text.electricity,
  ChargeType.gas => text.gas,
  ChargeType.water => text.water,
  ChargeType.serviceCharge => text.serviceCharge,
  _ => text.otherCharges,
};
String _methodLabel(AppLocalizations text, ChargeCalculationMethod value) =>
    switch (value) {
      ChargeCalculationMethod.fixed => text.fixedMonthly,
      ChargeCalculationMethod.meterRate => text.meterBased,
      ChargeCalculationMethod.manual => text.manualMonthly,
      ChargeCalculationMethod.previousBalance => text.currentBalance,
    };

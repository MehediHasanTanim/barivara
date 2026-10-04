import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/application/billing_engine.dart';
import 'package:barivara/features/billing/application/billing_use_cases.dart';
import 'package:barivara/features/charges/application/charge_configuration_use_cases.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:barivara/shared/presentation/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Month-first dashboard and entry point for local bill operations.
class BillsDashboardScreen extends ConsumerStatefulWidget {
  /// Creates the monthly bills dashboard.
  const BillsDashboardScreen({super.key});

  @override
  ConsumerState<BillsDashboardScreen> createState() =>
      _BillsDashboardScreenState();
}

class _BillsDashboardScreenState extends ConsumerState<BillsDashboardScreen> {
  late BillingMonth _month;
  late Future<Result<List<MonthlyBill>>> _bills;

  @override
  void initState() {
    super.initState();
    _month = BillingMonth.fromDate(DateTime.now());
    _reload();
  }

  void _reload() {
    _bills = DriftBillingRepository(ref.read(appServicesProvider).database)
        .listForPeriod(_month);
  }

  void _moveMonth(int offset) {
    setState(() {
      final DateTime value = DateTime(_month.year, _month.month + offset);
      _month = BillingMonth(value.year, value.month);
      _reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.bills)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? changed = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  BillGenerationScreen(month: _month),
            ),
          );
          if (changed ?? false) {
            setState(_reload);
          }
        },
        icon: const Icon(Icons.receipt_long_rounded),
        label: Text(text.generateBills),
      ),
      body: FutureBuilder<Result<List<MonthlyBill>>>(
        future: _bills,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Result<List<MonthlyBill>>> snapshot,
            ) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const AppLoadingState(label: 'Loading bills…');
              }
              final List<MonthlyBill> bills = switch (snapshot.data) {
                Success<List<MonthlyBill>>(:final value) => value,
                _ => <MonthlyBill>[],
              };
              final Money total = bills.fold(
                Money.zero,
                (Money amount, MonthlyBill bill) => amount + bill.total,
              );
              final Money due = bills.fold(
                Money.zero,
                (Money amount, MonthlyBill bill) =>
                    amount + bill.outstandingAmount,
              );
              return RefreshIndicator(
                onRefresh: () async => setState(_reload),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                  children: <Widget>[
                    _MonthHeader(
                      month: _month,
                      settings: settings,
                      previous: () => _moveMonth(-1),
                      next: () => _moveMonth(1),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _Kpi(
                            label: text.billsExpected,
                            value: '${bills.length}',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _Kpi(
                            label: text.total,
                            value: _money(total, settings),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _Kpi(
                            label: text.due,
                            value: _money(due, settings),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (bills.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: AppEmptyState(
                          icon: Icons.receipt_long_outlined,
                          title: text.noBills,
                          message: 'Generate bills for this month when you are ready.',
                        ),
                      )
                    else
                      ...bills.map(
                        (MonthlyBill bill) => _BillCard(
                          bill: bill,
                          settings: settings,
                          onTap: () async {
                            final bool? changed = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        BillDetailsScreen(billId: bill.id),
                                  ),
                                );
                            if (changed ?? false) {
                              setState(_reload);
                            }
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
      ),
    );
  }
}

/// Selects active tenancies and produces their draft bills as a batch.
class BillGenerationScreen extends ConsumerStatefulWidget {
  /// Creates the bulk draft generation screen.
  const BillGenerationScreen({required this.month, super.key});

  final BillingMonth month;

  @override
  ConsumerState<BillGenerationScreen> createState() =>
      _BillGenerationScreenState();
}

class _BillGenerationScreenState extends ConsumerState<BillGenerationScreen> {
  late Future<Result<List<TenantSummary>>> _tenants;
  final Set<EntityId> _selected = <EntityId>{};
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _tenants = TenantUseCases(
      DriftTenantRepository(ref.read(appServicesProvider).database),
    ).search('');
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.generateBills)),
      body: FutureBuilder<Result<List<TenantSummary>>>(
        future: _tenants,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Result<List<TenantSummary>>> snapshot,
            ) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<TenantSummary> summaries = switch (snapshot.data) {
                Success<List<TenantSummary>>(:final value) =>
                  value
                      .where(
                        (TenantSummary item) => item.currentTenancy != null,
                      )
                      .toList(growable: false),
                _ => <TenantSummary>[],
              };
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.calendar_month_rounded),
                    title: Text(text.selectMonth),
                    subtitle: Text(
                      '${widget.month.key} · ${summaries.length} ${text.tenants.toLowerCase()}',
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: summaries.length,
                      itemBuilder: (BuildContext context, int index) {
                        final TenantSummary summary = summaries[index];
                        final Tenancy tenancy = summary.currentTenancy!;
                        return CheckboxListTile(
                          value: _selected.contains(tenancy.id),
                          onChanged: _saving
                              ? null
                              : (bool? value) => setState(() {
                                  if (value ?? false) {
                                    _selected.add(tenancy.id);
                                  } else {
                                    _selected.remove(tenancy.id);
                                  }
                                }),
                          title: Text(summary.tenant.fullName),
                          subtitle: Text(
                            '${summary.unitName ?? ''} · ${_money(tenancy.agreedRent, ref.read(settingsControllerProvider))}',
                          ),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _saving || _selected.isEmpty
                              ? null
                              : () => _generate(summaries),
                          icon: _saving
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_rounded),
                          label: Text(text.generateBills),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
      ),
    );
  }

  Future<void> _generate(List<TenantSummary> summaries) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    setState(() => _saving = true);
    final BillingUseCases useCases = BillingUseCases(
      DriftBillingRepository(ref.read(appServicesProvider).database),
      DriftChargeConfigurationRepository(
        ref.read(appServicesProvider).database,
      ),
      DriftUnitRepository(ref.read(appServicesProvider).database),
    );
    final List<String> missing = <String>[];
    int created = 0;
    for (final TenantSummary summary in summaries) {
      final Tenancy? tenancy = summary.currentTenancy;
      if (tenancy == null || !_selected.contains(tenancy.id)) {
        continue;
      }
      final BillGenerationValues? values = await _generationValues(tenancy);
      if (values == null) {
        missing.add('${summary.tenant.fullName}: ${text.meterReading}');
        continue;
      }
      final Result<BillDraft> result = await useCases.generateDraft(
        tenancy: tenancy,
        period: widget.month,
        values: values,
      );
      switch (result) {
        case Success<BillDraft>():
          created++;
        case Failure<BillDraft>(:final failure):
          missing.add('${summary.tenant.fullName}: ${failure.message}');
      }
    }
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          missing.isEmpty
              ? '$created ${text.billGenerated}'
              : '${text.missingInputs}: ${missing.join(' ')}',
        ),
      ),
    );
    if (created > 0) {
      Navigator.of(context).pop(true);
    }
  }

  Future<BillGenerationValues?> _generationValues(Tenancy tenancy) async {
    final DriftChargeConfigurationRepository charges =
        DriftChargeConfigurationRepository(
          ref.read(appServicesProvider).database,
        );
    final Result<List<RecurringChargeRule>> rulesResult = await charges
        .listRules(tenancy.id);
    if (rulesResult is! Success<List<RecurringChargeRule>>) {
      return null;
    }
    final List<RecurringChargeRule> effective = rulesResult.value
        .where(
          (RecurringChargeRule rule) =>
              rule.effectiveFrom.compareTo(widget.month) <= 0 &&
              (rule.effectiveTo == null ||
                  rule.effectiveTo!.compareTo(widget.month) >= 0),
        )
        .toList(growable: false);
    final Map<ChargeType, Money> manualAmounts = <ChargeType, Money>{};
    for (final RecurringChargeRule rule in effective.where(
      (RecurringChargeRule rule) =>
          rule.calculationMethod == ChargeCalculationMethod.manual,
    )) {
      final Money? amount = await _manualAmountDialog(rule);
      if (amount == null) {
        return null;
      }
      manualAmounts[rule.chargeType] = amount;
    }
    final List<RecurringChargeRule> meters = effective
        .where(
          (RecurringChargeRule rule) =>
              rule.chargeType == ChargeType.electricity &&
              rule.calculationMethod == ChargeCalculationMethod.meterRate,
        )
        .toList(growable: false);
    if (meters.isEmpty) {
      return BillGenerationValues(manualAmounts: manualAmounts);
    }
    final Result<MeterReading?> priorResult = await DriftBillingRepository(
      ref.read(appServicesProvider).database,
    ).lastElectricityReading(tenancy.unitId);
    final Result<UtilityMeterConfiguration?> configResult = await charges
        .meterForUnit(tenancy.unitId);
    final MeterReading? latest = switch (priorResult) {
      Success<MeterReading?>(:final value) => value,
      Failure<MeterReading?>() => null,
    };
    MeterReading previous = latest ?? MeterReading(0);
    if (latest == null) {
      if (configResult case Success<UtilityMeterConfiguration?>(:final value)) {
        previous = value?.initialReading ?? previous;
      }
    }
    final BillMeterReadings? readings = await _readingDialog(
      previous: previous,
      rule: meters.first,
    );
    return readings == null
        ? null
        : BillGenerationValues(
            manualAmounts: manualAmounts,
            meterReadings: <ChargeType, BillMeterReadings>{
              ChargeType.electricity: readings,
            },
          );
  }

  Future<Money?> _manualAmountDialog(RecurringChargeRule rule) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController();
    final Money? value = await showDialog<Money>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(text.manualMonthly),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: rule.chargeType.name,
            prefixText: '৳ ',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(text.cancel),
          ),
          FilledButton(
            onPressed: () {
              final int? taka = int.tryParse(controller.text);
              if (taka != null && taka >= 0) {
                Navigator.of(context).pop(Money.fromTaka(taka));
              }
            },
            child: Text(text.save),
          ),
        ],
      ),
    );
    controller.dispose();
    return value;
  }

  Future<BillMeterReadings?> _readingDialog({
    required MeterReading previous,
    required RecurringChargeRule rule,
  }) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final TextEditingController controller = TextEditingController();
    int? current;
    final BillMeterReadings? result = await showDialog<BillMeterReadings>(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) {
          final Result<MeterChargeCalculation>? calculation = current == null
              ? null
              : UtilityChargeCalculator.electricity(
                  previous: previous,
                  current: MeterReading(current!),
                  ratePerUnit: rule.ratePerUnit!,
                  fixedFee: rule.fixedAmount,
                );
          return AlertDialog(
            title: Text(text.meterReading),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${text.previousReading}: ${previous.value}'),
                Text(
                  '${text.rate}: ${_money(rule.ratePerUnit!, ref.read(settingsControllerProvider))}',
                ),
                TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: text.currentReading),
                  onChanged: (String value) =>
                      setDialogState(() => current = int.tryParse(value)),
                ),
                if (calculation case Success<MeterChargeCalculation>(
                  :final value,
                )) ...<Widget>[
                  const SizedBox(height: 12),
                  Text('${text.consumption}: ${value.consumption}'),
                  Text(
                    '${text.calculatedAmount}: ${_money(value.amount, ref.read(settingsControllerProvider))}',
                  ),
                ],
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(text.cancel),
              ),
              FilledButton(
                onPressed:
                    current == null ||
                        calculation is Failure<MeterChargeCalculation>
                    ? null
                    : () => Navigator.of(context).pop(
                        BillMeterReadings(
                          previous: previous,
                          current: MeterReading(current!),
                        ),
                      ),
                child: Text(text.saveReading),
              ),
            ],
          );
        },
      ),
    );
    controller.dispose();
    return result;
  }
}

/// Read-only finalized details and controlled finalize action for a draft.
class BillDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a bill detail screen.
  const BillDetailsScreen({required this.billId, super.key});

  final EntityId billId;

  @override
  ConsumerState<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends ConsumerState<BillDetailsScreen> {
  late Future<Result<BillDraft?>> _draft;

  @override
  void initState() {
    super.initState();
    _draft = DriftBillingRepository(ref.read(appServicesProvider).database)
        .findDraft(widget.billId);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.billDetails)),
      body: FutureBuilder<Result<BillDraft?>>(
        future: _draft,
        builder: (BuildContext context, AsyncSnapshot<Result<BillDraft?>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final BillDraft? draft = switch (snapshot.data) {
            Success<BillDraft?>(:final value) => value,
            _ => null,
          };
          if (draft == null) return Center(child: Text(text.noBills));
          final MonthlyBill bill = draft.bill;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              _BillHeader(bill: bill, settings: settings),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: <Widget>[
                    ...draft.items.map(
                      (BillLineItem item) => ListTile(
                        title: Text(item.description),
                        subtitle: item.quantity == null
                            ? null
                            : Text(
                                '${item.quantity} × ${_money(item.unitRate ?? Money.zero, settings)}',
                              ),
                        trailing: Text(_money(item.amount, settings)),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: Text(text.total),
                      trailing: Text(
                        _money(bill.total, settings),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: Text(text.outstanding),
                      trailing: Text(_money(bill.outstandingAmount, settings)),
                    ),
                  ],
                ),
              ),
              if (bill.status == BillStatus.draft) ...<Widget>[
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _finalize,
                  child: Text(text.finalizeBill),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _finalize() async {
    final Result<MonthlyBill> result = await DriftBillingRepository(
      ref.read(appServicesProvider).database,
    ).finalize(widget.billId);
    if (!mounted) return;
    if (result.isSuccess) {
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((result as Failure<MonthlyBill>).failure.message),
        ),
      );
    }
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.settings,
    required this.previous,
    required this.next,
  });
  final BillingMonth month;
  final AppSettingsState settings;
  final VoidCallback previous;
  final VoidCallback next;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: <Widget>[
        const SizedBox(height: 6),
        Text(
          BariVaraFormatters.billingMonth(
            month,
            language: settings.language,
            digitStyle: settings.digitStyle,
          ),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        MonthPicker(value: month, onPrevious: previous, onNext: next),
      ],
    ),
  );
}

class _Kpi extends StatelessWidget {
  const _Kpi({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(value, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    ),
  );
}

class _BillCard extends StatelessWidget {
  const _BillCard({
    required this.bill,
    required this.settings,
    required this.onTap,
  });
  final MonthlyBill bill;
  final AppSettingsState settings;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      onTap: onTap,
      leading: const CircleAvatar(child: Icon(Icons.receipt_long_outlined)),
      title: Text('Unit ${bill.unitId.value}'),
      subtitle: Text(
        '${_statusLabel(AppLocalizations.of(context)!, bill.status)} · ${_money(bill.outstandingAmount, settings)}',
      ),
      trailing: Text(
        _money(bill.total, settings),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

class _BillHeader extends StatelessWidget {
  const _BillHeader({required this.bill, required this.settings});
  final MonthlyBill bill;
  final AppSettingsState settings;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            BariVaraFormatters.billingMonth(
              bill.period,
              language: settings.language,
              digitStyle: settings.digitStyle,
            ),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text('Unit ${bill.unitId.value}'),
          Text(_statusLabel(AppLocalizations.of(context)!, bill.status)),
        ],
      ),
    ),
  );
}

String _money(Money amount, AppSettingsState settings) =>
    BariVaraFormatters.money(amount, digitStyle: settings.digitStyle);

String _statusLabel(AppLocalizations text, BillStatus status) =>
    switch (status) {
      BillStatus.draft => text.draft,
      BillStatus.finalized => text.finalized,
      BillStatus.partiallyPaid => text.partial,
      BillStatus.paid => text.paid,
      BillStatus.cancelled => text.archived,
    };

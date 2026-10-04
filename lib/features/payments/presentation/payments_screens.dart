import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/payments/application/payment_use_cases.dart';
import 'package:barivara/features/receipts/presentation/receipt_preview_screen.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Local due overview, payment entry, and audit-preserving payment history.
class PaymentsDuesScreen extends ConsumerStatefulWidget {
  /// Creates the payment and due screen.
  const PaymentsDuesScreen({super.key});
  @override
  ConsumerState<PaymentsDuesScreen> createState() => _PaymentsDuesScreenState();
}

class _PaymentsDuesScreenState extends ConsumerState<PaymentsDuesScreen> {
  late Future<Result<List<TenantSummary>>> _tenants;
  late Future<Result<List<Payment>>> _history;
  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final database = ref.read(appServicesProvider).database;
    _tenants = TenantUseCases(DriftTenantRepository(database)).search('');
    _history = DriftPaymentRepository(database).listAll();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(text.payments)),
      body: RefreshIndicator(
        onRefresh: () async => setState(_reload),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
          children: <Widget>[
            Text(
              text.recordPayment,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            FutureBuilder<Result<List<TenantSummary>>>(
              future: _tenants,
              builder: (context, snapshot) {
                final summaries = switch (snapshot.data) {
                  Success<List<TenantSummary>>(:final value) =>
                    value.where((item) => item.currentTenancy != null).toList(),
                  _ => <TenantSummary>[],
                };
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Column(
                  children: summaries
                      .map(
                        (summary) => _DueTenantTile(
                          summary: summary,
                          settings: settings,
                          onTap: () async {
                            final changed = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PaymentEntryScreen(summary: summary),
                                  ),
                                );
                            if (changed ?? false) setState(_reload);
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              text.paymentHistory,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            FutureBuilder<Result<List<Payment>>>(
              future: _history,
              builder: (context, snapshot) {
                final values = switch (snapshot.data) {
                  Success<List<Payment>>(:final value) => value,
                  _ => <Payment>[],
                };
                return Column(
                  children: values
                      .map(
                        (payment) => ListTile(
                          leading: Icon(
                            payment.status == PaymentStatus.reversed
                                ? Icons.undo_rounded
                                : Icons.payments_rounded,
                          ),
                          title: Text(_money(payment.amount, settings)),
                          subtitle: Text(
                            '${payment.method.name} · ${payment.paymentDate.toIso8601String().substring(0, 10)}',
                          ),
                          trailing: payment.status == PaymentStatus.posted
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(Icons.receipt_long_outlined),
                                      tooltip: 'View receipt',
                                      onPressed: () => _openReceipt(payment),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.undo_rounded),
                                      tooltip: text.reversePayment,
                                      onPressed: () => _reverse(payment),
                                    ),
                                  ],
                                )
                              : Text(payment.status.name),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reverse(Payment payment) async {
    final text = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text.reversePayment),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: text.reversalReason),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(text.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(text.reversePayment),
          ),
        ],
      ),
    );
    controller.dispose();
    if (reason == null) return;
    final result = await PaymentUseCases(
      DriftPaymentRepository(ref.read(appServicesProvider).database),
      DriftBillingRepository(ref.read(appServicesProvider).database),
    ).reverse(payment.id, reason);
    if (!mounted) return;
    if (result.isSuccess) setState(_reload);
  }

  Future<void> _openReceipt(Payment payment) async {
    final result = await DriftReceiptRepository(
      ref.read(appServicesProvider).database,
    ).createForPayment(payment.id);
    if (!mounted) return;
    if (result case Success<ReceiptSnapshot>(:final value)) {
      final settings = ref.read(settingsControllerProvider);
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => ReceiptPreviewScreen(
            receipt: value,
            initialLanguage: settings.receiptLanguage == AppLanguage.bengali
                ? ReceiptLanguage.bengali
                : ReceiptLanguage.english,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt could not be prepared.')),
      );
    }
  }
}

class PaymentEntryScreen extends ConsumerStatefulWidget {
  const PaymentEntryScreen({required this.summary, super.key});
  final TenantSummary summary;
  @override
  ConsumerState<PaymentEntryScreen> createState() => _PaymentEntryScreenState();
}

class _PaymentEntryScreenState extends ConsumerState<PaymentEntryScreen> {
  final _amount = TextEditingController();
  final _reference = TextEditingController();
  final _note = TextEditingController();
  PaymentMethod _method = PaymentMethod.cash;
  bool _saving = false;
  @override
  void dispose() {
    _amount.dispose();
    _reference.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final settings = ref.watch(settingsControllerProvider);
    final tenancy = widget.summary.currentTenancy!;
    final useCases = PaymentUseCases(
      DriftPaymentRepository(ref.read(appServicesProvider).database),
      DriftBillingRepository(ref.read(appServicesProvider).database),
    );
    return Scaffold(
      appBar: AppBar(title: Text(text.recordPayment)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            widget.summary.tenant.fullName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(widget.summary.unitName ?? ''),
          FutureBuilder<Result<DueSummary>>(
            future: useCases.dueSummary(tenancy.id),
            builder: (_, snapshot) {
              final due = switch (snapshot.data) {
                Success<DueSummary>(:final value) => value.totalOutstanding,
                _ => Money.zero,
              };
              return Card(
                child: ListTile(
                  title: Text(text.outstandingTotal),
                  trailing: Text(_money(due, settings)),
                ),
              );
            },
          ),
          TextField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: text.paymentAmount,
              prefixText: '৳ ',
            ),
          ),
          DropdownButtonFormField<PaymentMethod>(
            initialValue: _method,
            decoration: InputDecoration(labelText: text.defaultPaymentMethod),
            items: PaymentMethod.values
                .map(
                  (method) =>
                      DropdownMenuItem(value: method, child: Text(method.name)),
                )
                .toList(),
            onChanged: (value) => setState(() => _method = value ?? _method),
          ),
          TextField(
            controller: _reference,
            decoration: InputDecoration(labelText: text.reference),
          ),
          TextField(
            controller: _note,
            decoration: InputDecoration(labelText: text.paymentNote),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _saving ? null : () => _post(useCases, tenancy),
            child: Text(text.recordPayment),
          ),
        ],
      ),
    );
  }

  Future<void> _post(PaymentUseCases useCases, Tenancy tenancy) async {
    final text = AppLocalizations.of(context)!;
    setState(() => _saving = true);
    final result = await useCases.record(
      tenancy: tenancy,
      input: PaymentInput(
        amount: Money.fromTaka(int.tryParse(_amount.text) ?? 0),
        paymentDate: DateTime.now(),
        method: _method,
        reference: _reference.text,
        note: _note.text,
      ),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (result case Success<PaymentPosting>(:final value)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(text.paymentPosted)));
      final receipt = await DriftReceiptRepository(
        ref.read(appServicesProvider).database,
      ).createForPayment(value.payment.id);
      if (!mounted) return;
      if (receipt case Success<ReceiptSnapshot>(:final value)) {
        final settings = ref.read(settingsControllerProvider);
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(
            builder: (_) => ReceiptPreviewScreen(
              receipt: value,
              initialLanguage: settings.receiptLanguage == AppLanguage.bengali
                  ? ReceiptLanguage.bengali
                  : ReceiptLanguage.english,
            ),
          ),
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text((result as Failure<PaymentPosting>).failure.message),
        ),
      );
    }
  }
}

class _DueTenantTile extends StatelessWidget {
  const _DueTenantTile({
    required this.summary,
    required this.settings,
    required this.onTap,
  });
  final TenantSummary summary;
  final AppSettingsState settings;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final useCases = PaymentUseCases(
      DriftPaymentRepository(
        ProviderScope.containerOf(context).read(appServicesProvider).database,
      ),
      DriftBillingRepository(
        ProviderScope.containerOf(context).read(appServicesProvider).database,
      ),
    );
    return FutureBuilder<Result<DueSummary>>(
      future: useCases.dueSummary(summary.currentTenancy!.id),
      builder: (_, snapshot) {
        final due = switch (snapshot.data) {
          Success<DueSummary>(:final value) => value.totalOutstanding,
          _ => Money.zero,
        };
        return Card(
          child: ListTile(
            onTap: onTap,
            leading: const CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text(summary.tenant.fullName),
            subtitle: Text(summary.unitName ?? ''),
            trailing: Text(_money(due, settings)),
          ),
        );
      },
    );
  }
}

String _money(Money amount, AppSettingsState settings) =>
    BariVaraFormatters.money(amount, digitStyle: settings.digitStyle);

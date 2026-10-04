import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/charges/presentation/charge_configuration_screen.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/features/tenants/application/tenant_tenancy_use_cases.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:barivara/shared/presentation/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Searchable local tenant profile list.
class TenantListScreen extends ConsumerStatefulWidget {
  /// Creates the tenant list screen.
  const TenantListScreen({super.key});

  @override
  ConsumerState<TenantListScreen> createState() => _TenantListScreenState();
}

class _TenantListScreenState extends ConsumerState<TenantListScreen> {
  String _query = '';

  TenantUseCases get _useCases => TenantUseCases(
    DriftTenantRepository(ref.read(appServicesProvider).database),
  );

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.tenants)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? saved = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) => const TenantFormScreen(),
            ),
          );
          if (saved ?? false) setState(() {});
        },
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: Text(text.addTenant),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: text.searchTenants,
              ),
              onChanged: (String value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: FutureBuilder<Result<List<TenantSummary>>>(
              future: _useCases.search(_query),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<TenantSummary>>> snapshot,
                  ) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const AppLoadingState(label: 'Loading tenants…');
                    }
                    if (snapshot.data case Success<List<TenantSummary>>(
                      :final value,
                    )) {
                      if (value.isEmpty) {
                        return AppEmptyState(
                          icon: Icons.people_outline_rounded,
                          title: text.noTenantsYet,
                          message: 'Add a tenant to record occupancy and rent.',
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                        itemCount: value.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (BuildContext context, int index) =>
                            _TenantCard(
                              summary: value[index],
                              onTap: () async {
                                final bool? changed =
                                    await Navigator.of(context).push<bool>(
                                      MaterialPageRoute<bool>(
                                        builder: (BuildContext context) =>
                                            TenantDetailsScreen(
                                              summary: value[index],
                                            ),
                                      ),
                                    );
                                if (changed ?? false) setState(() {});
                              },
                            ),
                      );
                    }
                    return AppErrorState(
                      message: text.couldNotSave,
                      onRetry: () => setState(() {}),
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}

/// Tenant profile with contact, terms, history, and move-out foundation.
class TenantDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a tenant profile details screen.
  const TenantDetailsScreen({required this.summary, super.key});

  final TenantSummary summary;

  @override
  ConsumerState<TenantDetailsScreen> createState() =>
      _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends ConsumerState<TenantDetailsScreen> {
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final Tenant tenant = widget.summary.tenant;
    final Tenancy? tenancy = widget.summary.currentTenancy;
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, bool? result) {
        if (!didPop) Navigator.of(context).pop(_changed);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(tenant.fullName),
          actions: <Widget>[
            if (tenancy != null)
              IconButton(
                icon: const Icon(Icons.tune_rounded),
                tooltip: text.chargeConfiguration,
                onPressed: () => Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        ChargeConfigurationScreen(tenancy: tenancy),
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: text.editTenant,
              onPressed: () async {
                final bool? saved = await Navigator.of(context).push<bool>(
                  MaterialPageRoute<bool>(
                    builder: (BuildContext context) =>
                        TenantFormScreen(existing: tenant),
                  ),
                );
                if (saved ?? false) {
                  _changed = true;
                  if (context.mounted) Navigator.of(context).pop(true);
                }
              },
            ),
            if (tenancy == null)
              PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'archive') {
                    final Result<void> result = await TenantUseCases(
                      DriftTenantRepository(
                        ref.read(appServicesProvider).database,
                      ),
                    ).archive(tenant.id);
                    if (!context.mounted) {
                      return;
                    }
                    if (result.isSuccess) {
                      _changed = true;
                      Navigator.of(context).pop(true);
                    } else {
                      _failure(context, result);
                    }
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'archive',
                    child: Text(text.archiveTenant),
                  ),
                ],
              ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(tenant.fullName.characters.first),
                ),
                title: Text(tenant.fullName),
                subtitle: Text(tenant.phone.value),
                trailing: _TenantStatus(active: tenancy != null),
              ),
            ),
            const SizedBox(height: 16),
            _DetailSection(
              title: text.currentUnit,
              child: tenancy == null
                  ? Text(text.noActiveTenancy)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.summary.unitName ?? ''),
                        if (widget.summary.propertyName != null)
                          Text(widget.summary.propertyName!),
                        const SizedBox(height: 8),
                        Text(
                          '${text.moveInDate}: ${tenancy.moveInDate.toIso8601String().substring(0, 10)}',
                        ),
                      ],
                    ),
            ),
            _DetailSection(
              title: text.contactInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(tenant.phone.value),
                  if (tenant.alternativePhone != null)
                    Text(tenant.alternativePhone!.value),
                  if (tenant.permanentAddress != null)
                    Text(tenant.permanentAddress!),
                  if (tenant.emergencyContactName != null)
                    Text(
                      '${tenant.emergencyContactName!} ${tenant.emergencyContactPhone?.value ?? ''}',
                    ),
                ],
              ),
            ),
            if (tenancy != null)
              _DetailSection(
                title: text.rentalTerms,
                child: _TenancyTerms(tenancy: tenancy),
              ),
            _DetailSection(
              title: text.tenancyHistory,
              child: FutureBuilder<Result<List<Tenancy>>>(
                future: TenancyUseCases(
                  DriftTenancyRepository(
                    ref.read(appServicesProvider).database,
                  ),
                ).historyForTenant(tenant.id),
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<Result<List<Tenancy>>> snapshot,
                    ) {
                      if (snapshot.data case Success<List<Tenancy>>(
                        :final value,
                      )) {
                        return Column(
                          children: value
                              .map(
                                (Tenancy item) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    item.status == TenancyStatus.active
                                        ? text.activeTenant
                                        : text.formerTenant,
                                  ),
                                  subtitle: Text(
                                    item.moveInDate.toIso8601String().substring(
                                      0,
                                      10,
                                    ),
                                  ),
                                ),
                              )
                              .toList(growable: false),
                        );
                      }
                      return const SizedBox(
                        height: 24,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
              ),
            ),
          ],
        ),
        bottomNavigationBar: tenancy == null
            ? null
            : SafeArea(
                minimum: const EdgeInsets.all(16),
                child: FilledButton.icon(
                  onPressed: () => _moveOut(context, tenancy),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(text.moveOut),
                ),
              ),
      ),
    );
  }

  Future<void> _moveOut(BuildContext context, Tenancy tenancy) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    DateTime date = DateTime.now();
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) =>
            AlertDialog(
              title: Text(text.moveOut),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(text.moveOutMessage),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () async {
                      final DateTime? selected = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: tenancy.moveInDate,
                        lastDate: DateTime.now().add(const Duration(days: 1)),
                      );
                      if (selected != null) {
                        setDialogState(() => date = selected);
                      }
                    },
                    icon: const Icon(Icons.calendar_today_outlined),
                    label: Text(date.toIso8601String().substring(0, 10)),
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
                  child: Text(text.confirmMoveOut),
                ),
              ],
            ),
      ),
    );
    if (!(confirm ?? false)) return;
    final Result<void> result = await TenancyUseCases(
      DriftTenancyRepository(ref.read(appServicesProvider).database),
    ).moveOut(tenancy, date);
    if (!context.mounted) {
      return;
    }
    if (result.isSuccess) {
      _changed = true;
      Navigator.of(context).pop(true);
    } else {
      _failure(context, result);
    }
  }
}

/// Guided profile, unit, and deposit/advance entry flow.
class TenantFormScreen extends ConsumerStatefulWidget {
  /// Creates a tenant form, optionally editing a profile only.
  const TenantFormScreen({this.existing, super.key});
  final Tenant? existing;
  @override
  ConsumerState<TenantFormScreen> createState() => _TenantFormScreenState();
}

class _TenantFormScreenState extends ConsumerState<TenantFormScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _alternate;
  late final TextEditingController _nid;
  late final TextEditingController _address;
  late final TextEditingController _emergency;
  late final TextEditingController _emergencyPhone;
  late final TextEditingController _notes;
  late final TextEditingController _rent;
  late final TextEditingController _deposit;
  late final TextEditingController _advance;
  int _step = 0;
  Property? _property;
  RentalUnit? _unit;
  DateTime _moveIn = DateTime.now();
  int _billingDay = 5;

  @override
  void initState() {
    super.initState();
    final Tenant? tenant = widget.existing;
    _name = TextEditingController(text: tenant?.fullName);
    _phone = TextEditingController(text: tenant?.phone.value);
    _alternate = TextEditingController(text: tenant?.alternativePhone?.value);
    _nid = TextEditingController(text: tenant?.nidNumber);
    _address = TextEditingController(text: tenant?.permanentAddress);
    _emergency = TextEditingController(text: tenant?.emergencyContactName);
    _emergencyPhone = TextEditingController(
      text: tenant?.emergencyContactPhone?.value,
    );
    _notes = TextEditingController(text: tenant?.notes);
    _rent = TextEditingController();
    _deposit = TextEditingController(text: '0');
    _advance = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    for (final TextEditingController controller in <TextEditingController>[
      _name,
      _phone,
      _alternate,
      _nid,
      _address,
      _emergency,
      _emergencyPhone,
      _notes,
      _rent,
      _deposit,
      _advance,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool editOnly = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(editOnly ? text.editTenant : text.addTenant)),
      body: Form(
        key: _form,
        child: Stepper(
          currentStep: _step,
          onStepContinue: _continue,
          onStepCancel: _step == 0
              ? () => Navigator.of(context).pop()
              : () => setState(() => _step--),
          controlsBuilder: (BuildContext context, ControlsDetails details) =>
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: <Widget>[
                    FilledButton(
                      onPressed: details.onStepContinue,
                      child: Text(
                        _step == (editOnly ? 0 : 2)
                            ? (editOnly ? text.save : text.confirmTenancy)
                            : text.continueLabel,
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(text.cancel),
                    ),
                  ],
                ),
              ),
          steps: <Step>[
            Step(
              title: Text(text.stepBasicInfo),
              isActive: _step >= 0,
              content: _profileFields(text),
            ),
            if (!editOnly)
              Step(
                title: Text(text.stepTenancy),
                isActive: _step >= 1,
                content: _tenancyFields(text),
              ),
            if (!editOnly)
              Step(
                title: Text(text.stepDeposit),
                isActive: _step >= 2,
                content: _depositFields(text),
              ),
          ],
        ),
      ),
    );
  }

  Widget _profileFields(AppLocalizations text) => Column(
    children: <Widget>[
      TextFormField(
        controller: _name,
        decoration: InputDecoration(labelText: text.fullName),
        validator: _required(text),
      ),
      const SizedBox(height: 12),
      PhoneInput(controller: _phone, label: text.mobileNumber, required: true),
      const SizedBox(height: 12),
      PhoneInput(controller: _alternate, label: text.alternateMobile),
      const SizedBox(height: 12),
      TextFormField(
        controller: _nid,
        decoration: InputDecoration(labelText: text.nationalId),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _address,
        decoration: InputDecoration(labelText: text.permanentAddress),
      ),
      const SizedBox(height: 12),
      TextFormField(
        controller: _emergency,
        decoration: InputDecoration(labelText: text.emergencyContact),
      ),
      const SizedBox(height: 12),
      PhoneInput(controller: _emergencyPhone, label: text.emergencyPhone),
      const SizedBox(height: 12),
      TextFormField(
        controller: _notes,
        maxLines: 2,
        decoration: InputDecoration(labelText: text.tenantNotes),
      ),
    ],
  );

  Widget _tenancyFields(
    AppLocalizations text,
  ) => FutureBuilder<Result<List<Property>>>(
    future: DriftPropertyRepository(ref.read(appServicesProvider).database)
        .list(),
    builder:
        (BuildContext context, AsyncSnapshot<Result<List<Property>>> snapshot) {
          if (snapshot.data case Success<List<Property>>(:final value)) {
            return Column(
              children: <Widget>[
                AppSelector<Property>(
                  value: _property,
                  label: text.selectProperty,
                  items: value
                      .map(
                        (Property property) => DropdownMenuItem<Property>(
                          value: property,
                          child: Text(property.name),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: (Property? property) => setState(() {
                    _property = property;
                    _unit = null;
                  }),
                ),
                if (_property != null)
                  FutureBuilder<Result<List<RentalUnit>>>(
                    future: DriftUnitRepository(
                      ref.read(appServicesProvider).database,
                    ).listByProperty(_property!.id),
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<Result<List<RentalUnit>>> units,
                        ) {
                          if (units.data case Success<List<RentalUnit>>(
                            :final value,
                          )) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: AppSelector<RentalUnit>(
                                value: _unit,
                                label: text.selectUnit,
                                items: value
                                    .map(
                                      (RentalUnit unit) =>
                                          DropdownMenuItem<RentalUnit>(
                                            value: unit,
                                            child: Text(unit.name),
                                          ),
                                    )
                                    .toList(growable: false),
                                onChanged: (RentalUnit? unit) => setState(() {
                                  _unit = unit;
                                  _rent.text =
                                      ((unit?.defaultRent.poisha ?? 0) ~/ 100)
                                          .toString();
                                }),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                  ),
                const SizedBox(height: 12),
                AppDatePickerField(
                  label: text.moveInDate,
                  value: _moveIn,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onChanged: (DateTime value) =>
                      setState(() => _moveIn = value),
                ),
                MoneyInput(
                  controller: _rent,
                  label: text.monthlyRent,
                  required: true,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  initialValue: _billingDay,
                  decoration: InputDecoration(labelText: text.billingDay),
                  items: List<DropdownMenuItem<int>>.generate(
                    28,
                    (int index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                  onChanged: (int? day) {
                    if (day != null) setState(() => _billingDay = day);
                  },
                ),
              ],
            );
          }
          return const AppLoadingState(label: 'Loading properties and units…');
        },
  );
  Widget _depositFields(AppLocalizations text) => Column(
    children: <Widget>[
      MoneyInput(
        controller: _deposit,
        label: text.securityDeposit,
        required: true,
      ),
      const SizedBox(height: 12),
      MoneyInput(controller: _advance, label: text.advanceRent, required: true),
    ],
  );

  Future<void> _continue() async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool editOnly = widget.existing != null;
    if (_step == 0 && !(_form.currentState?.validate() ?? false)) return;
    if (!editOnly && _step == 1 && _unit == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(text.requiredSelection)));
      return;
    }
    if (_step < (editOnly ? 0 : 2)) {
      setState(() => _step++);
      return;
    }
    final TenantInput input = TenantInput(
      fullName: _name.text,
      phone: _phone.text,
      alternativePhone: _alternate.text,
      nidNumber: _nid.text,
      permanentAddress: _address.text,
      emergencyContactName: _emergency.text,
      emergencyContactPhone: _emergencyPhone.text,
      notes: _notes.text,
    );
    final TenantUseCases tenantUseCases = TenantUseCases(
      DriftTenantRepository(ref.read(appServicesProvider).database),
    );
    final Result<Tenant> tenantResult = widget.existing == null
        ? await tenantUseCases.create(input)
        : await tenantUseCases.update(widget.existing!, input);
    if (tenantResult case Failure<Tenant>()) {
      if (mounted) _failure(context, tenantResult);
      return;
    }
    if (!editOnly) {
      final Tenant tenant = (tenantResult as Success<Tenant>).value;
      final Result<Tenancy> tenancyResult =
          await TenancyUseCases(
            DriftTenancyRepository(ref.read(appServicesProvider).database),
          ).create(
            TenancyInput(
              tenantId: tenant.id,
              unitId: _unit!.id,
              moveInDate: _moveIn,
              agreedRent: Money.fromTaka(int.parse(_rent.text)),
              billingDay: _billingDay,
              securityDepositTarget: Money.fromTaka(int.parse(_deposit.text)),
              advanceRent: Money.fromTaka(int.parse(_advance.text)),
            ),
          );
      if (tenancyResult case Failure<Tenancy>()) {
        if (mounted) _failure(context, tenancyResult);
        return;
      }
    }
    if (mounted) Navigator.of(context).pop(true);
  }
}

class _TenantCard extends ConsumerWidget {
  const _TenantCard({required this.summary, required this.onTap});
  final TenantSummary summary;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(summary.tenant.fullName.characters.first),
        ),
        title: Text(summary.tenant.fullName),
        subtitle: Text(
          '${summary.unitName ?? text.noActiveTenancy}\n${summary.tenant.phone.value}',
        ),
        isThreeLine: true,
        trailing: _TenantStatus(active: summary.currentTenancy != null),
      ),
    );
  }
}

class _TenantStatus extends StatelessWidget {
  const _TenantStatus({required this.active});
  final bool active;
  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final Color color = active
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline;
    return Chip(
      label: Text(active ? text.activeTenant : text.formerTenant),
      backgroundColor: color.withValues(alpha: .12),
      side: BorderSide.none,
      labelStyle: TextStyle(color: color),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _TenancyTerms extends ConsumerWidget {
  const _TenancyTerms({required this.tenancy});
  final Tenancy tenancy;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${text.monthlyRent}: ${BariVaraFormatters.money(tenancy.agreedRent, digitStyle: settings.digitStyle)}',
        ),
        Text('${text.billingDay}: ${tenancy.billingDay}'),
        Text(
          '${text.depositBalance}: ${BariVaraFormatters.money(tenancy.securityDepositTarget, digitStyle: settings.digitStyle)}',
        ),
        Text('${text.currentBalance}: ৳0'),
      ],
    );
  }
}

String? Function(String?) _required(AppLocalizations text) =>
    (String? value) =>
        value == null || value.trim().isEmpty ? text.requiredField : null;
void _failure<T>(BuildContext context, Result<T> result) {
  final String message = switch (result) {
    Failure<T>(:final failure) => failure.message,
    Success<T>() => '',
  };
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

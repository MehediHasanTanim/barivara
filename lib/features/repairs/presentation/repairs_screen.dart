import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/repairs/application/repair_use_cases.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Offline maintenance list with locally evaluated property/status/category filters.
class RepairsScreen extends ConsumerStatefulWidget {
  const RepairsScreen({super.key});

  @override
  ConsumerState<RepairsScreen> createState() => _RepairsScreenState();
}

class _RepairsScreenState extends ConsumerState<RepairsScreen> {
  RepairFilter _filter = const RepairFilter();
  late Future<Result<List<Property>>> _properties;
  late Future<Result<List<Repair>>> _repairs;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final database = ref.read(appServicesProvider).database;
    _properties = DriftPropertyRepository(database).list();
    _repairs = DriftRepairRepository(database).list(_filter);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Repairs & expenses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? saved = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(builder: (_) => const RepairEntryScreen()),
          );
          if (saved ?? false) setState(_reload);
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add repair'),
      ),
      body: FutureBuilder<Result<List<Property>>>(
        future: _properties,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Result<List<Property>>> propertySnapshot,
            ) {
              final List<Property> properties = switch (propertySnapshot.data) {
                Success<List<Property>>(:final value) => value,
                _ => <Property>[],
              };
              return RefreshIndicator(
                onRefresh: () async => setState(_reload),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 92),
                  children: <Widget>[
                    _Filters(
                      filter: _filter,
                      properties: properties,
                      onChanged: (RepairFilter value) => setState(() {
                        _filter = value;
                        _repairs = DriftRepairRepository(
                          ref.read(appServicesProvider).database,
                        ).list(value);
                      }),
                    ),
                    if (_filter.propertyId != null)
                      _ExpenseCard(
                        propertyId: _filter.propertyId!,
                        settings: settings,
                      ),
                    const SizedBox(height: 8),
                    FutureBuilder<Result<List<Repair>>>(
                      future: _repairs,
                      builder:
                          (
                            BuildContext context,
                            AsyncSnapshot<Result<List<Repair>>> snapshot,
                          ) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final List<Repair> repairs =
                                switch (snapshot.data) {
                                  Success<List<Repair>>(:final value) => value,
                                  _ => <Repair>[],
                                };
                            if (repairs.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(
                                  child: Text(
                                    'No repairs match these filters.',
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: repairs
                                  .map(
                                    (Repair repair) => _RepairTile(
                                      repair: repair,
                                      settings: settings,
                                    ),
                                  )
                                  .toList(growable: false),
                            );
                          },
                    ),
                  ],
                ),
              );
            },
      ),
    );
  }
}

class _Filters extends ConsumerWidget {
  const _Filters({
    required this.filter,
    required this.properties,
    required this.onChanged,
  });

  final RepairFilter filter;
  final List<Property> properties;
  final ValueChanged<RepairFilter> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<EntityId?>(
            initialValue: filter.propertyId,
            decoration: const InputDecoration(labelText: 'Property'),
            items: <DropdownMenuItem<EntityId?>>[
              const DropdownMenuItem<EntityId?>(
                value: null,
                child: Text('All properties'),
              ),
              ...properties.map(
                (Property property) => DropdownMenuItem<EntityId?>(
                  value: property.id,
                  child: Text(property.name),
                ),
              ),
            ],
            onChanged: (EntityId? value) => onChanged(
              RepairFilter(
                propertyId: value,
                unitId: null,
                status: filter.status,
                category: filter.category,
                dateRange: filter.dateRange,
              ),
            ),
          ),
          if (filter.propertyId != null) ...<Widget>[
            const SizedBox(height: 8),
            FutureBuilder<Result<List<RentalUnit>>>(
              future: DriftUnitRepository(
                ref.read(appServicesProvider).database,
              ).listByProperty(filter.propertyId!),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<RentalUnit>>> snapshot,
                  ) {
                    final List<RentalUnit> units = switch (snapshot.data) {
                      Success<List<RentalUnit>>(:final value) => value,
                      _ => <RentalUnit>[],
                    };
                    return DropdownButtonFormField<EntityId?>(
                      initialValue: filter.unitId,
                      decoration: const InputDecoration(labelText: 'Unit'),
                      items: <DropdownMenuItem<EntityId?>>[
                        const DropdownMenuItem<EntityId?>(
                          value: null,
                          child: Text('All units'),
                        ),
                        ...units.map(
                          (RentalUnit unit) => DropdownMenuItem<EntityId?>(
                            value: unit.id,
                            child: Text(unit.name),
                          ),
                        ),
                      ],
                      onChanged: (EntityId? value) => onChanged(
                        RepairFilter(
                          propertyId: filter.propertyId,
                          unitId: value,
                          status: filter.status,
                          category: filter.category,
                          dateRange: filter.dateRange,
                        ),
                      ),
                    );
                  },
            ),
          ],
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              ChoiceChip(
                label: const Text('All statuses'),
                selected: filter.status == null,
                onSelected: (_) => onChanged(
                  RepairFilter(
                    propertyId: filter.propertyId,
                    unitId: filter.unitId,
                    category: filter.category,
                    dateRange: filter.dateRange,
                  ),
                ),
              ),
              ...RepairStatus.values.map(
                (RepairStatus status) => ChoiceChip(
                  label: Text(_label(status.name)),
                  selected: filter.status == status,
                  onSelected: (_) => onChanged(
                    RepairFilter(
                      propertyId: filter.propertyId,
                      unitId: filter.unitId,
                      status: status,
                      category: filter.category,
                      dateRange: filter.dateRange,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: <Widget>[
              ChoiceChip(
                label: const Text('All categories'),
                selected: filter.category == null,
                onSelected: (_) => onChanged(
                  RepairFilter(
                    propertyId: filter.propertyId,
                    unitId: filter.unitId,
                    status: filter.status,
                    dateRange: filter.dateRange,
                  ),
                ),
              ),
              ...RepairCategory.values.map(
                (RepairCategory category) => ChoiceChip(
                  label: Text(_label(category.name)),
                  selected: filter.category == category,
                  onSelected: (_) => onChanged(
                    RepairFilter(
                      propertyId: filter.propertyId,
                      unitId: filter.unitId,
                      status: filter.status,
                      category: category,
                      dateRange: filter.dateRange,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  final DateTime now = DateTime.now();
                  final DateTimeRange? selected = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(now.year + 5),
                    initialDateRange: filter.dateRange == null
                        ? null
                        : DateTimeRange(
                            start: filter.dateRange!.start,
                            end: filter.dateRange!.end,
                          ),
                  );
                  if (selected != null) {
                    onChanged(
                      RepairFilter(
                        propertyId: filter.propertyId,
                        unitId: filter.unitId,
                        status: filter.status,
                        category: filter.category,
                        dateRange: DateRange(selected.start, selected.end),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.date_range_rounded),
                label: Text(
                  filter.dateRange == null ? 'Any date' : 'Date filter',
                ),
              ),
              if (filter.dateRange != null)
                IconButton(
                  tooltip: 'Clear date filter',
                  onPressed: () => onChanged(
                    RepairFilter(
                      propertyId: filter.propertyId,
                      unitId: filter.unitId,
                      status: filter.status,
                      category: filter.category,
                    ),
                  ),
                  icon: const Icon(Icons.clear_rounded),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ExpenseCard extends ConsumerWidget {
  const _ExpenseCard({required this.propertyId, required this.settings});

  final EntityId propertyId;
  final AppSettingsState settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime now = DateTime.now();
    final DateRange range = DateRange(
      DateTime(now.year, now.month),
      DateTime(
        now.year,
        now.month + 1,
      ).subtract(const Duration(milliseconds: 1)),
    );
    return FutureBuilder<Result<RepairExpenseSummary>>(
      future: DriftRepairRepository(ref.read(appServicesProvider).database)
          .expenseSummary(propertyId, range),
      builder:
          (
            BuildContext context,
            AsyncSnapshot<Result<RepairExpenseSummary>> snapshot,
          ) {
            final RepairExpenseSummary? summary = switch (snapshot.data) {
              Success<RepairExpenseSummary>(:final value) => value,
              _ => null,
            };
            return Card(
              child: ListTile(
                leading: const Icon(Icons.construction_rounded),
                title: const Text('This month\'s landlord maintenance expense'),
                subtitle: Text(
                  summary == null
                      ? 'Calculating…'
                      : '${summary.repairCount} repair(s)',
                ),
                trailing: summary == null
                    ? null
                    : Text(_money(summary.total, settings)),
              ),
            );
          },
    );
  }
}

class _RepairTile extends StatelessWidget {
  const _RepairTile({required this.repair, required this.settings});

  final Repair repair;
  final AppSettingsState settings;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(child: Icon(_icon(repair.category))),
      title: Text(repair.title),
      subtitle: Text(
        '${_label(repair.category.name)} · ${_label(repair.status.name)}\n${DateFormat.yMMMd().format(repair.reportedDate.toLocal())}',
      ),
      isThreeLine: true,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(_money(repair.cost, settings)),
          if (repair.tenantChargeBillId != null)
            const Text('Tenant charge', style: TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );
}

/// Add-maintenance flow with local attachment imports.
class RepairEntryScreen extends ConsumerStatefulWidget {
  const RepairEntryScreen({super.key});

  @override
  ConsumerState<RepairEntryScreen> createState() => _RepairEntryScreenState();
}

class _RepairEntryScreenState extends ConsumerState<RepairEntryScreen> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _estimated = TextEditingController();
  final _cost = TextEditingController();
  final _notes = TextEditingController();
  EntityId? _propertyId;
  EntityId? _unitId;
  RepairCategory _category = RepairCategory.plumbing;
  RepairStatus _status = RepairStatus.open;
  RepairResponsibility _responsibility = RepairResponsibility.landlord;
  bool _recoverable = false;
  bool _saving = false;
  List<PlatformFile> _attachments = <PlatformFile>[];
  late Future<Result<List<Property>>> _properties;
  Future<Result<List<RentalUnit>>>? _units;

  @override
  void initState() {
    super.initState();
    _properties = DriftPropertyRepository(
      ref.read(appServicesProvider).database,
    ).list();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _estimated.dispose();
    _cost.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add repair')),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: <Widget>[
          FutureBuilder<Result<List<Property>>>(
            future: _properties,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<Result<List<Property>>> snapshot,
                ) {
                  final List<Property> values = switch (snapshot.data) {
                    Success<List<Property>>(:final value) => value,
                    _ => <Property>[],
                  };
                  return DropdownButtonFormField<EntityId>(
                    initialValue: _propertyId,
                    decoration: const InputDecoration(labelText: 'Property'),
                    validator: (EntityId? value) =>
                        value == null ? 'Select a property' : null,
                    items: values
                        .map(
                          (Property property) => DropdownMenuItem<EntityId>(
                            value: property.id,
                            child: Text(property.name),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (EntityId? value) => setState(() {
                      _propertyId = value;
                      _unitId = null;
                      _units = value == null
                          ? null
                          : DriftUnitRepository(
                              ref.read(appServicesProvider).database,
                            ).listByProperty(value);
                    }),
                  );
                },
          ),
          const SizedBox(height: 12),
          if (_units != null)
            FutureBuilder<Result<List<RentalUnit>>>(
              future: _units,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<RentalUnit>>> snapshot,
                  ) {
                    final List<RentalUnit> values = switch (snapshot.data) {
                      Success<List<RentalUnit>>(:final value) => value,
                      _ => <RentalUnit>[],
                    };
                    return DropdownButtonFormField<EntityId?>(
                      initialValue: _unitId,
                      decoration: const InputDecoration(
                        labelText: 'Unit (optional)',
                      ),
                      items: <DropdownMenuItem<EntityId?>>[
                        const DropdownMenuItem<EntityId?>(
                          value: null,
                          child: Text('Property-wide repair'),
                        ),
                        ...values.map(
                          (RentalUnit unit) => DropdownMenuItem<EntityId?>(
                            value: unit.id,
                            child: Text(unit.name),
                          ),
                        ),
                      ],
                      onChanged: (EntityId? value) =>
                          setState(() => _unitId = value),
                    );
                  },
            ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _title,
            decoration: const InputDecoration(labelText: 'Problem / title'),
            validator: (String? value) => value == null || value.trim().isEmpty
                ? 'Enter the problem'
                : null,
          ),
          TextField(
            controller: _description,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          DropdownButtonFormField<RepairCategory>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: RepairCategory.values
                .map(
                  (RepairCategory value) => DropdownMenuItem(
                    value: value,
                    child: Text(_label(value.name)),
                  ),
                )
                .toList(),
            onChanged: (RepairCategory? value) =>
                setState(() => _category = value ?? _category),
          ),
          DropdownButtonFormField<RepairStatus>(
            initialValue: _status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: RepairStatus.values
                .map(
                  (RepairStatus value) => DropdownMenuItem(
                    value: value,
                    child: Text(_label(value.name)),
                  ),
                )
                .toList(),
            onChanged: (RepairStatus? value) =>
                setState(() => _status = value ?? _status),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _estimated,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Estimated cost (৳)',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _cost,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Actual cost (৳)',
                  ),
                ),
              ),
            ],
          ),
          DropdownButtonFormField<RepairResponsibility>(
            initialValue: _responsibility,
            decoration: const InputDecoration(labelText: 'Paid by'),
            items: RepairResponsibility.values
                .map(
                  (RepairResponsibility value) => DropdownMenuItem(
                    value: value,
                    child: Text(_label(value.name)),
                  ),
                )
                .toList(),
            onChanged: (RepairResponsibility? value) =>
                setState(() => _responsibility = value ?? _responsibility),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Recover actual cost from tenant'),
            subtitle: const Text(
              'Adds an explicit line only to this month\'s draft bill.',
            ),
            value: _recoverable,
            onChanged: _unitId == null
                ? null
                : (bool value) => setState(() => _recoverable = value),
          ),
          TextField(
            controller: _notes,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Notes'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _pickAttachments,
            icon: const Icon(Icons.attach_file_rounded),
            label: Text(
              _attachments.isEmpty
                  ? 'Add photos or invoices'
                  : '${_attachments.length} attachment(s) selected',
            ),
          ),
          if (_attachments.isNotEmpty)
            Wrap(
              spacing: 6,
              children: _attachments
                  .map((PlatformFile file) => Chip(label: Text(file.name)))
                  .toList(growable: false),
            ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Saving…' : 'Save repair'),
          ),
        ],
      ),
    ),
  );

  Future<void> _pickAttachments() async {
    final List<PlatformFile> selected = await FilePicker.pickFiles();
    if (selected.isNotEmpty && mounted) {
      setState(() => _attachments = selected);
    }
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false) || _propertyId == null) {
      return;
    }
    setState(() => _saving = true);
    final database = ref.read(appServicesProvider).database;
    EntityId? tenancyId;
    if (_unitId != null) {
      final Result<Tenancy?> tenancy = await DriftTenancyRepository(database)
          .findActiveByUnit(_unitId!);
      if (tenancy case Success<Tenancy?>(:final value)) {
        tenancyId = value?.id;
      }
    }
    final result =
        await RepairUseCases(
          DriftRepairRepository(database),
          DriftBillingRepository(database),
        ).save(
          RepairInput(
            propertyId: _propertyId!,
            unitId: _unitId,
            tenancyId: tenancyId,
            category: _category,
            title: _title.text,
            description: _description.text,
            reportedDate: DateTime.now(),
            completedDate: _status == RepairStatus.completed
                ? DateTime.now()
                : null,
            estimatedCost: _moneyInput(_estimated.text),
            cost: _moneyInput(_cost.text) ?? Money.zero,
            responsibility: _responsibility,
            recoverableFromTenant: _recoverable,
            status: _status,
            notes: _notes.text,
          ),
        );
    if (result case Failure<Repair>(:final failure)) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message)));
      }
      return;
    }
    final Repair repair = (result as Success<Repair>).value;
    final RepairAttachmentStorage storage = RepairAttachmentStorage();
    final DriftRepairRepository repository = DriftRepairRepository(database);
    for (final PlatformFile file in _attachments) {
      if (file.path == null) continue;
      final Result<RepairAttachment> imported = await storage.importFile(
        repairId: repair.id,
        sourcePath: file.path!,
        originalFileName: file.name,
      );
      if (imported case Success<RepairAttachment>(:final value)) {
        await repository.saveAttachment(value);
      }
    }
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }
}

Money? _moneyInput(String value) {
  final String trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  final int? parsed = int.tryParse(trimmed);
  return parsed == null ? null : Money.fromTaka(parsed);
}

String _money(Money value, AppSettingsState settings) =>
    BariVaraFormatters.money(
      value,
      digitStyle: settings.digitStyle,
      showMinorUnits: true,
    );

String _label(String value) => value
    .replaceAllMapped(RegExp(r'([A-Z])'), (Match match) => ' ${match.group(1)}')
    .replaceFirstMapped(
      RegExp(r'^.'),
      (Match match) => match.group(0)!.toUpperCase(),
    );

IconData _icon(RepairCategory category) => switch (category) {
  RepairCategory.plumbing => Icons.plumbing_rounded,
  RepairCategory.electrical => Icons.electrical_services_rounded,
  RepairCategory.appliance => Icons.kitchen_rounded,
  RepairCategory.painting => Icons.format_paint_rounded,
  RepairCategory.structural => Icons.foundation_rounded,
  RepairCategory.cleaning => Icons.cleaning_services_rounded,
  RepairCategory.other => Icons.construction_rounded,
};

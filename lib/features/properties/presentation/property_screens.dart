import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/properties/application/property_unit_use_cases.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Property-list screen with operating summaries and a single creation action.
class PropertyListScreen extends ConsumerStatefulWidget {
  /// Creates the property list screen.
  const PropertyListScreen({super.key});

  @override
  ConsumerState<PropertyListScreen> createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends ConsumerState<PropertyListScreen> {
  late Future<Result<List<PropertySummary>>> _summaries;

  @override
  void initState() {
    super.initState();
    _summaries = _useCases.list();
  }

  PropertyUseCases get _useCases => PropertyUseCases(
    DriftPropertyRepository(ref.read(appServicesProvider).database),
  );

  void _refresh() {
    setState(() => _summaries = _useCases.list());
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(text.propertiesAndUnits)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? saved = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) => const PropertyFormScreen(),
            ),
          );
          if (saved ?? false) {
            _refresh();
          }
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(text.addProperty),
      ),
      body: FutureBuilder<Result<List<PropertySummary>>>(
        future: _summaries,
        builder:
            (
              BuildContext context,
              AsyncSnapshot<Result<List<PropertySummary>>> snapshot,
            ) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              final Result<List<PropertySummary>>? result = snapshot.data;
              if (result case Success<List<PropertySummary>>(:final value)) {
                if (value.isEmpty) {
                  return _EmptyState(message: text.noPropertiesYet);
                }
                return RefreshIndicator(
                  onRefresh: () async => _refresh(),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: value.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (BuildContext context, int index) =>
                        _PropertyCard(
                          summary: value[index],
                          onTap: () async {
                            final bool? changed = await Navigator.of(context)
                                .push<bool>(
                                  MaterialPageRoute<bool>(
                                    builder: (BuildContext context) =>
                                        PropertyDetailsScreen(
                                          property: value[index].property,
                                        ),
                                  ),
                                );
                            if (changed ?? false) {
                              _refresh();
                            }
                          },
                        ),
                  ),
                );
              }
              return _EmptyState(message: text.couldNotSave);
            },
      ),
    );
  }
}

/// Detail screen organized into the sections specified for a property.
class PropertyDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a property detail screen.
  const PropertyDetailsScreen({required this.property, super.key});

  final Property property;

  @override
  ConsumerState<PropertyDetailsScreen> createState() =>
      _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends ConsumerState<PropertyDetailsScreen> {
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, bool? result) {
        if (!didPop) {
          Navigator.of(context).pop(_changed);
        }
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.property.name),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: text.editProperty,
                onPressed: () async {
                  final bool? saved = await Navigator.of(context).push<bool>(
                    MaterialPageRoute<bool>(
                      builder: (BuildContext context) =>
                          PropertyFormScreen(existing: widget.property),
                    ),
                  );
                  if (saved ?? false) {
                    _changed = true;
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  }
                },
              ),
              PopupMenuButton<String>(
                onSelected: (String value) async {
                  if (value == 'archive' && await _confirmArchive(context)) {
                    final Result<void> result = await PropertyUseCases(
                      DriftPropertyRepository(
                        ref.read(appServicesProvider).database,
                      ),
                    ).archive(widget.property.id);
                    if (!context.mounted) {
                      return;
                    }
                    if (result.isSuccess) {
                      _changed = true;
                      Navigator.of(context).pop(true);
                    } else {
                      _showFailure(context, result);
                    }
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'archive',
                    child: Text(text.archiveProperty),
                  ),
                ],
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: <Tab>[
                Tab(text: text.units),
                Tab(text: text.tenantsAndOccupancy),
                Tab(text: text.monthlySummary),
                Tab(text: text.repairs),
                Tab(text: text.propertySettings),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _PropertyUnitsTab(
                property: widget.property,
                onChanged: () => setState(() => _changed = true),
              ),
              _TabPlaceholder(
                icon: Icons.people_outline,
                label: text.tenantsAndOccupancy,
              ),
              _TabPlaceholder(
                icon: Icons.calendar_month_outlined,
                label: text.monthlySummary,
              ),
              _TabPlaceholder(icon: Icons.build_outlined, label: text.repairs),
              _PropertyInformation(property: widget.property),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmArchive(BuildContext context) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(text.archiveProperty),
            content: Text(text.archivePropertyMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(text.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(text.confirmArchive),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class _PropertyUnitsTab extends ConsumerStatefulWidget {
  const _PropertyUnitsTab({required this.property, required this.onChanged});

  final Property property;
  final VoidCallback onChanged;

  @override
  ConsumerState<_PropertyUnitsTab> createState() => _PropertyUnitsTabState();
}

class _PropertyUnitsTabState extends ConsumerState<_PropertyUnitsTab> {
  UnitFilter _filter = UnitFilter.all;
  late Future<Result<List<UnitSummary>>> _units;

  @override
  void initState() {
    super.initState();
    _units = _useCases.listByProperty(widget.property.id);
  }

  UnitUseCases get _useCases =>
      UnitUseCases(DriftUnitRepository(ref.read(appServicesProvider).database));

  void _reload() {
    setState(
      () => _units = _useCases.listByProperty(
        widget.property.id,
        filter: _filter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final bool? saved = await Navigator.of(context).push<bool>(
            MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  UnitFormScreen(property: widget.property),
            ),
          );
          if (saved ?? false) {
            widget.onChanged();
            _reload();
          }
        },
        icon: const Icon(Icons.add_rounded),
        label: Text(text.addUnit),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<UnitFilter>(
              segments: <ButtonSegment<UnitFilter>>[
                ButtonSegment<UnitFilter>(
                  value: UnitFilter.all,
                  label: Text(text.all),
                ),
                ButtonSegment<UnitFilter>(
                  value: UnitFilter.occupied,
                  label: Text(text.occupied),
                ),
                ButtonSegment<UnitFilter>(
                  value: UnitFilter.vacant,
                  label: Text(text.vacant),
                ),
                ButtonSegment<UnitFilter>(
                  value: UnitFilter.archived,
                  label: Text(text.archived),
                ),
              ],
              selected: <UnitFilter>{_filter},
              onSelectionChanged: (Set<UnitFilter> selected) {
                _filter = selected.first;
                _reload();
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<Result<List<UnitSummary>>>(
              future: _units,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<UnitSummary>>> snapshot,
                  ) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data case Success<List<UnitSummary>>(
                      :final value,
                    )) {
                      if (value.isEmpty) {
                        return _EmptyState(message: text.noUnitsYet);
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                        itemCount: value.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (BuildContext context, int index) =>
                            _UnitCard(
                              summary: value[index],
                              onTap: () async {
                                final bool? saved = await Navigator.of(context)
                                    .push<bool>(
                                      MaterialPageRoute<bool>(
                                        builder: (BuildContext context) =>
                                            UnitFormScreen(
                                              property: widget.property,
                                              existing: value[index].unit,
                                            ),
                                      ),
                                    );
                                if (saved ?? false) {
                                  widget.onChanged();
                                  _reload();
                                }
                              },
                            ),
                      );
                    }
                    return _EmptyState(message: text.couldNotSave);
                  },
            ),
          ),
        ],
      ),
    );
  }
}

/// Localized create/edit property form with validation and dirty-form warning.
class PropertyFormScreen extends ConsumerStatefulWidget {
  /// Creates a property form, optionally initialized from [existing].
  const PropertyFormScreen({this.existing, super.key});

  final Property? existing;

  @override
  ConsumerState<PropertyFormScreen> createState() => _PropertyFormScreenState();
}

class _PropertyFormScreenState extends ConsumerState<PropertyFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _area;
  late final TextEditingController _district;
  late final TextEditingController _notes;
  late PropertyType _type;
  bool _dirty = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final Property? property = widget.existing;
    _name = TextEditingController(text: property?.name);
    _address = TextEditingController(text: property?.addressLine);
    _area = TextEditingController(text: property?.area);
    _district = TextEditingController(text: property?.cityDistrict);
    _notes = TextEditingController(text: property?.notes);
    _type = property?.type ?? PropertyType.residential;
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _area.dispose();
    _district.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return PopScope<Object?>(
      canPop: !_dirty || _saving,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop && _dirty) {
          _discardDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.existing == null ? text.addProperty : text.editProperty,
          ),
        ),
        body: Form(
          key: _formKey,
          onChanged: () => _dirty = true,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: text.propertyName),
                validator: (String? value) =>
                    value == null || value.trim().isEmpty
                    ? text.requiredField
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PropertyType>(
                initialValue: _type,
                decoration: InputDecoration(labelText: text.propertyType),
                items: PropertyType.values
                    .map(
                      (PropertyType type) => DropdownMenuItem<PropertyType>(
                        value: type,
                        child: Text(_propertyTypeLabel(text, type)),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (PropertyType? value) {
                  if (value != null) {
                    setState(() {
                      _type = value;
                      _dirty = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _address,
                decoration: InputDecoration(labelText: text.address),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _area,
                decoration: InputDecoration(labelText: text.area),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _district,
                decoration: InputDecoration(labelText: text.cityDistrict),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notes,
                maxLines: 3,
                decoration: InputDecoration(labelText: text.notesOptional),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(text.saveProperty),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final PropertyUseCases useCases = PropertyUseCases(
      DriftPropertyRepository(ref.read(appServicesProvider).database),
    );
    final PropertyInput input = PropertyInput(
      name: _name.text,
      type: _type,
      addressLine: _address.text,
      area: _area.text,
      cityDistrict: _district.text,
      notes: _notes.text,
    );
    Result<Property> result = widget.existing == null
        ? await useCases.create(input)
        : await useCases.update(widget.existing!, input);
    if (!mounted) {
      return;
    }
    if (result case Failure<Property>()) {
      final AppLocalizations text = AppLocalizations.of(context)!;
      final bool? continueDuplicate = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(text.propertyName),
          content: Text((result as Failure<Property>).failure.message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(text.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(text.saveProperty),
            ),
          ],
        ),
      );
      if (continueDuplicate ?? false) {
        result = widget.existing == null
            ? await useCases.create(input, allowDuplicateName: true)
            : await useCases.update(
                widget.existing!,
                input,
                allowDuplicateName: true,
              );
      }
    }
    if (!mounted) return;
    setState(() => _saving = false);
    if (result case Success<Property>()) {
      Navigator.of(context).pop(true);
    } else {
      _showFailure(context, result);
    }
  }

  Future<void> _discardDialog(BuildContext context) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool? discard = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(text.discardChangesTitle),
        content: Text(text.discardChangesMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(text.keepEditing),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(text.discard),
          ),
        ],
      ),
    );
    if ((discard ?? false) && context.mounted) Navigator.of(context).pop();
  }
}

/// Localized create/edit unit form with rent and utility defaults.
class UnitFormScreen extends ConsumerStatefulWidget {
  /// Creates a unit form under [property], optionally editing [existing].
  const UnitFormScreen({required this.property, this.existing, super.key});

  final Property property;
  final RentalUnit? existing;

  @override
  ConsumerState<UnitFormScreen> createState() => _UnitFormScreenState();
}

class _UnitFormScreenState extends ConsumerState<UnitFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _floor;
  late final TextEditingController _rent;
  late final TextEditingController _service;
  late final TextEditingController _gas;
  late final TextEditingController _water;
  late final TextEditingController _notes;
  String _unitType = 'apartment';
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    final RentalUnit? unit = widget.existing;
    _name = TextEditingController(text: unit?.name);
    _floor = TextEditingController(text: unit?.floorName);
    _rent = TextEditingController(text: _wholeTaka(unit?.defaultRent));
    _service = TextEditingController(
      text: _wholeTaka(unit?.defaultServiceCharge ?? Money.zero),
    );
    _gas = TextEditingController(
      text: _wholeTaka(unit?.defaultGasCharge ?? Money.zero),
    );
    _water = TextEditingController(
      text: _wholeTaka(unit?.defaultWaterCharge ?? Money.zero),
    );
    _notes = TextEditingController(text: unit?.notes);
    _unitType = unit?.unitType ?? 'apartment';
  }

  @override
  void dispose() {
    _name.dispose();
    _floor.dispose();
    _rent.dispose();
    _service.dispose();
    _gas.dispose();
    _water.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return PopScope<Object?>(
      canPop: !_dirty,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop && _dirty) _discardDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.existing == null ? text.addUnit : text.editUnit),
        ),
        body: Form(
          key: _formKey,
          onChanged: () => _dirty = true,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: text.unitName),
                validator: (String? value) =>
                    value == null || value.trim().isEmpty
                    ? text.requiredField
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _floor,
                decoration: InputDecoration(labelText: text.floor),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _unitType,
                decoration: InputDecoration(labelText: text.unitType),
                items: <String>['apartment', 'room', 'shop', 'office']
                    .map(
                      (String type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(_unitTypeLabel(text, type)),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _unitType = value;
                      _dirty = true;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rent,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: text.monthlyRent,
                  prefixText: '৳ ',
                ),
                validator: _amountValidator(text),
              ),
              const SizedBox(height: 16),
              Text(
                text.utilityDefaults,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _service,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: text.serviceCharge,
                  prefixText: '৳ ',
                ),
                validator: _amountValidator(text),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gas,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: text.gasCharge,
                  prefixText: '৳ ',
                ),
                validator: _amountValidator(text),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _water,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: text.waterCharge,
                  prefixText: '৳ ',
                ),
                validator: _amountValidator(text),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notes,
                maxLines: 3,
                decoration: InputDecoration(labelText: text.notesOptional),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _save, child: Text(text.saveUnit)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final UnitInput input = UnitInput(
      name: _name.text,
      floorName: _floor.text,
      unitType: _unitType,
      defaultRent: Money.fromTaka(int.parse(_rent.text.trim())),
      defaultServiceCharge: Money.fromTaka(int.parse(_service.text.trim())),
      defaultGasCharge: Money.fromTaka(int.parse(_gas.text.trim())),
      defaultWaterCharge: Money.fromTaka(int.parse(_water.text.trim())),
      notes: _notes.text,
    );
    final UnitUseCases useCases = UnitUseCases(
      DriftUnitRepository(ref.read(appServicesProvider).database),
    );
    final Result<RentalUnit> result = widget.existing == null
        ? await useCases.create(widget.property.id, input)
        : await useCases.update(widget.existing!, input);
    if (!mounted) {
      return;
    }
    if (result.isSuccess) {
      Navigator.of(context).pop(true);
    } else {
      _showFailure(context, result);
    }
  }

  Future<void> _discardDialog(BuildContext context) async {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final bool? discard = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(text.discardChangesTitle),
        content: Text(text.discardChangesMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(text.keepEditing),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(text.discard),
          ),
        ],
      ),
    );
    if ((discard ?? false) && context.mounted) Navigator.of(context).pop();
  }
}

class _PropertyCard extends ConsumerWidget {
  const _PropertyCard({required this.summary, required this.onTap});

  final PropertySummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                summary.property.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (summary.property.addressLine != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(summary.property.addressLine!),
                ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _Metric(
                      icon: Icons.home_work_outlined,
                      label: text.unitCount,
                      value: '${summary.unitCount}',
                    ),
                  ),
                  Expanded(
                    child: _Metric(
                      icon: Icons.person_outline,
                      label: text.occupied,
                      value: '${summary.occupiedCount}',
                    ),
                  ),
                  Expanded(
                    child: _Metric(
                      icon: Icons.key_outlined,
                      label: text.vacant,
                      value: '${summary.vacantCount}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${text.currentDue}  ${BariVaraFormatters.money(summary.currentMonthDue, digitStyle: settings.digitStyle)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnitCard extends ConsumerWidget {
  const _UnitCard({required this.summary, required this.onTap});

  final UnitSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    final Color color = _availabilityColor(context, summary.availability);
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(summary.unit.name),
        subtitle: Text(
          summary.activeTenantName ?? summary.unit.floorName ?? '',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _StatusChip(
              label: _availabilityLabel(text, summary.availability),
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              BariVaraFormatters.money(
                summary.unit.defaultRent,
                digitStyle: settings.digitStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Icon(icon, size: 20),
      const SizedBox(height: 4),
      Text(value, style: Theme.of(context).textTheme.titleMedium),
      Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ],
  );
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Chip(
    label: Text(label),
    visualDensity: VisualDensity.compact,
    backgroundColor: color.withValues(alpha: .15),
    side: BorderSide.none,
    labelStyle: TextStyle(color: color),
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(message, textAlign: TextAlign.center),
    ),
  );
}

class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 48),
        const SizedBox(height: 12),
        Text(label),
      ],
    ),
  );
}

class _PropertyInformation extends StatelessWidget {
  const _PropertyInformation({required this.property});
  final Property property;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: <Widget>[
      Text(property.name, style: Theme.of(context).textTheme.titleLarge),
      if (property.addressLine != null)
        ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: Text(property.addressLine!),
        ),
      if (property.area != null || property.cityDistrict != null)
        ListTile(
          leading: const Icon(Icons.map_outlined),
          title: Text(
            [
              property.area,
              property.cityDistrict,
            ].whereType<String>().join(', '),
          ),
        ),
      if (property.notes != null)
        ListTile(
          leading: const Icon(Icons.notes_outlined),
          title: Text(property.notes!),
        ),
    ],
  );
}

String? Function(String?) _amountValidator(AppLocalizations text) =>
    (String? value) {
      final int? amount = int.tryParse(value?.trim() ?? '');
      return amount == null || amount < 0 ? text.invalidAmount : null;
    };
String _wholeTaka(Money? value) =>
    value == null ? '' : (value.poisha ~/ Money.poishaPerTaka).toString();
String _propertyTypeLabel(AppLocalizations text, PropertyType type) =>
    switch (type) {
      PropertyType.residential => text.residential,
      PropertyType.commercial => text.commercial,
      PropertyType.mixedUse => text.mixedUse,
      PropertyType.other => text.otherType,
    };
String _unitTypeLabel(AppLocalizations text, String type) => switch (type) {
  'room' => text.room,
  'shop' => text.shop,
  'office' => text.office,
  _ => text.apartment,
};
String _availabilityLabel(AppLocalizations text, UnitAvailability value) =>
    switch (value) {
      UnitAvailability.occupied => text.occupied,
      UnitAvailability.vacant => text.vacant,
      UnitAvailability.reserved => text.reserved,
      UnitAvailability.archived => text.archived,
    };
Color _availabilityColor(BuildContext context, UnitAvailability value) =>
    switch (value) {
      UnitAvailability.occupied => Theme.of(context).colorScheme.primary,
      UnitAvailability.vacant => Colors.orange.shade800,
      UnitAvailability.reserved => Colors.blue.shade700,
      UnitAvailability.archived => Theme.of(context).colorScheme.outline,
    };
void _showFailure<T>(BuildContext context, Result<T> result) {
  final String message = switch (result) {
    Failure<T>(:final failure) => failure.message,
    Success<T>() => '',
  };
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

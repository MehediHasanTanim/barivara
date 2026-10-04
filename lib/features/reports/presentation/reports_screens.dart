import 'dart:async';

import 'package:barivara/app/app_services.dart';
import 'package:barivara/core/database/drift_repositories.dart';
import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/core/notifications/local_notification_service.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/billing/presentation/bills_screens.dart';
import 'package:barivara/features/payments/presentation/payments_screens.dart';
import 'package:barivara/features/repairs/presentation/repairs_screen.dart';
import 'package:barivara/features/reports/application/dashboard_query_service.dart';
import 'package:barivara/features/settings/application/settings_controller.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:barivara/features/tenants/presentation/tenant_screens.dart';
import 'package:barivara/l10n/generated/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Compact monthly reports intended for operational visibility, not accounting.
class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  late DashboardQueryService _reports;
  late BillingMonth _month;
  late Future<Result<MonthlyCollectionReport>> _collection;
  late Future<Result<List<TenantDueReportRow>>> _dues;
  late Future<Result<List<PaymentMethodTotal>>> _methods;
  late Future<Result<List<Property>>> _properties;
  EntityId? _propertyId;
  Future<Result<PropertyOperationalReport>>? _propertyReport;

  @override
  void initState() {
    super.initState();
    _reports = DashboardQueryService(ref.read(appServicesProvider).database);
    _properties = DriftPropertyRepository(
      ref.read(appServicesProvider).database,
    ).list();
    _month = BillingMonth.fromDate(DateTime.now());
    _reload();
  }

  void _reload() {
    final DateRange range = DateRange(
      DateTime(_month.year, _month.month),
      DateTime(_month.year, _month.month + 1).subtract(const Duration(days: 1)),
    );
    _collection = _reports.monthlyCollection(_month);
    _dues = _reports.tenantDues();
    _methods = _reports.paymentMethods(range);
    if (_propertyId != null) {
      _propertyReport = _reports.propertyIncome(
        propertyId: _propertyId!.value,
        range: range,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: <Widget>[
          IconButton(
            onPressed: _previous,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          IconButton(
            onPressed: _next,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(_reload),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: <Widget>[
            Text(
              'Operational summary - ${_month.key}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            const Text('This is not a formal accounting or tax report.'),
            const SizedBox(height: 12),
            FutureBuilder<Result<MonthlyCollectionReport>>(
              future: _collection,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<MonthlyCollectionReport>> snapshot,
                  ) {
                    final MonthlyCollectionReport? report = switch (snapshot
                        .data) {
                      Success<MonthlyCollectionReport>(:final value) => value,
                      _ => null,
                    };
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: report == null
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text('Monthly collection'),
                                  const SizedBox(height: 10),
                                  _line(
                                    'Expected',
                                    _money(report.expected, settings),
                                  ),
                                  _line(
                                    'Collected',
                                    _money(report.collected, settings),
                                  ),
                                  _line(
                                    'Outstanding',
                                    _money(report.outstanding, settings),
                                  ),
                                  _line(
                                    'Collection rate',
                                    '${report.collectionPercent.toStringAsFixed(1)}%',
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
            ),
            const SizedBox(height: 12),
            Text(
              'Property operational view',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            FutureBuilder<Result<List<Property>>>(
              future: _properties,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<Property>>> snapshot,
                  ) {
                    final List<Property> properties = switch (snapshot.data) {
                      Success<List<Property>>(:final value) => value,
                      _ => <Property>[],
                    };
                    return DropdownButtonFormField<EntityId?>(
                      initialValue: _propertyId,
                      decoration: const InputDecoration(labelText: 'Property'),
                      items: <DropdownMenuItem<EntityId?>>[
                        const DropdownMenuItem<EntityId?>(
                          value: null,
                          child: Text('Select property'),
                        ),
                        ...properties.map(
                          (Property property) => DropdownMenuItem<EntityId?>(
                            value: property.id,
                            child: Text(property.name),
                          ),
                        ),
                      ],
                      onChanged: (EntityId? value) => setState(() {
                        _propertyId = value;
                        _propertyReport = value == null
                            ? null
                            : _reports.propertyIncome(
                                propertyId: value.value,
                                range: DateRange(
                                  DateTime(_month.year, _month.month),
                                  DateTime(
                                    _month.year,
                                    _month.month + 1,
                                  ).subtract(const Duration(days: 1)),
                                ),
                              );
                      }),
                    );
                  },
            ),
            if (_propertyReport != null)
              FutureBuilder<Result<PropertyOperationalReport>>(
                future: _propertyReport,
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<Result<PropertyOperationalReport>> snapshot,
                    ) {
                      final PropertyOperationalReport? report =
                          switch (snapshot.data) {
                            Success<PropertyOperationalReport>(:final value) =>
                              value,
                            _ => null,
                          };
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: report == null
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  children: <Widget>[
                                    _line(
                                      'Rent billed',
                                      _money(report.rentBilled, settings),
                                    ),
                                    _line(
                                      'Utility/service billed',
                                      _money(
                                        report.utilityServiceBilled,
                                        settings,
                                      ),
                                    ),
                                    _line(
                                      'Received',
                                      _money(report.received, settings),
                                    ),
                                    _line(
                                      'Repair expenses',
                                      _money(report.repairExpenses, settings),
                                    ),
                                    _line(
                                      'Net operational cash',
                                      _money(
                                        report.netOperationalCash,
                                        settings,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
              ),
            const SizedBox(height: 12),
            Text(
              'Payment methods',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            FutureBuilder<Result<List<PaymentMethodTotal>>>(
              future: _methods,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<PaymentMethodTotal>>> snapshot,
                  ) {
                    final List<PaymentMethodTotal> values = switch (snapshot
                        .data) {
                      Success<List<PaymentMethodTotal>>(:final value) => value,
                      _ => <PaymentMethodTotal>[],
                    };
                    return Card(
                      child: Column(
                        children: values.isEmpty
                            ? const <Widget>[
                                ListTile(
                                  title: Text('No posted payments this month.'),
                                ),
                              ]
                            : values
                                  .map(
                                    (PaymentMethodTotal item) => ListTile(
                                      title: Text(_method(item.method)),
                                      trailing: Text(
                                        _money(item.amount, settings),
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                      ),
                    );
                  },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Tenant dues',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  onPressed: _exportDues,
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('CSV'),
                ),
              ],
            ),
            FutureBuilder<Result<List<TenantDueReportRow>>>(
              future: _dues,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<Result<List<TenantDueReportRow>>> snapshot,
                  ) {
                    final List<TenantDueReportRow> values = switch (snapshot
                        .data) {
                      Success<List<TenantDueReportRow>>(:final value) => value,
                      _ => <TenantDueReportRow>[],
                    };
                    return Card(
                      child: Column(
                        children: values.isEmpty
                            ? const <Widget>[
                                ListTile(title: Text('No tenant dues.')),
                              ]
                            : values
                                  .map(
                                    (TenantDueReportRow row) => ListTile(
                                      title: Text(row.tenantName),
                                      subtitle: Text(
                                        '${row.unitName} · oldest unpaid ${row.oldestUnpaidMonth.key}',
                                      ),
                                      trailing: Text(
                                        _money(row.outstanding, settings),
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                      ),
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }

  void _previous() => setState(() {
    _month = BillingMonth(
      _month.month == 1 ? _month.year - 1 : _month.year,
      _month.month == 1 ? 12 : _month.month - 1,
    );
    _reload();
  });

  void _next() => setState(() {
    _month = BillingMonth(
      _month.month == 12 ? _month.year + 1 : _month.year,
      _month.month == 12 ? 1 : _month.month + 1,
    );
    _reload();
  });

  Future<void> _exportDues() async {
    final Result<List<TenantDueReportRow>> result = await _dues;
    if (result case Success<List<TenantDueReportRow>>(:final value)) {
      await FilePicker.saveFile(
        dialogTitle: 'Export tenant due report',
        fileName: 'tenant-dues-${_month.key}.csv',
        bytes: ReportsCsvExporter.tenantDues(value),
        mimeType: 'text/csv;charset=utf-8',
        type: FileType.custom,
        allowedExtensions: const <String>['csv'],
      );
    }
  }
}

Widget _line(String label, String value) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 3),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[Text(label), Text(value)],
  ),
);

String _money(Money value, AppSettingsState settings) =>
    BariVaraFormatters.money(
      value,
      digitStyle: settings.digitStyle,
      showMinorUnits: true,
    );
String _method(PaymentMethod value) => switch (value) {
  PaymentMethod.bankTransfer => 'Bank transfer',
  _ => value.name[0].toUpperCase() + value.name.substring(1),
};

/// Home dashboard with operational alerts, quick actions, and local search.
class DashboardHomeScreen extends ConsumerStatefulWidget {
  const DashboardHomeScreen({super.key});
  @override
  ConsumerState<DashboardHomeScreen> createState() =>
      _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends ConsumerState<DashboardHomeScreen> {
  DashboardQueryService? _service;
  Future<Result<DashboardData>>? _dashboard;
  StreamSubscription<NotificationRoute>? _notificationRoutes;

  @override
  void initState() {
    super.initState();
    try {
      _service = DashboardQueryService(ref.read(appServicesProvider).database);
      _dashboard = _service!.dashboard();
      final LocalNotificationService notifications = ref
          .read(appServicesProvider)
          .notifications;
      _notificationRoutes = notifications.routes.listen(_openNotificationRoute);
      final NotificationRoute? initialRoute = notifications.takeInitialRoute();
      if (initialRoute != null) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _openNotificationRoute(initialRoute),
        );
      }
    } on Object {
      // Widget-only contexts can render a harmless shell without bootstrap.
    }
  }

  @override
  void dispose() {
    _notificationRoutes?.cancel();
    super.dispose();
  }

  void _openNotificationRoute(NotificationRoute route) {
    if (!mounted) return;
    switch (route) {
      case NotificationRoute.bills:
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) => const BillsDashboardScreen()),
        );
      case NotificationRoute.dues:
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) => const PaymentsDuesScreen()),
        );
      case NotificationRoute.dashboard:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppSettingsState settings = ref.watch(settingsControllerProvider);
    final AppLocalizations text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(text.appTitle),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search records',
            icon: const Icon(Icons.search_rounded),
            onPressed: _service == null
                ? null
                : () => showSearch<void>(
                    context: context,
                    delegate: _LocalSearchDelegate(_service!),
                  ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (_service != null) {
            setState(() => _dashboard = _service!.dashboard());
          }
        },
        child: FutureBuilder<Result<DashboardData>>(
          future: _dashboard,
          builder:
              (
                BuildContext context,
                AsyncSnapshot<Result<DashboardData>> snapshot,
              ) {
                if (_dashboard == null) {
                  return Center(child: Text(text.appSubtitle));
                }
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final DashboardData? data = switch (snapshot.data) {
                  Success<DashboardData>(:final value) => value,
                  _ => null,
                };
                if (data == null) {
                  return const Center(
                    child: Text('Dashboard data could not be loaded.'),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                  children: <Widget>[
                    Text(
                      'Current month · ${data.month.key}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            _line('Expected', _money(data.expected, settings)),
                            _line(
                              'Collected',
                              _money(data.collected, settings),
                            ),
                            _line(
                              'Outstanding',
                              _money(data.currentOutstanding, settings),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (data.overdue.poisha > 0)
                      Card(
                        color: Theme.of(context).colorScheme.errorContainer,
                        child: ListTile(
                          leading: const Icon(Icons.warning_amber_rounded),
                          title: const Text('Outstanding rent alert'),
                          subtitle: Text(
                            '${_money(data.overdue, settings)} is overdue from prior months.',
                          ),
                          onTap: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => const ReportsScreen(),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      'Quick actions',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    _QuickActions(),
                    const SizedBox(height: 12),
                    Text(
                      'Properties & units',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _stat('${data.activeProperties}', 'Properties'),
                            _stat('${data.totalUnits}', 'Units'),
                            _stat('${data.occupiedUnits}', 'Occupied'),
                            _stat('${data.vacantUnits}', 'Vacant'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Recent payments',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Card(
                      child: Column(
                        children: data.recentPayments.isEmpty
                            ? const <Widget>[
                                ListTile(
                                  title: Text('No posted payments yet.'),
                                ),
                              ]
                            : data.recentPayments
                                  .map(
                                    (DashboardPayment payment) => ListTile(
                                      leading: const Icon(
                                        Icons.payments_rounded,
                                      ),
                                      title: Text(payment.tenantName),
                                      subtitle: Text(
                                        '${payment.unitName ?? 'No unit'} · ${_method(payment.method)}',
                                      ),
                                      trailing: Text(
                                        _money(payment.amount, settings),
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: <Widget>[
      _quick(
        context,
        Icons.receipt_long_rounded,
        'Generate bill',
        const BillsDashboardScreen(),
      ),
      _quick(
        context,
        Icons.payments_rounded,
        'Record payment',
        const PaymentsDuesScreen(),
      ),
      _quick(
        context,
        Icons.person_add_alt_rounded,
        'Add tenant',
        const TenantListScreen(),
      ),
      _quick(
        context,
        Icons.construction_rounded,
        'Add repair',
        const RepairsScreen(),
      ),
      _quick(
        context,
        Icons.share_rounded,
        'Share receipt',
        const PaymentsDuesScreen(),
      ),
    ],
  );
  Widget _quick(
    BuildContext context,
    IconData icon,
    String text,
    Widget page,
  ) => ActionChip(
    avatar: Icon(icon, size: 18),
    label: Text(text),
    onPressed: () =>
        Navigator.of(context)
            .push<void>(MaterialPageRoute<void>(builder: (_) => page)),
  );
}

Widget _stat(String value, String label) => Column(
  children: <Widget>[
    Text(
      value,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Text(label),
  ],
);

class _LocalSearchDelegate extends SearchDelegate<void> {
  _LocalSearchDelegate(this._service);
  final DashboardQueryService _service;
  @override
  List<Widget>? buildActions(BuildContext context) => <Widget>[
    IconButton(
      icon: const Icon(Icons.clear_rounded),
      onPressed: () => query = '',
    ),
  ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_rounded),
    onPressed: () => close(context, null),
  );
  @override
  Widget buildResults(BuildContext context) => _results();
  @override
  Widget buildSuggestions(BuildContext context) => query.trim().isEmpty
      ? const Center(
          child: Text(
            'Search tenants, phones, properties, units, or receipt numbers.',
          ),
        )
      : _results();
  Widget _results() => FutureBuilder<Result<List<GlobalSearchResult>>>(
    future: _service.search(query),
    builder:
        (
          BuildContext context,
          AsyncSnapshot<Result<List<GlobalSearchResult>>> snapshot,
        ) {
          final List<GlobalSearchResult> values = switch (snapshot.data) {
            Success<List<GlobalSearchResult>>(:final value) => value,
            _ => <GlobalSearchResult>[],
          };
          return ListView(
            children: values
                .map(
                  (GlobalSearchResult result) => ListTile(
                    leading: Icon(switch (result.kind) {
                      'tenant' => Icons.person_outline_rounded,
                      'property' => Icons.apartment_rounded,
                      'unit' => Icons.meeting_room_outlined,
                      _ => Icons.receipt_long_outlined,
                    }),
                    title: Text(result.title),
                    subtitle: Text(result.subtitle),
                  ),
                )
                .toList(growable: false),
          );
        },
  );
}

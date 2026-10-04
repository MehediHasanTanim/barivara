import 'dart:convert';

import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:drift/drift.dart';

/// Fast, read-only operational metrics for the landlord dashboard and reports.
class DashboardQueryService {
  const DashboardQueryService(this._database);

  final AppDatabase _database;

  Future<Result<DashboardData>> dashboard({
    BillingMonth? month,
  }) => _guard(() async {
    final BillingMonth period = month ?? BillingMonth.fromDate(DateTime.now());
    final DateTime start = DateTime(period.year, period.month).toUtc();
    final DateTime end = DateTime(period.year, period.month + 1).toUtc();
    final List<int> counts = await Future.wait<int>(<Future<int>>[
      _scalar('SELECT COUNT(*) AS value FROM properties WHERE is_archived = 0'),
      _scalar('SELECT COUNT(*) AS value FROM units WHERE is_archived = 0'),
      _scalar('''
        SELECT COUNT(DISTINCT units.id) AS value FROM units
        INNER JOIN tenancies ON tenancies.unit_id = units.id
        WHERE units.is_archived = 0 AND tenancies.status = 'active'
      '''),
      _scalar(
        '''
        SELECT COALESCE(SUM(total_poisha), 0) AS value FROM monthly_bills
        WHERE billing_year = ? AND billing_month = ? AND status <> 'cancelled'
      ''',
        <Variable<Object>>[
          Variable<int>(period.year),
          Variable<int>(period.month),
        ],
      ),
      _scalar(
        '''
        SELECT COALESCE(SUM(amount_poisha), 0) AS value FROM payments
        WHERE status = 'posted' AND payment_date >= ? AND payment_date < ?
      ''',
        <Variable<Object>>[Variable<DateTime>(start), Variable<DateTime>(end)],
      ),
      _scalar(
        '''
        SELECT COALESCE(SUM(balance_poisha), 0) AS value FROM monthly_bills
        WHERE billing_year = ? AND billing_month = ?
          AND status NOT IN ('draft', 'cancelled')
      ''',
        <Variable<Object>>[
          Variable<int>(period.year),
          Variable<int>(period.month),
        ],
      ),
      _scalar(
        '''
        SELECT COALESCE(SUM(balance_poisha), 0) AS value FROM monthly_bills
        WHERE (billing_year < ? OR (billing_year = ? AND billing_month < ?))
          AND status NOT IN ('draft', 'cancelled')
      ''',
        <Variable<Object>>[
          Variable<int>(period.year),
          Variable<int>(period.year),
          Variable<int>(period.month),
        ],
      ),
    ]);
    final List<QueryRow> paymentRows = await _database.customSelect('''
      SELECT payments.id, payments.amount_poisha, payments.payment_date,
             payments.payment_method, tenants.full_name, units.name AS unit_name
      FROM payments
      LEFT JOIN tenants ON tenants.id = payments.tenant_id
      LEFT JOIN tenancies ON tenancies.id = payments.tenancy_id
      LEFT JOIN units ON units.id = tenancies.unit_id
      WHERE payments.status = 'posted'
      ORDER BY payments.payment_date DESC, payments.created_at DESC LIMIT 5
      ''').get();
    final int unitCount = counts[1];
    return DashboardData(
      month: period,
      activeProperties: counts[0],
      totalUnits: unitCount,
      occupiedUnits: counts[2],
      vacantUnits: unitCount - counts[2],
      expected: Money.fromPoisha(counts[3]),
      collected: Money.fromPoisha(counts[4]),
      currentOutstanding: Money.fromPoisha(counts[5]),
      overdue: Money.fromPoisha(counts[6]),
      recentPayments: paymentRows.map(_payment).toList(growable: false),
    );
  });

  Future<Result<MonthlyCollectionReport>> monthlyCollection(
    BillingMonth month,
  ) => _guard(() async {
    final DashboardData summary =
        (await dashboard(month: month) as Success<DashboardData>).value;
    return MonthlyCollectionReport(
      month: month,
      expected: summary.expected,
      collected: summary.collected,
      outstanding: summary.currentOutstanding,
    );
  });

  Future<Result<List<TenantDueReportRow>>> tenantDues() => _guard(() async {
    final List<QueryRow> rows = await _database.customSelect('''
      SELECT tenants.id AS tenant_id, tenants.full_name, units.name AS unit_name,
             MIN(monthly_bills.billing_year * 100 + monthly_bills.billing_month) AS oldest_key,
             SUM(monthly_bills.balance_poisha) AS balance_poisha
      FROM monthly_bills
      INNER JOIN tenancies ON tenancies.id = monthly_bills.tenancy_id
      INNER JOIN tenants ON tenants.id = tenancies.tenant_id
      INNER JOIN units ON units.id = monthly_bills.unit_id
      WHERE monthly_bills.balance_poisha > 0
        AND monthly_bills.status NOT IN ('draft', 'cancelled')
      GROUP BY tenants.id, tenants.full_name, units.name
      ORDER BY balance_poisha DESC, oldest_key ASC
    ''').get();
    return rows
        .map((QueryRow row) {
          final int key = row.read<int>('oldest_key');
          return TenantDueReportRow(
            tenantId: row.read<String>('tenant_id'),
            tenantName: row.read<String>('full_name'),
            unitName: row.read<String>('unit_name'),
            oldestUnpaidMonth: BillingMonth(key ~/ 100, key % 100),
            outstanding: Money.fromPoisha(row.read<int>('balance_poisha')),
          );
        })
        .toList(growable: false);
  });

  Future<Result<PropertyOperationalReport>> propertyIncome({
    required String propertyId,
    required DateRange range,
  }) => _guard(() async {
    final List<Variable<Object>> date = <Variable<Object>>[
      Variable<DateTime>(range.start.toUtc()),
      Variable<DateTime>(range.end.add(const Duration(days: 1)).toUtc()),
    ];
    final int received = await _scalar(
      '''
      SELECT COALESCE(SUM(payment_allocations.amount_poisha), 0) AS value
      FROM payment_allocations
      INNER JOIN payments ON payments.id = payment_allocations.payment_id
      INNER JOIN monthly_bills ON monthly_bills.id = payment_allocations.bill_id
      WHERE monthly_bills.property_id = ? AND payments.status = 'posted'
        AND payments.payment_date >= ? AND payments.payment_date < ?
    ''',
      <Variable<Object>>[Variable<String>(propertyId), ...date],
    );
    final List<QueryRow> billed = await _database
        .customSelect(
          '''
      SELECT bill_line_items.item_type, COALESCE(SUM(bill_line_items.amount_poisha), 0) AS amount
      FROM bill_line_items
      INNER JOIN monthly_bills ON monthly_bills.id = bill_line_items.bill_id
      WHERE monthly_bills.property_id = ?
        AND monthly_bills.issued_at >= ? AND monthly_bills.issued_at < ?
        AND monthly_bills.status <> 'cancelled'
      GROUP BY bill_line_items.item_type
    ''',
          variables: <Variable<Object>>[Variable<String>(propertyId), ...date],
        )
        .get();
    int rentBilled = 0;
    int utilityBilled = 0;
    for (final QueryRow row in billed) {
      final String type = row.read<String>('item_type');
      final int amount = row.read<int>('amount');
      if (type == ChargeType.rent.name) {
        rentBilled += amount;
      } else if (<String>{
        ChargeType.electricity.name,
        ChargeType.gas.name,
        ChargeType.water.name,
        ChargeType.serviceCharge.name,
      }.contains(type)) {
        utilityBilled += amount;
      }
    }
    final int expenses = await _scalar(
      '''
      SELECT COALESCE(SUM(cost_poisha), 0) AS value FROM repairs
      WHERE property_id = ? AND responsibility = 'landlord'
        AND reported_date >= ? AND reported_date < ?
    ''',
      <Variable<Object>>[Variable<String>(propertyId), ...date],
    );
    return PropertyOperationalReport(
      propertyId: propertyId,
      range: range,
      rentBilled: Money.fromPoisha(rentBilled),
      utilityServiceBilled: Money.fromPoisha(utilityBilled),
      received: Money.fromPoisha(received),
      repairExpenses: Money.fromPoisha(expenses),
    );
  });

  Future<Result<List<PaymentMethodTotal>>> paymentMethods(DateRange range) =>
      _guard(() async {
        final List<QueryRow> rows = await _database
            .customSelect(
              '''
      SELECT payment_method, COALESCE(SUM(amount_poisha), 0) AS amount
      FROM payments WHERE status = 'posted' AND payment_date >= ? AND payment_date < ?
      GROUP BY payment_method ORDER BY amount DESC
    ''',
              variables: <Variable<Object>>[
                Variable<DateTime>(range.start.toUtc()),
                Variable<DateTime>(
                  range.end.add(const Duration(days: 1)).toUtc(),
                ),
              ],
            )
            .get();
        return rows
            .map(
              (QueryRow row) => PaymentMethodTotal(
                method: PaymentMethod.values.firstWhere(
                  (PaymentMethod value) =>
                      value.name == row.read<String>('payment_method'),
                  orElse: () => PaymentMethod.other,
                ),
                amount: Money.fromPoisha(row.read<int>('amount')),
              ),
            )
            .toList(growable: false);
      });

  Future<Result<List<GlobalSearchResult>>> search(String value) =>
      _guard(() async {
        final String term = '%${value.trim()}%';
        if (value.trim().isEmpty) return <GlobalSearchResult>[];
        final List<Variable<Object>> values = List<Variable<Object>>.filled(
          5,
          Variable<String>(term),
        );
        final List<QueryRow> rows = await _database.customSelect('''
      SELECT 'tenant' AS kind, id, full_name AS title, phone AS subtitle FROM tenants
        WHERE full_name LIKE ? COLLATE NOCASE OR phone LIKE ? COLLATE NOCASE
      UNION ALL
      SELECT 'property' AS kind, id, name AS title, COALESCE(address_line, '') AS subtitle FROM properties
        WHERE name LIKE ? COLLATE NOCASE
      UNION ALL
      SELECT 'unit' AS kind, units.id, units.name AS title, properties.name AS subtitle FROM units
        INNER JOIN properties ON properties.id = units.property_id WHERE units.name LIKE ? COLLATE NOCASE
      UNION ALL
      SELECT 'receipt' AS kind, id, receipt_number AS title, 'Receipt' AS subtitle FROM receipts
        WHERE receipt_number LIKE ? COLLATE NOCASE
      LIMIT 40
    ''', variables: values).get();
        return rows
            .map(
              (QueryRow row) => GlobalSearchResult(
                kind: row.read<String>('kind'),
                id: row.read<String>('id'),
                title: row.read<String>('title'),
                subtitle: row.read<String>('subtitle'),
              ),
            )
            .toList(growable: false);
      });

  Future<int> _scalar(
    String sql, [
    List<Variable<Object>> variables = const <Variable<Object>>[],
  ]) async {
    final QueryRow row = await _database
        .customSelect(sql, variables: variables)
        .getSingle();
    return row.read<int>('value');
  }

  Future<Result<T>> _guard<T>(Future<T> Function() callback) async {
    try {
      return Result<T>.success(await callback());
    } on Object {
      return Result<T>.failure(
        const DatabaseError('The report could not be calculated.'),
      );
    }
  }

  DashboardPayment _payment(QueryRow row) => DashboardPayment(
    id: row.read<String>('id'),
    tenantName: row.read<String?>('full_name') ?? 'Unknown tenant',
    unitName: row.read<String?>('unit_name'),
    amount: Money.fromPoisha(row.read<int>('amount_poisha')),
    method: PaymentMethod.values.firstWhere(
      (PaymentMethod value) => value.name == row.read<String>('payment_method'),
      orElse: () => PaymentMethod.other,
    ),
    date: row.read<DateTime>('payment_date'),
  );
}

class DashboardData {
  const DashboardData({
    required this.month,
    required this.activeProperties,
    required this.totalUnits,
    required this.occupiedUnits,
    required this.vacantUnits,
    required this.expected,
    required this.collected,
    required this.currentOutstanding,
    required this.overdue,
    required this.recentPayments,
  });
  final BillingMonth month;
  final int activeProperties;
  final int totalUnits;
  final int occupiedUnits;
  final int vacantUnits;
  final Money expected;
  final Money collected;
  final Money currentOutstanding;
  final Money overdue;
  final List<DashboardPayment> recentPayments;
}

class DashboardPayment {
  const DashboardPayment({
    required this.id,
    required this.tenantName,
    required this.unitName,
    required this.amount,
    required this.method,
    required this.date,
  });
  final String id;
  final String tenantName;
  final String? unitName;
  final Money amount;
  final PaymentMethod method;
  final DateTime date;
}

class MonthlyCollectionReport {
  const MonthlyCollectionReport({
    required this.month,
    required this.expected,
    required this.collected,
    required this.outstanding,
  });
  final BillingMonth month;
  final Money expected;
  final Money collected;
  final Money outstanding;
  double get collectionPercent =>
      expected.poisha == 0 ? 0 : collected.poisha / expected.poisha * 100;
}

class TenantDueReportRow {
  const TenantDueReportRow({
    required this.tenantId,
    required this.tenantName,
    required this.unitName,
    required this.oldestUnpaidMonth,
    required this.outstanding,
  });
  final String tenantId;
  final String tenantName;
  final String unitName;
  final BillingMonth oldestUnpaidMonth;
  final Money outstanding;
}

class PropertyOperationalReport {
  const PropertyOperationalReport({
    required this.propertyId,
    required this.range,
    required this.rentBilled,
    required this.utilityServiceBilled,
    required this.received,
    required this.repairExpenses,
  });
  final String propertyId;
  final DateRange range;
  final Money rentBilled;
  final Money utilityServiceBilled;
  final Money received;
  final Money repairExpenses;
  Money get netOperationalCash => received - repairExpenses;
}

class PaymentMethodTotal {
  const PaymentMethodTotal({required this.method, required this.amount});
  final PaymentMethod method;
  final Money amount;
}

class GlobalSearchResult {
  const GlobalSearchResult({
    required this.kind,
    required this.id,
    required this.title,
    required this.subtitle,
  });
  final String kind;
  final String id;
  final String title;
  final String subtitle;
}

/// UTF-8-with-BOM CSV export so Bengali opens correctly in common spreadsheet apps.
abstract final class ReportsCsvExporter {
  static Uint8List tenantDues(List<TenantDueReportRow> rows) {
    final StringBuffer csv = StringBuffer(
      'Tenant,Unit,Oldest unpaid month,Outstanding (poisha)\r\n',
    );
    for (final TenantDueReportRow row in rows) {
      csv.write(
        '${_cell(row.tenantName)},${_cell(row.unitName)},${row.oldestUnpaidMonth.key},${row.outstanding.poisha}\r\n',
      );
    }
    return Uint8List.fromList(<int>[
      0xEF,
      0xBB,
      0xBF,
      ...utf8.encode(csv.toString()),
    ]);
  }

  static String _cell(String value) => '"${value.replaceAll('"', '""')}"';
}

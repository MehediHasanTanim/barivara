import 'package:barivara/core/database/app_database.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:barivara/features/reports/application/dashboard_query_service.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// A deliberately larger-than-target local dataset: 10 properties, 100 units,
/// and 120 monthly bills per unit. The stopwatch measures only the read path,
/// not one-time fixture creation.
void main() {
  test('dashboard aggregation remains responsive with 10 years of bills', () async {
    final AppDatabase database = AppDatabase.forTesting(
      NativeDatabase.memory(),
    );
    addTearDown(database.close);
    await _seedTenYearDataset(database);

    final Stopwatch stopwatch = Stopwatch()..start();
    final DashboardData dashboard = (await DashboardQueryService(
      database,
    ).dashboard(month: BillingMonth(2026, 10)) as Success<DashboardData>).value;
    stopwatch.stop();

    expect(dashboard.activeProperties, 10);
    expect(dashboard.totalUnits, 100);
    expect(dashboard.occupiedUnits, 100);
    expect(dashboard.expected, Money.fromTaka(1500000));
    expect(dashboard.currentOutstanding, Money.fromTaka(1500000));
    expect(dashboard.overdue, Money.fromTaka(175500000));
    expect(
      stopwatch.elapsed,
      lessThan(const Duration(seconds: 5)),
      reason:
          'The indexed dashboard query took ${stopwatch.elapsed.inMilliseconds} ms.',
    );
  });
}

Future<void> _seedTenYearDataset(AppDatabase database) async {
  const int monthlyRentPoisha = 1500000;
  await database.batch((batch) {
    for (int propertyIndex = 0; propertyIndex < 10; propertyIndex++) {
      final String propertyId = 'property-$propertyIndex';
      batch.insert(
        database.properties,
        PropertiesCompanion.insert(
          id: propertyId,
          name: 'Property $propertyIndex',
        ),
      );
      for (int unitIndex = 0; unitIndex < 10; unitIndex++) {
        final String suffix = '$propertyIndex-$unitIndex';
        final String unitId = 'unit-$suffix';
        final String tenantId = 'tenant-$suffix';
        final String tenancyId = 'tenancy-$suffix';
        batch.insert(
          database.units,
          UnitsCompanion.insert(
            id: unitId,
            propertyId: propertyId,
            name: 'U-$unitIndex',
          ),
        );
        batch.insert(
          database.tenants,
          TenantsCompanion.insert(
            id: tenantId,
            fullName: 'Tenant $suffix',
            phone:
                '0171200${propertyIndex.toString().padLeft(2, '0')}${unitIndex.toString().padLeft(2, '0')}',
          ),
        );
        batch.insert(
          database.tenancies,
          TenanciesCompanion.insert(
            id: tenancyId,
            tenantId: tenantId,
            unitId: unitId,
            moveInDate: DateTime.utc(2017, 1, 1),
          ),
        );
        for (int year = 2017; year <= 2026; year++) {
          for (int month = 1; month <= 12; month++) {
            batch.insert(
              database.monthlyBills,
              MonthlyBillsCompanion.insert(
                id: 'bill-$suffix-$year-$month',
                tenancyId: tenancyId,
                propertyId: propertyId,
                unitId: unitId,
                billingYear: year,
                billingMonth: month,
                status: const Value<String>('finalized'),
                totalPoisha: const Value<int>(monthlyRentPoisha),
                balancePoisha: const Value<int>(monthlyRentPoisha),
              ),
            );
          }
        }
      }
    }
  });
}

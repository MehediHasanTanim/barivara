import 'package:barivara/core/database/app_database.dart' as db;
import 'package:barivara/core/database/tables.dart';
import 'package:barivara/core/domain/models.dart' as domain;
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:drift/drift.dart';

/// Shared error boundary and transaction utility for Drift repositories.
abstract class DriftRepository {
  /// Creates a repository backed by [database].
  const DriftRepository(this.database);

  /// Local source of truth.
  final db.AppDatabase database;

  /// Converts low-level persistence failures to safe application failures.
  Future<Result<T>> guard<T>(Future<T> Function() operation) async {
    try {
      return Result<T>.success(await operation());
    } on Object {
      return Result<T>.failure(
        const DatabaseError(
          'The local record could not be saved. Please try again.',
        ),
      );
    }
  }

  /// Executes a multi-record write atomically.
  Future<Result<T>> inTransaction<T>(Future<T> Function() operation) {
    return guard<T>(() => database.transaction(operation));
  }
}

/// Drift implementation of [PropertyRepository].
class DriftPropertyRepository extends DriftRepository
    implements PropertyRepository {
  /// Creates a property repository.
  const DriftPropertyRepository(super.database);

  @override
  Future<Result<void>> archive(EntityId id) async {
    try {
      final int activeUnits =
          await (database.selectOnly(database.units)
                ..addColumns(<Expression<Object>>[database.units.id.count()])
                ..where(
                  database.units.propertyId.equals(id.value) &
                      database.units.isArchived.equals(false),
                ))
              .map(
                (TypedResult row) => row.read(database.units.id.count()) ?? 0,
              )
              .getSingle();
      if (activeUnits > 0) {
        return Result<void>.failure(
          const ConflictError(
            'Archive or move the active units before archiving this property.',
          ),
        );
      }
      await (database.update(
        database.properties,
      )..where((Properties table) => table.id.equals(id.value))).write(
        db.PropertiesCompanion(
          isArchived: const Value<bool>(true),
          status: const Value<String>('archived'),
          updatedAt: Value<DateTime>(DateTime.now().toUtc()),
        ),
      );
      return Result<void>.success(null);
    } on Object {
      return Result<void>.failure(
        const DatabaseError('The property could not be archived.'),
      );
    }
  }

  @override
  Future<Result<domain.Property?>> findById(EntityId id) =>
      guard<domain.Property?>(() async {
        final db.Property? row =
            await (database.select(database.properties)
                  ..where((Properties table) => table.id.equals(id.value)))
                .getSingleOrNull();
        return row == null ? null : _map(row);
      });

  @override
  Future<Result<List<domain.Property>>> list() =>
      guard<List<domain.Property>>(() async {
        final List<db.Property> rows =
            await (database.select(database.properties)
                  ..where((Properties table) => table.isArchived.equals(false))
                  ..orderBy(<OrderingTerm Function(Properties)>[
                    (Properties table) => OrderingTerm.asc(table.name),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  @override
  Future<Result<List<domain.Property>>> listArchived() =>
      guard<List<domain.Property>>(() async {
        final List<db.Property> rows =
            await (database.select(database.properties)
                  ..where((Properties table) => table.isArchived.equals(true))
                  ..orderBy(<OrderingTerm Function(Properties)>[
                    (Properties table) => OrderingTerm.asc(table.name),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  @override
  Future<Result<List<domain.PropertySummary>>> listSummaries() =>
      guard<List<domain.PropertySummary>>(() async {
        final List<db.Property> properties =
            await (database.select(database.properties)
                  ..where((Properties table) => table.isArchived.equals(false))
                  ..orderBy(<OrderingTerm Function(Properties)>[
                    (Properties table) => OrderingTerm.asc(table.name),
                  ]))
                .get();
        final DateTime now = DateTime.now();
        final List<domain.PropertySummary> summaries =
            <domain.PropertySummary>[];
        for (final db.Property property in properties) {
          final List<domain.UnitSummary> units = await _unitSummaries(
            EntityId(property.id),
          );
          final List<db.MonthlyBill> bills =
              await (database.select(database.monthlyBills)..where(
                    (MonthlyBills table) =>
                        table.propertyId.equals(property.id) &
                        table.billingYear.equals(now.year) &
                        table.billingMonth.equals(now.month),
                  ))
                  .get();
          final Money due = bills.fold<Money>(
            Money.zero,
            (Money total, db.MonthlyBill bill) =>
                total + Money.fromPoisha(bill.balancePoisha),
          );
          summaries.add(
            domain.PropertySummary(
              property: _map(property),
              unitCount: units.length,
              occupiedCount: units
                  .where(
                    (domain.UnitSummary unit) =>
                        unit.availability == domain.UnitAvailability.occupied,
                  )
                  .length,
              vacantCount: units
                  .where(
                    (domain.UnitSummary unit) =>
                        unit.availability == domain.UnitAvailability.vacant,
                  )
                  .length,
              currentMonthDue: due,
            ),
          );
        }
        return summaries;
      });

  @override
  Future<Result<bool>> hasDuplicateName(String name, {EntityId? excludingId}) =>
      guard<bool>(() async {
        final List<db.Property> rows =
            await (database.select(database.properties)..where(
                  (Properties table) =>
                      table.name.equals(name.trim()) &
                      table.isArchived.equals(false),
                ))
                .get();
        return rows.any(
          (db.Property property) => property.id != excludingId?.value,
        );
      });

  @override
  Future<Result<void>> save(domain.Property property) => guard<void>(() async {
    await database
        .into(database.properties)
        .insertOnConflictUpdate(
          db.PropertiesCompanion.insert(
            id: property.id.value,
            name: property.name,
            propertyType: Value<String>(property.type.name),
            nickname: Value<String?>(property.nickname),
            addressLine: Value<String?>(property.addressLine),
            area: Value<String?>(property.area),
            cityDistrict: Value<String?>(property.cityDistrict),
            notes: Value<String?>(property.notes),
            isArchived: Value<bool>(property.isArchived),
            createdAt: Value<DateTime>(property.createdAt.toUtc()),
            updatedAt: Value<DateTime>(property.updatedAt.toUtc()),
          ),
        );
  });

  domain.Property _map(db.Property row) => domain.Property(
    id: EntityId(row.id),
    name: row.name,
    type: _propertyType(row.propertyType),
    nickname: row.nickname,
    addressLine: row.addressLine,
    area: row.area,
    cityDistrict: row.cityDistrict,
    notes: row.notes,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isArchived: row.isArchived,
  );

  domain.PropertyType _propertyType(String value) =>
      domain.PropertyType.values.firstWhere(
        (domain.PropertyType type) => type.name == value,
        orElse: () => domain.PropertyType.residential,
      );

  Future<List<domain.UnitSummary>> _unitSummaries(EntityId propertyId) =>
      DriftUnitRepository(database).summaries(propertyId);
}

/// Drift implementation of [UnitRepository].
class DriftUnitRepository extends DriftRepository implements UnitRepository {
  /// Creates a unit repository.
  const DriftUnitRepository(super.database);

  @override
  Future<Result<void>> archive(EntityId id) async {
    try {
      final bool hasActiveTenancy =
          await (database.select(database.tenancies)..where(
                (Tenancies table) =>
                    table.unitId.equals(id.value) &
                    table.status.equals('active'),
              ))
              .getSingleOrNull()
              .then((db.Tenancy? tenancy) => tenancy != null);
      if (hasActiveTenancy) {
        return Result<void>.failure(
          const ConflictError(
            'Move out the active tenant before archiving this unit.',
          ),
        );
      }
      await (database.update(
        database.units,
      )..where((Units table) => table.id.equals(id.value))).write(
        db.UnitsCompanion(
          isArchived: const Value<bool>(true),
          updatedAt: Value<DateTime>(DateTime.now().toUtc()),
        ),
      );
      return Result<void>.success(null);
    } on Object {
      return Result<void>.failure(
        const DatabaseError('The unit could not be archived.'),
      );
    }
  }

  @override
  Future<Result<domain.RentalUnit?>> findById(EntityId id) =>
      guard<domain.RentalUnit?>(() async {
        final db.Unit? row = await (database.select(
          database.units,
        )..where((Units table) => table.id.equals(id.value))).getSingleOrNull();
        return row == null ? null : _map(row);
      });

  @override
  Future<Result<List<domain.RentalUnit>>> listByProperty(EntityId propertyId) =>
      guard<List<domain.RentalUnit>>(() async {
        final List<db.Unit> rows =
            await (database.select(database.units)
                  ..where(
                    (Units table) =>
                        table.propertyId.equals(propertyId.value) &
                        table.isArchived.equals(false),
                  )
                  ..orderBy(<OrderingTerm Function(Units)>[
                    (Units table) => OrderingTerm.asc(table.name),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  @override
  Future<Result<List<domain.UnitSummary>>> listSummariesByProperty(
    EntityId propertyId, {
    domain.UnitFilter filter = domain.UnitFilter.all,
  }) => guard<List<domain.UnitSummary>>(() async {
    final List<domain.UnitSummary> values = await summaries(propertyId);
    return switch (filter) {
      domain.UnitFilter.all =>
        values
            .where(
              (domain.UnitSummary unit) =>
                  unit.availability != domain.UnitAvailability.archived,
            )
            .toList(growable: false),
      domain.UnitFilter.occupied =>
        values
            .where(
              (domain.UnitSummary unit) =>
                  unit.availability == domain.UnitAvailability.occupied,
            )
            .toList(growable: false),
      domain.UnitFilter.vacant =>
        values
            .where(
              (domain.UnitSummary unit) =>
                  unit.availability == domain.UnitAvailability.vacant,
            )
            .toList(growable: false),
      domain.UnitFilter.archived =>
        values
            .where(
              (domain.UnitSummary unit) =>
                  unit.availability == domain.UnitAvailability.archived,
            )
            .toList(growable: false),
    };
  });

  @override
  Future<Result<void>> save(domain.RentalUnit unit) => guard<void>(() async {
    await database
        .into(database.units)
        .insertOnConflictUpdate(
          db.UnitsCompanion.insert(
            id: unit.id.value,
            propertyId: unit.propertyId.value,
            name: unit.name,
            floorName: Value<String?>(unit.floorName),
            unitType: Value<String>(unit.unitType),
            bedrooms: Value<int?>(unit.bedrooms),
            defaultRentPoisha: Value<int>(unit.defaultRent.poisha),
            defaultServiceChargePoisha: Value<int>(
              unit.defaultServiceCharge.poisha,
            ),
            defaultGasChargePoisha: Value<int>(unit.defaultGasCharge.poisha),
            defaultWaterChargePoisha: Value<int>(
              unit.defaultWaterCharge.poisha,
            ),
            occupancyStatus: Value<String>(unit.manualAvailability.name),
            notes: Value<String?>(unit.notes),
            isArchived: Value<bool>(unit.isArchived),
            createdAt: Value<DateTime>(unit.createdAt.toUtc()),
            updatedAt: Value<DateTime>(unit.updatedAt.toUtc()),
          ),
        );
  });

  domain.RentalUnit _map(db.Unit row) => domain.RentalUnit(
    id: EntityId(row.id),
    propertyId: EntityId(row.propertyId),
    name: row.name,
    floorName: row.floorName,
    unitType: row.unitType,
    bedrooms: row.bedrooms,
    defaultRent: Money.fromPoisha(row.defaultRentPoisha),
    defaultServiceCharge: Money.fromPoisha(row.defaultServiceChargePoisha),
    defaultGasCharge: Money.fromPoisha(row.defaultGasChargePoisha),
    defaultWaterCharge: Money.fromPoisha(row.defaultWaterChargePoisha),
    manualAvailability: _manualAvailability(row.occupancyStatus),
    notes: row.notes,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isArchived: row.isArchived,
  );

  /// Computes operating availability using active tenancy instead of stale UI
  /// state. Reserved is the only manual non-occupancy state.
  Future<List<domain.UnitSummary>> summaries(EntityId propertyId) async {
    final query = database.select(database.units).join([
      leftOuterJoin(
        database.tenancies,
        database.tenancies.unitId.equalsExp(database.units.id) &
            database.tenancies.status.equals('active'),
      ),
      leftOuterJoin(
        database.tenants,
        database.tenants.id.equalsExp(database.tenancies.tenantId),
      ),
    ]);
    query.where(database.units.propertyId.equals(propertyId.value));
    final List<TypedResult> rows = await query.get();
    return rows
        .map((TypedResult row) {
          final db.Unit unit = row.readTable(database.units);
          final db.Tenant? tenant = row.readTableOrNull(database.tenants);
          final domain.UnitAvailability availability = _availability(
            unit,
            tenant != null,
          );
          return domain.UnitSummary(
            unit: _map(unit),
            availability: availability,
            activeTenantName: tenant?.fullName,
          );
        })
        .toList(growable: false);
  }

  domain.UnitAvailability _availability(db.Unit row, bool hasActiveTenancy) {
    if (row.isArchived) {
      return domain.UnitAvailability.archived;
    }
    if (hasActiveTenancy) {
      return domain.UnitAvailability.occupied;
    }
    return _manualAvailability(row.occupancyStatus) ==
            domain.UnitAvailability.reserved
        ? domain.UnitAvailability.reserved
        : domain.UnitAvailability.vacant;
  }

  domain.UnitAvailability _manualAvailability(String value) =>
      domain.UnitAvailability.values.firstWhere(
        (domain.UnitAvailability availability) => availability.name == value,
        orElse: () => domain.UnitAvailability.vacant,
      );
}

/// Drift implementation of [TenantRepository].
class DriftTenantRepository extends DriftRepository
    implements TenantRepository {
  /// Creates a tenant repository.
  const DriftTenantRepository(super.database);

  @override
  Future<Result<domain.Tenant?>> findById(EntityId id) => guard<domain.Tenant?>(
    () async {
      final db.Tenant? row = await (database.select(
        database.tenants,
      )..where((Tenants table) => table.id.equals(id.value))).getSingleOrNull();
      return row == null ? null : _map(row);
    },
  );

  @override
  Future<Result<void>> save(domain.Tenant tenant) => guard<void>(() async {
    await database
        .into(database.tenants)
        .insertOnConflictUpdate(
          db.TenantsCompanion.insert(
            id: tenant.id.value,
            fullName: tenant.fullName,
            phone: tenant.phone.value,
            createdAt: Value<DateTime>(tenant.createdAt.toUtc()),
            updatedAt: Value<DateTime>(tenant.updatedAt.toUtc()),
          ),
        );
  });

  @override
  Future<Result<List<domain.Tenant>>> search(String query) =>
      guard<List<domain.Tenant>>(() async {
        final String term = '%${query.trim()}%';
        final List<db.Tenant> rows =
            await (database.select(database.tenants)
                  ..where(
                    (Tenants table) =>
                        table.fullName.like(term) | table.phone.like(term),
                  )
                  ..orderBy(<OrderingTerm Function(Tenants)>[
                    (Tenants table) => OrderingTerm.asc(table.fullName),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  domain.Tenant _map(db.Tenant row) => domain.Tenant(
    id: EntityId(row.id),
    fullName: row.fullName,
    phone: PhoneNumber(row.phone),
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  );
}

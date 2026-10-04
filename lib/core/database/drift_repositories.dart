import 'dart:convert';

import 'package:barivara/core/database/app_database.dart' as db;
import 'package:barivara/core/database/tables.dart';
import 'package:barivara/core/domain/models.dart' as domain;
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

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
            alternativePhone: Value<String?>(tenant.alternativePhone?.value),
            nidNumber: Value<String?>(tenant.nidNumber),
            permanentAddress: Value<String?>(tenant.permanentAddress),
            emergencyContactName: Value<String?>(tenant.emergencyContactName),
            emergencyContactPhone: Value<String?>(
              tenant.emergencyContactPhone?.value,
            ),
            notes: Value<String?>(tenant.notes),
            photoPath: Value<String?>(tenant.photoPath),
            status: Value<String>(tenant.isArchived ? 'archived' : 'active'),
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
                        (table.fullName.like(term) | table.phone.like(term)) &
                        table.status.equals('active'),
                  )
                  ..orderBy(<OrderingTerm Function(Tenants)>[
                    (Tenants table) => OrderingTerm.asc(table.fullName),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  @override
  Future<Result<void>> archive(EntityId id) => guard<void>(() async {
    await (database.update(
      database.tenants,
    )..where((Tenants table) => table.id.equals(id.value))).write(
      db.TenantsCompanion(
        status: const Value<String>('archived'),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  });

  @override
  Future<Result<List<domain.TenantSummary>>> searchSummaries(String query) =>
      guard<List<domain.TenantSummary>>(() async {
        final String term = '%${query.trim()}%';
        final join = database.select(database.tenants).join([
          leftOuterJoin(
            database.tenancies,
            database.tenancies.tenantId.equalsExp(database.tenants.id) &
                database.tenancies.status.equals('active'),
          ),
          leftOuterJoin(
            database.units,
            database.units.id.equalsExp(database.tenancies.unitId),
          ),
          leftOuterJoin(
            database.properties,
            database.properties.id.equalsExp(database.units.propertyId),
          ),
        ]);
        join.where(
          database.tenants.status.equals('active') &
              (database.tenants.fullName.like(term) |
                  database.tenants.phone.like(term) |
                  database.units.name.like(term) |
                  database.properties.name.like(term)),
        );
        final List<TypedResult> rows = await join.get();
        return rows
            .map((TypedResult row) {
              final db.Tenant tenant = row.readTable(database.tenants);
              final db.Tenancy? tenancy = row.readTableOrNull(
                database.tenancies,
              );
              final db.Unit? unit = row.readTableOrNull(database.units);
              final db.Property? property = row.readTableOrNull(
                database.properties,
              );
              return domain.TenantSummary(
                tenant: _map(tenant),
                currentTenancy: tenancy == null ? null : _tenancy(tenancy),
                unitName: unit?.name,
                propertyName: property?.name,
              );
            })
            .toList(growable: false);
      });

  domain.Tenant _map(db.Tenant row) => domain.Tenant(
    id: EntityId(row.id),
    fullName: row.fullName,
    phone: PhoneNumber(row.phone),
    alternativePhone: _phone(row.alternativePhone),
    nidNumber: row.nidNumber,
    permanentAddress: row.permanentAddress,
    emergencyContactName: row.emergencyContactName,
    emergencyContactPhone: _phone(row.emergencyContactPhone),
    notes: row.notes,
    photoPath: row.photoPath,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isArchived: row.status == 'archived',
  );

  PhoneNumber? _phone(String? value) =>
      value == null || value.isEmpty ? null : PhoneNumber(value);

  domain.Tenancy _tenancy(db.Tenancy row) => _mapTenancy(row);
}

/// Drift implementation of tenancy history and move-out state transitions.
class DriftTenancyRepository extends DriftRepository
    implements TenancyRepository {
  /// Creates a tenancy repository.
  const DriftTenancyRepository(super.database);

  @override
  Future<Result<domain.Tenancy?>> findActiveByUnit(EntityId unitId) =>
      _findActive((Tenancies table) => table.unitId.equals(unitId.value));

  @override
  Future<Result<domain.Tenancy?>> findActiveByTenant(EntityId tenantId) =>
      _findActive((Tenancies table) => table.tenantId.equals(tenantId.value));

  Future<Result<domain.Tenancy?>> _findActive(
    Expression<bool> Function(Tenancies table) condition,
  ) => guard<domain.Tenancy?>(() async {
    final db.Tenancy? row =
        await (database.select(database.tenancies)..where(
              (Tenancies table) =>
                  condition(table) & table.status.equals('active'),
            ))
            .getSingleOrNull();
    return row == null ? null : _map(row);
  });

  @override
  Future<Result<List<domain.Tenancy>>> listByTenant(EntityId tenantId) =>
      guard<List<domain.Tenancy>>(() async {
        final List<db.Tenancy> rows =
            await (database.select(database.tenancies)
                  ..where(
                    (Tenancies table) => table.tenantId.equals(tenantId.value),
                  )
                  ..orderBy(<OrderingTerm Function(Tenancies)>[
                    (Tenancies table) => OrderingTerm.desc(table.moveInDate),
                  ]))
                .get();
        return rows.map(_map).toList(growable: false);
      });

  @override
  Future<Result<List<domain.Tenancy>>> listByUnit(
    EntityId unitId, {
    DateRange? range,
  }) => guard<List<domain.Tenancy>>(() async {
    final List<db.Tenancy> rows =
        await (database.select(database.tenancies)
              ..where((Tenancies table) {
                Expression<bool> where = table.unitId.equals(unitId.value);
                if (range != null) {
                  where =
                      where &
                      table.moveInDate.isBiggerOrEqualValue(range.start);
                  where =
                      where & table.moveInDate.isSmallerOrEqualValue(range.end);
                }
                return where;
              })
              ..orderBy(<OrderingTerm Function(Tenancies)>[
                (Tenancies table) => OrderingTerm.desc(table.moveInDate),
              ]))
            .get();
    return rows.map(_map).toList(growable: false);
  });

  @override
  Future<Result<void>> moveOut(EntityId tenancyId, DateTime effectiveDate) =>
      inTransaction<void>(() async {
        await (database.update(
          database.tenancies,
        )..where((Tenancies table) => table.id.equals(tenancyId.value))).write(
          db.TenanciesCompanion(
            status: const Value<String>('movedOut'),
            actualMoveOutDate: Value<DateTime>(effectiveDate.toUtc()),
            updatedAt: Value<DateTime>(DateTime.now().toUtc()),
          ),
        );
        await (database.update(database.recurringChargeRules)..where(
              (RecurringChargeRules table) =>
                  table.tenancyId.equals(tenancyId.value) &
                  table.isActive.equals(true),
            ))
            .write(
              db.RecurringChargeRulesCompanion(
                isActive: const Value<bool>(false),
                effectiveTo: Value<DateTime>(effectiveDate.toUtc()),
                updatedAt: Value<DateTime>(DateTime.now().toUtc()),
              ),
            );
      });

  @override
  Future<Result<void>> save(domain.Tenancy tenancy) => guard<void>(() async {
    await database
        .into(database.tenancies)
        .insertOnConflictUpdate(
          db.TenanciesCompanion.insert(
            id: tenancy.id.value,
            tenantId: tenancy.tenantId.value,
            unitId: tenancy.unitId.value,
            moveInDate: tenancy.moveInDate.toUtc(),
            expectedMoveOutDate: Value<DateTime?>(
              tenancy.expectedMoveOutDate?.toUtc(),
            ),
            actualMoveOutDate: Value<DateTime?>(
              tenancy.actualMoveOutDate?.toUtc(),
            ),
            agreedRentPoisha: Value<int>(tenancy.agreedRent.poisha),
            billingDay: Value<int>(tenancy.billingDay),
            securityDepositTargetPoisha: Value<int>(
              tenancy.securityDepositTarget.poisha,
            ),
            advanceRentPoisha: Value<int>(tenancy.advanceRent.poisha),
            agreementNotes: Value<String?>(tenancy.agreementNotes),
            status: Value<String>(tenancy.status.name),
            createdAt: Value<DateTime>(DateTime.now().toUtc()),
            updatedAt: Value<DateTime>(DateTime.now().toUtc()),
          ),
        );
  });

  domain.Tenancy _map(db.Tenancy row) => _mapTenancy(row);
}

domain.Tenancy _mapTenancy(db.Tenancy row) => domain.Tenancy(
  id: EntityId(row.id),
  tenantId: EntityId(row.tenantId),
  unitId: EntityId(row.unitId),
  moveInDate: row.moveInDate,
  expectedMoveOutDate: row.expectedMoveOutDate,
  actualMoveOutDate: row.actualMoveOutDate,
  agreedRent: Money.fromPoisha(row.agreedRentPoisha),
  billingDay: row.billingDay,
  securityDepositTarget: Money.fromPoisha(row.securityDepositTargetPoisha),
  advanceRent: Money.fromPoisha(row.advanceRentPoisha),
  agreementNotes: row.agreementNotes,
  status: row.status == 'active'
      ? domain.TenancyStatus.active
      : domain.TenancyStatus.movedOut,
);

/// Drift storage for effective-dated recurring charges and meter setup.
class DriftChargeConfigurationRepository extends DriftRepository
    implements ChargeConfigurationRepository {
  /// Creates charge configuration persistence.
  const DriftChargeConfigurationRepository(super.database);

  @override
  Future<Result<List<domain.RecurringChargeRule>>> listRules(
    EntityId tenancyId,
  ) => guard<List<domain.RecurringChargeRule>>(() async {
    final List<db.RecurringChargeRule> rows =
        await (database.select(database.recurringChargeRules)
              ..where(
                (RecurringChargeRules table) =>
                    table.tenancyId.equals(tenancyId.value),
              )
              ..orderBy(<OrderingTerm Function(RecurringChargeRules)>[
                (RecurringChargeRules table) =>
                    OrderingTerm.desc(table.effectiveFrom),
              ]))
            .get();
    return rows.map(_rule).toList(growable: false);
  });

  @override
  Future<Result<domain.RecurringChargeRule?>> ruleForMonth(
    EntityId tenancyId,
    ChargeType chargeType,
    BillingMonth month,
  ) => guard<domain.RecurringChargeRule?>(() async {
    final DateTime start = DateTime.utc(month.year, month.month);
    final DateTime end = DateTime.utc(month.year, month.month + 1);
    final db.RecurringChargeRule? row =
        await (database.select(database.recurringChargeRules)
              ..where(
                (RecurringChargeRules table) =>
                    table.tenancyId.equals(tenancyId.value) &
                    table.chargeType.equals(chargeType.name) &
                    table.isActive.equals(true) &
                    table.effectiveFrom.isSmallerThanValue(end) &
                    (table.effectiveTo.isNull() |
                        table.effectiveTo.isBiggerOrEqualValue(start)),
              )
              ..orderBy(<OrderingTerm Function(RecurringChargeRules)>[
                (RecurringChargeRules table) =>
                    OrderingTerm.desc(table.effectiveFrom),
              ]))
            .getSingleOrNull();
    return row == null ? null : _rule(row);
  });

  @override
  Future<Result<void>> saveRule(domain.RecurringChargeRule rule) =>
      guard<void>(() async {
        await database
            .into(database.recurringChargeRules)
            .insertOnConflictUpdate(
              db.RecurringChargeRulesCompanion.insert(
                id: rule.id.value,
                tenancyId: rule.tenancyId.value,
                chargeType: rule.chargeType.name,
                calculationMethod: rule.calculationMethod.name,
                fixedAmountPoisha: Value<int>(rule.fixedAmount.poisha),
                ratePoisha: Value<int?>(rule.ratePerUnit?.poisha),
                effectiveFrom: DateTime.utc(
                  rule.effectiveFrom.year,
                  rule.effectiveFrom.month,
                ),
                effectiveTo: Value<DateTime?>(
                  rule.effectiveTo == null
                      ? null
                      : DateTime.utc(
                          rule.effectiveTo!.year,
                          rule.effectiveTo!.month,
                        ),
                ),
                isActive: Value<bool>(rule.isActive),
                createdAt: Value<DateTime>(DateTime.now().toUtc()),
                updatedAt: Value<DateTime>(DateTime.now().toUtc()),
              ),
            );
      });

  @override
  Future<Result<domain.UtilityMeterConfiguration?>> meterForUnit(
    EntityId unitId,
  ) => guard<domain.UtilityMeterConfiguration?>(() async {
    final db.UtilityMeterConfig? row =
        await (database.select(database.utilityMeterConfigs)..where(
              (UtilityMeterConfigs table) =>
                  table.unitId.equals(unitId.value) &
                  table.isActive.equals(true),
            ))
            .getSingleOrNull();
    return row == null ? null : _meter(row);
  });

  @override
  Future<Result<void>> saveMeter(
    domain.UtilityMeterConfiguration configuration,
  ) => guard<void>(() async {
    await database
        .into(database.utilityMeterConfigs)
        .insertOnConflictUpdate(
          db.UtilityMeterConfigsCompanion.insert(
            id: configuration.id.value,
            unitId: configuration.unitId.value,
            meterNumber: Value<String?>(configuration.meterNumber),
            billingMode: configuration.billingMode,
            ratePerUnitPoisha: Value<int>(configuration.ratePerUnit.poisha),
            additionalChargePoisha: Value<int>(configuration.fixedFee.poisha),
            initialReading: Value<int>(configuration.initialReading.value),
            isActive: Value<bool>(configuration.isActive),
            createdAt: Value<DateTime>(DateTime.now().toUtc()),
            updatedAt: Value<DateTime>(DateTime.now().toUtc()),
          ),
        );
  });

  domain.RecurringChargeRule _rule(db.RecurringChargeRule row) =>
      domain.RecurringChargeRule(
        id: EntityId(row.id),
        tenancyId: EntityId(row.tenancyId),
        chargeType: _chargeType(row.chargeType),
        calculationMethod: _method(row.calculationMethod),
        fixedAmount: Money.fromPoisha(row.fixedAmountPoisha),
        ratePerUnit: row.ratePoisha == null
            ? null
            : Money.fromPoisha(row.ratePoisha!),
        effectiveFrom: BillingMonth.fromDate(row.effectiveFrom),
        effectiveTo: row.effectiveTo == null
            ? null
            : BillingMonth.fromDate(row.effectiveTo!),
        isActive: row.isActive,
      );

  domain.UtilityMeterConfiguration _meter(db.UtilityMeterConfig row) =>
      domain.UtilityMeterConfiguration(
        id: EntityId(row.id),
        unitId: EntityId(row.unitId),
        meterNumber: row.meterNumber,
        billingMode: row.billingMode,
        ratePerUnit: Money.fromPoisha(row.ratePerUnitPoisha),
        fixedFee: Money.fromPoisha(row.additionalChargePoisha),
        initialReading: MeterReading(row.initialReading),
        isActive: row.isActive,
      );

  ChargeType _chargeType(String value) => ChargeType.values.firstWhere(
    (ChargeType type) => type.name == value,
    orElse: () => ChargeType.other,
  );

  domain.ChargeCalculationMethod _method(String value) =>
      domain.ChargeCalculationMethod.values.firstWhere(
        (domain.ChargeCalculationMethod method) => method.name == value,
        orElse: () => domain.ChargeCalculationMethod.fixed,
      );
}

/// Drift persistence for immutable bill headers and line-item snapshots.
class DriftBillingRepository extends DriftRepository
    implements BillingRepository {
  /// Creates billing persistence operations.
  const DriftBillingRepository(super.database);

  @override
  Future<Result<domain.MonthlyBill?>> findForPeriod(
    EntityId tenancyId,
    BillingMonth period,
  ) => guard<domain.MonthlyBill?>(() async {
    final db.MonthlyBill? row =
        await (database.select(database.monthlyBills)..where(
              (MonthlyBills table) =>
                  table.tenancyId.equals(tenancyId.value) &
                  table.billingYear.equals(period.year) &
                  table.billingMonth.equals(period.month),
            ))
            .getSingleOrNull();
    return row == null ? null : _bill(row);
  });

  @override
  Future<Result<domain.BillDraft?>> findDraft(EntityId billId) =>
      guard<domain.BillDraft?>(() async {
        final db.MonthlyBill? header =
            await (database.select(
                  database.monthlyBills,
                )..where((MonthlyBills table) => table.id.equals(billId.value)))
                .getSingleOrNull();
        if (header == null) {
          return null;
        }
        final List<db.BillLineItem> rows =
            await (database.select(database.billLineItems)
                  ..where(
                    (BillLineItems table) => table.billId.equals(billId.value),
                  )
                  ..orderBy(<OrderingTerm Function(BillLineItems)>[
                    (BillLineItems table) => OrderingTerm.asc(table.sortOrder),
                  ]))
                .get();
        return domain.BillDraft(
          bill: _bill(header),
          items: rows.map(_item).toList(growable: false),
        );
      });

  @override
  Future<Result<List<domain.MonthlyBill>>> listForPeriod(BillingMonth period) =>
      guard<List<domain.MonthlyBill>>(() async {
        final List<db.MonthlyBill> rows =
            await (database.select(database.monthlyBills)
                  ..where(
                    (MonthlyBills table) =>
                        table.billingYear.equals(period.year) &
                        table.billingMonth.equals(period.month),
                  )
                  ..orderBy(<OrderingTerm Function(MonthlyBills)>[
                    (MonthlyBills table) => OrderingTerm.asc(table.createdAt),
                  ]))
                .get();
        return rows.map(_bill).toList(growable: false);
      });

  @override
  Future<Result<List<domain.MonthlyBill>>> listOutstandingByTenancy(
    EntityId tenancyId,
  ) => guard<List<domain.MonthlyBill>>(() async {
    final List<db.MonthlyBill> rows =
        await (database.select(database.monthlyBills)
              ..where(
                (MonthlyBills table) =>
                    table.tenancyId.equals(tenancyId.value) &
                    table.balancePoisha.isBiggerThanValue(0) &
                    table.status.isNotValue(domain.BillStatus.draft.name) &
                    table.status.isNotValue(domain.BillStatus.cancelled.name),
              )
              ..orderBy(<OrderingTerm Function(MonthlyBills)>[
                (MonthlyBills table) => OrderingTerm.asc(table.billingYear),
                (MonthlyBills table) => OrderingTerm.asc(table.billingMonth),
              ]))
            .get();
    return rows.map(_bill).toList(growable: false);
  });

  @override
  Future<Result<MeterReading?>> lastElectricityReading(EntityId unitId) =>
      guard<MeterReading?>(() async {
        final QueryRow? row = await database
            .customSelect(
              '''
          SELECT bill_line_items.metadata_json
          FROM bill_line_items
          INNER JOIN monthly_bills ON monthly_bills.id = bill_line_items.bill_id
          WHERE monthly_bills.unit_id = ?
            AND bill_line_items.item_type = ?
            AND monthly_bills.status <> ?
          ORDER BY monthly_bills.billing_year DESC, monthly_bills.billing_month DESC
          LIMIT 1
          ''',
              variables: <Variable<Object>>[
                Variable<String>(unitId.value),
                Variable<String>(ChargeType.electricity.name),
                Variable<String>(domain.BillStatus.cancelled.name),
              ],
            )
            .getSingleOrNull();
        final String? metadataJson = row?.read<String>('metadata_json');
        if (metadataJson == null) {
          return null;
        }
        final dynamic current = (jsonDecode(
          metadataJson,
        ) as Map<String, dynamic>)['currentReading'];
        return current is int ? MeterReading(current) : null;
      });

  @override
  Future<Result<Money>> openingDue(EntityId tenancyId, BillingMonth period) =>
      guard<Money>(() async {
        final List<db.MonthlyBill> rows =
            await (database.select(database.monthlyBills)
                  ..where(
                    (MonthlyBills table) =>
                        table.tenancyId.equals(tenancyId.value) &
                        (table.billingYear.isSmallerThanValue(period.year) |
                            (table.billingYear.equals(period.year) &
                                table.billingMonth.isSmallerThanValue(
                                  period.month,
                                ))) &
                        table.status.isNotValue(domain.BillStatus.draft.name) &
                        table.status.isNotValue(
                          domain.BillStatus.cancelled.name,
                        ),
                  )
                  ..orderBy(<OrderingTerm Function(MonthlyBills)>[
                    (MonthlyBills table) =>
                        OrderingTerm.desc(table.billingYear),
                    (MonthlyBills table) =>
                        OrderingTerm.desc(table.billingMonth),
                  ])
                  ..limit(1))
                .get();
        if (rows.isEmpty || rows.single.balancePoisha <= 0) {
          return Money.zero;
        }
        // The most recent finalized balance is an already-carried opening
        // balance. Using it once prevents duplicate old principal.
        return Money.fromPoisha(rows.single.balancePoisha);
      });

  @override
  Future<Result<domain.MonthlyBill>> finalize(EntityId billId) =>
      guard<domain.MonthlyBill>(() async {
        final db.MonthlyBill? existing =
            await (database.select(
                  database.monthlyBills,
                )..where((MonthlyBills table) => table.id.equals(billId.value)))
                .getSingleOrNull();
        if (existing == null) {
          throw StateError('Bill not found.');
        }
        if (existing.status != domain.BillStatus.draft.name) {
          return _bill(existing);
        }
        final DateTime now = DateTime.now().toUtc();
        await (database.update(
          database.monthlyBills,
        )..where((MonthlyBills table) => table.id.equals(billId.value))).write(
          db.MonthlyBillsCompanion(
            status: const Value<String>("finalized"),
            finalizedAt: Value<DateTime?>(now),
            updatedAt: Value<DateTime>(now),
          ),
        );
        final domain.MonthlyBill bill = _bill(existing);
        return domain.MonthlyBill(
          id: bill.id,
          tenancyId: bill.tenancyId,
          propertyId: bill.propertyId,
          unitId: bill.unitId,
          period: bill.period,
          issueDate: bill.issueDate,
          dueDate: bill.dueDate,
          openingDue: bill.openingDue,
          currentCharges: bill.currentCharges,
          total: bill.total,
          paidAmount: bill.paidAmount,
          outstandingAmount: bill.outstandingAmount,
          status: domain.BillStatus.finalized,
          generatedAt: bill.generatedAt,
          finalizedAt: now,
        );
      });

  @override
  Future<Result<domain.MonthlyBill>> cancel(EntityId billId) =>
      guard<domain.MonthlyBill>(() async {
        final db.MonthlyBill? existing =
            await (database.select(
                  database.monthlyBills,
                )..where((MonthlyBills table) => table.id.equals(billId.value)))
                .getSingleOrNull();
        if (existing == null) {
          throw StateError('Bill not found.');
        }
        final DateTime now = DateTime.now().toUtc();
        await (database.update(
          database.monthlyBills,
        )..where((MonthlyBills table) => table.id.equals(billId.value))).write(
          db.MonthlyBillsCompanion(
            status: const Value<String>('cancelled'),
            updatedAt: Value<DateTime>(now),
          ),
        );
        final domain.MonthlyBill bill = _bill(existing);
        return domain.MonthlyBill(
          id: bill.id,
          tenancyId: bill.tenancyId,
          propertyId: bill.propertyId,
          unitId: bill.unitId,
          period: bill.period,
          issueDate: bill.issueDate,
          dueDate: bill.dueDate,
          openingDue: bill.openingDue,
          currentCharges: bill.currentCharges,
          total: bill.total,
          paidAmount: bill.paidAmount,
          outstandingAmount: bill.outstandingAmount,
          status: domain.BillStatus.cancelled,
          generatedAt: bill.generatedAt,
          finalizedAt: bill.finalizedAt,
        );
      });

  @override
  Future<Result<void>> saveDraft(domain.BillDraft draft) =>
      inTransaction<void>(() async {
        final db.MonthlyBill? existing =
            await (database.select(database.monthlyBills)..where(
                  (MonthlyBills table) =>
                      table.tenancyId.equals(draft.bill.tenancyId.value) &
                      table.billingYear.equals(draft.bill.period.year) &
                      table.billingMonth.equals(draft.bill.period.month),
                ))
                .getSingleOrNull();
        if (existing != null) {
          throw StateError('A bill already exists for this tenancy and month.');
        }
        final DateTime now = DateTime.now().toUtc();
        await database
            .into(database.monthlyBills)
            .insert(
              db.MonthlyBillsCompanion.insert(
                id: draft.bill.id.value,
                tenancyId: draft.bill.tenancyId.value,
                propertyId: draft.bill.propertyId.value,
                unitId: draft.bill.unitId.value,
                billingYear: draft.bill.period.year,
                billingMonth: draft.bill.period.month,
                issuedAt: Value<DateTime?>(draft.bill.issueDate.toUtc()),
                dueDate: Value<DateTime?>(draft.bill.dueDate?.toUtc()),
                status: Value<String>(draft.bill.status.name),
                previousDuePoisha: Value<int>(draft.bill.openingDue.poisha),
                subtotalPoisha: Value<int>(draft.bill.currentCharges.poisha),
                totalPoisha: Value<int>(draft.bill.total.poisha),
                paidPoisha: Value<int>(draft.bill.paidAmount.poisha),
                balancePoisha: Value<int>(draft.bill.outstandingAmount.poisha),
                finalizedAt: Value<DateTime?>(draft.bill.finalizedAt?.toUtc()),
                createdAt: Value<DateTime>(draft.bill.generatedAt.toUtc()),
                updatedAt: Value<DateTime>(now),
              ),
            );
        await database.batch((Batch batch) {
          batch.insertAll(
            database.billLineItems,
            draft.items
                .map((domain.BillLineItem item) {
                  final Map<String, int> metadata = <String, int>{
                    if (item.previousReading != null)
                      'previousReading': item.previousReading!.value,
                    if (item.currentReading != null)
                      'currentReading': item.currentReading!.value,
                  };
                  return db.BillLineItemsCompanion.insert(
                    id: item.id.value,
                    billId: item.billId.value,
                    itemType: item.type.name,
                    description: item.description,
                    quantity: Value<int?>(item.quantity),
                    unitRatePoisha: Value<int?>(item.unitRate?.poisha),
                    amountPoisha: item.amount.poisha,
                    sourceRuleId: Value<String?>(item.sourceRuleId?.value),
                    sortOrder: Value<int>(item.displayOrder),
                    metadataJson: Value<String?>(
                      metadata.isEmpty ? null : jsonEncode(metadata),
                    ),
                    createdAt: Value<DateTime>(now),
                  );
                })
                .toList(growable: false),
          );
        });
      });

  domain.MonthlyBill _bill(db.MonthlyBill row) => domain.MonthlyBill(
    id: EntityId(row.id),
    tenancyId: EntityId(row.tenancyId),
    propertyId: EntityId(row.propertyId),
    unitId: EntityId(row.unitId),
    period: BillingMonth(row.billingYear, row.billingMonth),
    issueDate: row.issuedAt ?? row.createdAt,
    dueDate: row.dueDate,
    openingDue: Money.fromPoisha(row.previousDuePoisha),
    currentCharges: Money.fromPoisha(row.subtotalPoisha),
    total: Money.fromPoisha(row.totalPoisha),
    paidAmount: Money.fromPoisha(row.paidPoisha),
    outstandingAmount: Money.fromPoisha(row.balancePoisha),
    status: domain.BillStatus.values.firstWhere(
      (domain.BillStatus status) => status.name == row.status,
      orElse: () => domain.BillStatus.draft,
    ),
    generatedAt: row.createdAt,
    finalizedAt: row.finalizedAt,
  );

  domain.BillLineItem _item(db.BillLineItem row) {
    final Map<String, dynamic> metadata = row.metadataJson == null
        ? <String, dynamic>{}
        : jsonDecode(row.metadataJson!) as Map<String, dynamic>;
    return domain.BillLineItem(
      id: EntityId(row.id),
      billId: EntityId(row.billId),
      type: ChargeType.values.firstWhere(
        (ChargeType type) => type.name == row.itemType,
        orElse: () => ChargeType.other,
      ),
      description: row.description,
      quantity: row.quantity,
      unitRate: row.unitRatePoisha == null
          ? null
          : Money.fromPoisha(row.unitRatePoisha!),
      amount: Money.fromPoisha(row.amountPoisha),
      previousReading: metadata['previousReading'] is int
          ? MeterReading(metadata['previousReading'] as int)
          : null,
      currentReading: metadata['currentReading'] is int
          ? MeterReading(metadata['currentReading'] as int)
          : null,
      sourceRuleId: row.sourceRuleId == null
          ? null
          : EntityId(row.sourceRuleId!),
      displayOrder: row.sortOrder,
    );
  }
}

/// Drift-backed append-only payment ledger with atomic bill allocation writes.
class DriftPaymentRepository extends DriftRepository
    implements PaymentRepository {
  /// Creates local payment-ledger operations.
  const DriftPaymentRepository(super.database);

  @override
  Future<Result<List<domain.Payment>>> listAll() =>
      guard<List<domain.Payment>>(() async {
        final List<db.Payment> rows =
            await (database.select(database.payments)
                  ..orderBy(<OrderingTerm Function(Payments)>[
                    (Payments table) => OrderingTerm.desc(table.paymentDate),
                  ]))
                .get();
        return rows.map(_payment).toList(growable: false);
      });

  @override
  Future<Result<List<domain.Payment>>> listByTenancy(EntityId tenancyId) =>
      guard<List<domain.Payment>>(() async {
        final List<db.Payment> rows =
            await (database.select(database.payments)
                  ..where(
                    (Payments table) => table.tenancyId.equals(tenancyId.value),
                  )
                  ..orderBy(<OrderingTerm Function(Payments)>[
                    (Payments table) => OrderingTerm.desc(table.paymentDate),
                  ]))
                .get();
        return rows.map(_payment).toList(growable: false);
      });

  @override
  Future<Result<void>> post(
    domain.PaymentPosting posting,
  ) => inTransaction<void>(() async {
    final int allocated = posting.allocations.fold<int>(
      0,
      (int total, domain.PaymentAllocation allocation) =>
          total + allocation.amount.poisha,
    );
    if (posting.payment.amount.poisha <= 0 ||
        allocated != posting.payment.amount.poisha ||
        posting.allocations.isEmpty) {
      throw StateError('Invalid payment allocation.');
    }
    final DateTime now = DateTime.now().toUtc();
    await database
        .into(database.payments)
        .insert(
          db.PaymentsCompanion.insert(
            id: posting.payment.id.value,
            tenancyId: posting.payment.tenancyId.value,
            tenantId: Value<String?>(posting.payment.tenantId.value),
            paymentNumber: 'PAY-${posting.payment.id.value.substring(0, 8)}',
            paymentDate: posting.payment.paymentDate.toUtc(),
            amountPoisha: posting.payment.amount.poisha,
            paymentMethod: posting.payment.method.name,
            reference: Value<String?>(posting.payment.reference),
            note: Value<String?>(posting.payment.note),
            status: Value<String>(posting.payment.status.name),
            createdAt: Value<DateTime>(posting.payment.createdAt.toUtc()),
            updatedAt: Value<DateTime>(now),
          ),
        );
    for (final domain.PaymentAllocation allocation in posting.allocations) {
      final db.MonthlyBill? bill =
          await (database.select(database.monthlyBills)..where(
                (MonthlyBills table) =>
                    table.id.equals(allocation.billId.value),
              ))
              .getSingleOrNull();
      if (bill == null ||
          bill.tenancyId != posting.payment.tenancyId.value ||
          allocation.amount.poisha <= 0 ||
          allocation.amount.poisha > bill.balancePoisha) {
        throw StateError('A payment allocation no longer matches its bill.');
      }
      final int paid = bill.paidPoisha + allocation.amount.poisha;
      final int balance = bill.balancePoisha - allocation.amount.poisha;
      await database
          .into(database.paymentAllocations)
          .insert(
            db.PaymentAllocationsCompanion.insert(
              id: allocation.id.value,
              paymentId: allocation.paymentId.value,
              billId: allocation.billId.value,
              amountPoisha: allocation.amount.poisha,
              createdAt: Value<DateTime>(now),
            ),
          );
      await (database.update(database.monthlyBills)..where(
            (MonthlyBills table) => table.id.equals(allocation.billId.value),
          ))
          .write(
            db.MonthlyBillsCompanion(
              paidPoisha: Value<int>(paid),
              balancePoisha: Value<int>(balance),
              status: Value<String>(
                balance == 0
                    ? domain.BillStatus.paid.name
                    : domain.BillStatus.partiallyPaid.name,
              ),
              updatedAt: Value<DateTime>(now),
            ),
          );
    }
    // Creating the snapshot in this transaction means every normal payment
    // posting has historical receipt data before a user can change names or
    // charge configuration. The repository is idempotent for legacy callers.
    final Result<domain.ReceiptSnapshot> receipt = await DriftReceiptRepository(
      database,
    ).createForPayment(posting.payment.id);
    if (receipt case Failure<domain.ReceiptSnapshot>()) {
      throw StateError('The payment receipt snapshot could not be saved.');
    }
  });

  @override
  Future<Result<domain.Payment>> reverse(EntityId paymentId, String reason) =>
      inTransaction<domain.Payment>(() async {
        final db.Payment? payment =
            await (database.select(database.payments)
                  ..where((Payments table) => table.id.equals(paymentId.value)))
                .getSingleOrNull();
        if (payment == null ||
            payment.status != domain.PaymentStatus.posted.name) {
          throw StateError('Only a posted payment can be reversed.');
        }
        final List<db.PaymentAllocation> allocations =
            await (database.select(database.paymentAllocations)..where(
                  (PaymentAllocations table) =>
                      table.paymentId.equals(paymentId.value),
                ))
                .get();
        final DateTime now = DateTime.now().toUtc();
        for (final db.PaymentAllocation allocation in allocations) {
          final db.MonthlyBill? bill =
              await (database.select(database.monthlyBills)..where(
                    (MonthlyBills table) => table.id.equals(allocation.billId),
                  ))
                  .getSingleOrNull();
          if (bill == null || bill.paidPoisha < allocation.amountPoisha) {
            throw StateError('Payment reversal could not restore its bill.');
          }
          final int paid = bill.paidPoisha - allocation.amountPoisha;
          await (database.update(
            database.monthlyBills,
          )..where((MonthlyBills table) => table.id.equals(bill.id))).write(
            db.MonthlyBillsCompanion(
              paidPoisha: Value<int>(paid),
              balancePoisha: Value<int>(
                bill.balancePoisha + allocation.amountPoisha,
              ),
              status: Value<String>(
                paid == 0
                    ? domain.BillStatus.finalized.name
                    : domain.BillStatus.partiallyPaid.name,
              ),
              updatedAt: Value<DateTime>(now),
            ),
          );
        }
        await (database.update(
          database.payments,
        )..where((Payments table) => table.id.equals(paymentId.value))).write(
          db.PaymentsCompanion(
            status: const Value<String>('reversed'),
            reversalReason: Value<String?>(reason),
            reversedAt: Value<DateTime?>(now),
            updatedAt: Value<DateTime>(now),
          ),
        );
        return _payment(
          payment,
          status: domain.PaymentStatus.reversed,
          reason: reason,
          reversedAt: now,
        );
      });

  domain.Payment _payment(
    db.Payment row, {
    domain.PaymentStatus? status,
    String? reason,
    DateTime? reversedAt,
  }) => domain.Payment(
    id: EntityId(row.id),
    tenancyId: EntityId(row.tenancyId),
    tenantId: EntityId(row.tenantId ?? row.tenancyId),
    amount: Money.fromPoisha(row.amountPoisha),
    paymentDate: row.paymentDate,
    method: PaymentMethod.values.firstWhere(
      (PaymentMethod method) => method.name == row.paymentMethod,
      orElse: () => PaymentMethod.other,
    ),
    reference: row.reference,
    note: row.note,
    status:
        status ??
        domain.PaymentStatus.values.firstWhere(
          (domain.PaymentStatus value) => value.name == row.status,
          orElse: () => domain.PaymentStatus.posted,
        ),
    reversalReason: reason ?? row.reversalReason,
    reversedAt: reversedAt ?? row.reversedAt,
    createdAt: row.createdAt,
  );
}

/// Builds and persists immutable receipt data from the posted-payment ledger.
///
/// All displayed names and bill lines are stored as JSON at creation time. The
/// saved snapshot, rather than live configuration, is therefore the source for
/// later PDF regeneration.
class DriftReceiptRepository extends DriftRepository
    implements ReceiptRepository {
  DriftReceiptRepository(super.database, {Uuid? uuid}) : _uuid = uuid ?? Uuid();

  final Uuid _uuid;

  @override
  Future<Result<domain.ReceiptSnapshot?>> findByPayment(EntityId paymentId) =>
      guard<domain.ReceiptSnapshot?>(() async {
        final db.Receipt? row =
            await (database.select(database.receipts)..where(
                  (Receipts table) => table.paymentId.equals(paymentId.value),
                ))
                .getSingleOrNull();
        return row == null
            ? null
            : domain.ReceiptSnapshot.fromJson(
                jsonDecode(row.snapshotJson) as Map<String, dynamic>,
              );
      });

  @override
  Future<Result<domain.ReceiptSnapshot>> createForPayment(
    EntityId paymentId,
  ) => inTransaction<domain.ReceiptSnapshot>(() async {
    final db.Receipt? existing =
        await (database.select(database.receipts)..where(
              (Receipts table) => table.paymentId.equals(paymentId.value),
            ))
            .getSingleOrNull();
    if (existing != null) {
      return domain.ReceiptSnapshot.fromJson(
        jsonDecode(existing.snapshotJson) as Map<String, dynamic>,
      );
    }
    final db.Payment? payment =
        await (database.select(database.payments)
              ..where((Payments table) => table.id.equals(paymentId.value)))
            .getSingleOrNull();
    if (payment == null || payment.status != domain.PaymentStatus.posted.name) {
      throw StateError('A receipt can only be created for a posted payment.');
    }
    final db.Tenancy? tenancy =
        await (database.select(database.tenancies)
              ..where((Tenancies table) => table.id.equals(payment.tenancyId)))
            .getSingleOrNull();
    if (tenancy == null) throw StateError('Payment tenancy was not found.');
    final db.Tenant? tenant =
        await (database.select(database.tenants)
              ..where((Tenants table) => table.id.equals(tenancy.tenantId)))
            .getSingleOrNull();
    final db.Unit? unit =
        await (database.select(database.units)
              ..where((Units table) => table.id.equals(tenancy.unitId)))
            .getSingleOrNull();
    if (tenant == null || unit == null) {
      throw StateError('Receipt party details were not found.');
    }
    final db.Property? property =
        await (database.select(database.properties)
              ..where((Properties table) => table.id.equals(unit.propertyId)))
            .getSingleOrNull();
    if (property == null) throw StateError('Receipt property was not found.');

    final List<db.PaymentAllocation> allocations =
        await (database.select(database.paymentAllocations)..where(
              (PaymentAllocations table) =>
                  table.paymentId.equals(paymentId.value),
            ))
            .get();
    if (allocations.isEmpty) {
      throw StateError('Payment has no bill allocation.');
    }

    final List<BillingMonth> months = <BillingMonth>[];
    final List<domain.ReceiptLineItem> lines = <domain.ReceiptLineItem>[];
    for (final db.PaymentAllocation allocation in allocations) {
      final db.MonthlyBill? bill =
          await (database.select(database.monthlyBills)..where(
                (MonthlyBills table) => table.id.equals(allocation.billId),
              ))
              .getSingleOrNull();
      if (bill == null) throw StateError('Allocated bill was not found.');
      final BillingMonth month = BillingMonth(
        bill.billingYear,
        bill.billingMonth,
      );
      months.add(month);
      if (bill.previousDuePoisha != 0) {
        lines.add(
          domain.ReceiptLineItem(
            description: 'Previous due (${month.key})',
            amount: Money.fromPoisha(bill.previousDuePoisha),
          ),
        );
      }
      final List<db.BillLineItem> items =
          await (database.select(database.billLineItems)
                ..where((BillLineItems table) => table.billId.equals(bill.id))
                ..orderBy(<OrderingTerm Function(BillLineItems)>[
                  (BillLineItems table) => OrderingTerm.asc(table.sortOrder),
                ]))
              .get();
      lines.addAll(
        items.map(
          (db.BillLineItem item) => domain.ReceiptLineItem(
            description: allocations.length == 1
                ? item.description
                : '${month.key} - ${item.description}',
            amount: Money.fromPoisha(item.amountPoisha),
          ),
        ),
      );
    }
    final List<db.MonthlyBill> stillDue =
        await (database.select(database.monthlyBills)..where(
              (MonthlyBills table) =>
                  table.tenancyId.equals(payment.tenancyId) &
                  table.balancePoisha.isBiggerThanValue(0) &
                  table.status.isNotValue(domain.BillStatus.draft.name) &
                  table.status.isNotValue(domain.BillStatus.cancelled.name),
            ))
            .get();
    final int remainingDue = stillDue.fold<int>(
      0,
      (int total, db.MonthlyBill bill) => total + bill.balancePoisha,
    );
    final DateTime createdAt = DateTime.now().toUtc();
    final String id = _uuid.v4();
    // UUID-derived suffix remains unique even if an old backup is restored
    // and new receipts are issued from two diverging database copies.
    final String receiptNumber =
        'BV-${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${id.replaceAll('-', '').substring(0, 10).toUpperCase()}';
    final String address =
        <String?>[property.addressLine, property.area, property.cityDistrict]
            .whereType<String>()
            .map((String value) => value.trim())
            .where((String value) => value.isNotEmpty)
            .join(', ');
    final domain.ReceiptSnapshot snapshot = domain.ReceiptSnapshot(
      id: EntityId(id),
      paymentId: paymentId,
      receiptNumber: receiptNumber,
      templateVersion: 1,
      createdAt: createdAt,
      propertyName: property.name,
      propertyAddress: address.isEmpty ? null : address,
      landlordName: _optionalText(property.ownerName),
      landlordPhone: _optionalText(property.ownerPhone),
      tenantName: tenant.fullName,
      unitName: unit.floorName == null || unit.floorName!.trim().isEmpty
          ? unit.name
          : '${unit.floorName} - ${unit.name}',
      billingMonths: List<BillingMonth>.unmodifiable(months),
      chargeBreakdown: List<domain.ReceiptLineItem>.unmodifiable(lines),
      paymentAmount: Money.fromPoisha(payment.amountPoisha),
      remainingDue: Money.fromPoisha(remainingDue),
      paymentMethod: PaymentMethod.values.firstWhere(
        (PaymentMethod method) => method.name == payment.paymentMethod,
        orElse: () => PaymentMethod.other,
      ),
      paymentDate: payment.paymentDate,
    );
    await database
        .into(database.receipts)
        .insert(
          db.ReceiptsCompanion.insert(
            id: id,
            paymentId: paymentId.value,
            receiptNumber: receiptNumber,
            templateVersion: snapshot.templateVersion,
            snapshotJson: jsonEncode(snapshot.toJson()),
            createdAt: Value<DateTime>(createdAt),
          ),
        );
    return snapshot;
  });

  static String? _optionalText(String? value) {
    final String? trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

/// Separate ledger for tenant-held deposits and advance balances.
class DriftDepositRepository extends DriftRepository
    implements DepositRepository {
  const DriftDepositRepository(super.database);
  @override
  Future<Result<domain.Deposit?>> findByTenancy(EntityId tenancyId) =>
      guard(() async {
        final row = await (database.select(
          database.deposits,
        )..where((t) => t.tenancyId.equals(tenancyId.value))).getSingleOrNull();
        return row == null ? null : _deposit(row);
      });
  @override
  Future<Result<List<domain.DepositTransaction>>> history(EntityId tenancyId) =>
      guard(() async {
        final account = await (database.select(
          database.deposits,
        )..where((t) => t.tenancyId.equals(tenancyId.value))).getSingleOrNull();
        if (account == null) return <domain.DepositTransaction>[];
        final rows =
            await (database.select(database.depositTransactions)
                  ..where((t) => t.depositId.equals(account.id))
                  ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)]))
                .get();
        return rows
            .map(
              (r) => domain.DepositTransaction(
                id: EntityId(r.id),
                depositId: EntityId(r.depositId),
                type: domain.DepositTransactionType.values.firstWhere(
                  (v) => v.name == r.type,
                  orElse: () => domain.DepositTransactionType.correction,
                ),
                amount: Money.fromPoisha(r.amountPoisha),
                date: r.transactionDate,
                note: r.note,
                method: r.paymentMethod == null
                    ? null
                    : PaymentMethod.values.firstWhere(
                        (v) => v.name == r.paymentMethod,
                        orElse: () => PaymentMethod.other,
                      ),
              ),
            )
            .toList();
      });
  @override
  Future<Result<void>> post(
    domain.Deposit deposit,
    domain.DepositTransaction transaction,
  ) => inTransaction(() async {
    final now = DateTime.now().toUtc();
    await database
        .into(database.deposits)
        .insertOnConflictUpdate(
          db.DepositsCompanion.insert(
            id: deposit.id.value,
            tenancyId: deposit.tenancyId.value,
            openingBalancePoisha: Value(deposit.currentBalance.poisha),
            expectedBalancePoisha: Value(deposit.expected.poisha),
            advanceRentBalancePoisha: Value(deposit.advanceRentBalance.poisha),
            currentBalancePoisha: Value(deposit.currentBalance.poisha),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    await database
        .into(database.depositTransactions)
        .insert(
          db.DepositTransactionsCompanion.insert(
            id: transaction.id.value,
            depositId: transaction.depositId.value,
            type: transaction.type.name,
            amountPoisha: transaction.amount.poisha,
            transactionDate: transaction.date,
            note: Value(transaction.note),
            paymentMethod: Value(transaction.method?.name),
            reference: const Value(null),
            createdAt: Value(now),
          ),
        );
  });
  domain.Deposit _deposit(db.Deposit row) => domain.Deposit(
    id: EntityId(row.id),
    tenancyId: EntityId(row.tenancyId),
    currentBalance: Money.fromPoisha(row.currentBalancePoisha),
    expected: Money.fromPoisha(row.expectedBalancePoisha),
    advanceRentBalance: Money.fromPoisha(row.advanceRentBalancePoisha),
  );
}

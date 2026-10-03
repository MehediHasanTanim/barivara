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
  Future<Result<void>> archive(EntityId id) => guard<void>(() async {
    await (database.update(
      database.properties,
    )..where((Properties table) => table.id.equals(id.value))).write(
      db.PropertiesCompanion(
        isArchived: const Value<bool>(true),
        status: const Value<String>('archived'),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  });

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
  Future<Result<void>> save(domain.Property property) => guard<void>(() async {
    await database
        .into(database.properties)
        .insertOnConflictUpdate(
          db.PropertiesCompanion.insert(
            id: property.id.value,
            name: property.name,
            isArchived: Value<bool>(property.isArchived),
            createdAt: Value<DateTime>(property.createdAt.toUtc()),
            updatedAt: Value<DateTime>(property.updatedAt.toUtc()),
          ),
        );
  });

  domain.Property _map(db.Property row) => domain.Property(
    id: EntityId(row.id),
    name: row.name,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isArchived: row.isArchived,
  );
}

/// Drift implementation of [UnitRepository].
class DriftUnitRepository extends DriftRepository implements UnitRepository {
  /// Creates a unit repository.
  const DriftUnitRepository(super.database);

  @override
  Future<Result<void>> archive(EntityId id) => guard<void>(() async {
    await (database.update(
      database.units,
    )..where((Units table) => table.id.equals(id.value))).write(
      db.UnitsCompanion(
        isArchived: const Value<bool>(true),
        updatedAt: Value<DateTime>(DateTime.now().toUtc()),
      ),
    );
  });

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
  Future<Result<void>> save(domain.RentalUnit unit) => guard<void>(() async {
    await database
        .into(database.units)
        .insertOnConflictUpdate(
          db.UnitsCompanion.insert(
            id: unit.id.value,
            propertyId: unit.propertyId.value,
            name: unit.name,
            defaultRentPoisha: Value<int>(unit.defaultRent.poisha),
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
    defaultRent: Money.fromPoisha(row.defaultRentPoisha),
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    isArchived: row.isArchived,
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

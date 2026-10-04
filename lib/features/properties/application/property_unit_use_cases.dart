import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:uuid/uuid.dart';

/// Editable property fields collected from the property form.
class PropertyInput {
  /// Creates validated property-form input.
  const PropertyInput({
    required this.name,
    this.type = PropertyType.residential,
    this.nickname,
    this.addressLine,
    this.area,
    this.cityDistrict,
    this.notes,
  });

  final String name;
  final PropertyType type;
  final String? nickname;
  final String? addressLine;
  final String? area;
  final String? cityDistrict;
  final String? notes;
}

/// Editable unit fields collected from the unit form.
class UnitInput {
  /// Creates unit-form input.
  const UnitInput({
    required this.name,
    required this.defaultRent,
    this.floorName,
    this.unitType = 'apartment',
    this.bedrooms,
    this.defaultServiceCharge = Money.zero,
    this.defaultGasCharge = Money.zero,
    this.defaultWaterCharge = Money.zero,
    this.manualAvailability = UnitAvailability.vacant,
    this.notes,
  });

  final String name;
  final Money defaultRent;
  final String? floorName;
  final String unitType;
  final int? bedrooms;
  final Money defaultServiceCharge;
  final Money defaultGasCharge;
  final Money defaultWaterCharge;
  final UnitAvailability manualAvailability;
  final String? notes;
}

/// Property CRUD commands and validation, kept out of presentation widgets.
class PropertyUseCases {
  /// Creates property commands with a local repository.
  PropertyUseCases(this._repository, {Uuid? uuid}) : _uuid = uuid ?? Uuid();

  final PropertyRepository _repository;
  final Uuid _uuid;

  /// Creates a property after validating its name and duplicate warning.
  Future<Result<Property>> create(
    PropertyInput input, {
    bool allowDuplicateName = false,
  }) async {
    final Result<void> validation = await _validate(
      input,
      allowDuplicateName: allowDuplicateName,
    );
    if (validation case Failure<void>(:final failure)) {
      return Result<Property>.failure(failure);
    }
    final DateTime now = DateTime.now().toUtc();
    final Property property = _propertyFromInput(
      id: EntityId(_uuid.v4()),
      input: input,
      createdAt: now,
      updatedAt: now,
    );
    final Result<void> saved = await _repository.save(property);
    return switch (saved) {
      Success<void>() => Result<Property>.success(property),
      Failure<void>(:final failure) => Result<Property>.failure(failure),
    };
  }

  /// Updates a property while retaining its immutable identity and created time.
  Future<Result<Property>> update(
    Property existing,
    PropertyInput input, {
    bool allowDuplicateName = false,
  }) async {
    final Result<void> validation = await _validate(
      input,
      excludingId: existing.id,
      allowDuplicateName: allowDuplicateName,
    );
    if (validation case Failure<void>(:final failure)) {
      return Result<Property>.failure(failure);
    }
    final Property property = _propertyFromInput(
      id: existing.id,
      input: input,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now().toUtc(),
      isArchived: existing.isArchived,
    );
    final Result<void> saved = await _repository.save(property);
    return switch (saved) {
      Success<void>() => Result<Property>.success(property),
      Failure<void>(:final failure) => Result<Property>.failure(failure),
    };
  }

  /// Gets a property by stable local ID.
  Future<Result<Property?>> get(EntityId id) => _repository.findById(id);

  /// Lists default operational properties only.
  Future<Result<List<PropertySummary>>> list() => _repository.listSummaries();

  /// Archives a property only after active units have been handled.
  Future<Result<void>> archive(EntityId id) => _repository.archive(id);

  Future<Result<void>> _validate(
    PropertyInput input, {
    EntityId? excludingId,
    required bool allowDuplicateName,
  }) async {
    if (input.name.trim().isEmpty) {
      return Result<void>.failure(
        const ValidationError('Property name is required.'),
      );
    }
    final Result<bool> duplicate = await _repository.hasDuplicateName(
      input.name,
      excludingId: excludingId,
    );
    return switch (duplicate) {
      Failure<bool>(:final failure) => Result<void>.failure(failure),
      Success<bool>(value: true) when !allowDuplicateName =>
        Result<void>.failure(
          const ConflictError(
            'A property with this name already exists. Add an address to distinguish it or save anyway.',
          ),
        ),
      Success<bool>() => Result<void>.success(null),
    };
  }

  Property _propertyFromInput({
    required EntityId id,
    required PropertyInput input,
    required DateTime createdAt,
    required DateTime updatedAt,
    bool isArchived = false,
  }) {
    return Property(
      id: id,
      name: input.name.trim(),
      type: input.type,
      nickname: _optional(input.nickname),
      addressLine: _optional(input.addressLine),
      area: _optional(input.area),
      cityDistrict: _optional(input.cityDistrict),
      notes: _optional(input.notes),
      createdAt: createdAt,
      updatedAt: updatedAt,
      isArchived: isArchived,
    );
  }
}

/// Unit CRUD commands and validation, including cross-property isolation.
class UnitUseCases {
  /// Creates unit commands with a local repository.
  UnitUseCases(this._repository, {Uuid? uuid}) : _uuid = uuid ?? Uuid();

  final UnitRepository _repository;
  final Uuid _uuid;

  /// Creates a unit under [propertyId].
  Future<Result<RentalUnit>> create(EntityId propertyId, UnitInput input) =>
      _save(
        id: EntityId(_uuid.v4()),
        propertyId: propertyId,
        input: input,
        createdAt: DateTime.now().toUtc(),
        isArchived: false,
      );

  /// Updates an existing unit without changing its property association.
  Future<Result<RentalUnit>> update(RentalUnit existing, UnitInput input) =>
      _save(
        id: existing.id,
        propertyId: existing.propertyId,
        input: input,
        createdAt: existing.createdAt,
        isArchived: existing.isArchived,
      );

  /// Gets a unit by stable local ID.
  Future<Result<RentalUnit?>> get(EntityId id) => _repository.findById(id);

  /// Lists one property's unit summaries using the selected availability filter.
  Future<Result<List<UnitSummary>>> listByProperty(
    EntityId propertyId, {
    UnitFilter filter = UnitFilter.all,
  }) => _repository.listSummariesByProperty(propertyId, filter: filter);

  /// Archives a unit only when no tenant is actively occupying it.
  Future<Result<void>> archive(EntityId id) => _repository.archive(id);

  Future<Result<RentalUnit>> _save({
    required EntityId id,
    required EntityId propertyId,
    required UnitInput input,
    required DateTime createdAt,
    required bool isArchived,
  }) async {
    if (input.name.trim().isEmpty) {
      return Result<RentalUnit>.failure(
        const ValidationError('Unit name or number is required.'),
      );
    }
    if (input.defaultRent.isNegative) {
      return Result<RentalUnit>.failure(
        const ValidationError('Default monthly rent cannot be negative.'),
      );
    }
    final RentalUnit unit = RentalUnit(
      id: id,
      propertyId: propertyId,
      name: input.name.trim(),
      floorName: _optional(input.floorName),
      unitType: input.unitType,
      bedrooms: input.bedrooms,
      defaultRent: input.defaultRent,
      defaultServiceCharge: input.defaultServiceCharge,
      defaultGasCharge: input.defaultGasCharge,
      defaultWaterCharge: input.defaultWaterCharge,
      manualAvailability: input.manualAvailability,
      notes: _optional(input.notes),
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
      isArchived: isArchived,
    );
    final Result<void> saved = await _repository.save(unit);
    return switch (saved) {
      Success<void>() => Result<RentalUnit>.success(unit),
      Failure<void>(:final failure) => Result<RentalUnit>.failure(failure),
    };
  }
}

String? _optional(String? value) {
  final String? trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

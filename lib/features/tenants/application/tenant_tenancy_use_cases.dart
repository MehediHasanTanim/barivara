import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:uuid/uuid.dart';

/// Editable tenant profile fields collected from the tenant form.
class TenantInput {
  /// Creates tenant-form input.
  const TenantInput({
    required this.fullName,
    required this.phone,
    this.alternativePhone,
    this.nidNumber,
    this.permanentAddress,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.notes,
    this.photoPath,
  });

  final String fullName;
  final String phone;
  final String? alternativePhone;
  final String? nidNumber;
  final String? permanentAddress;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? notes;
  final String? photoPath;
}

/// Terms confirmed while assigning a tenant to a vacant unit.
class TenancyInput {
  /// Creates tenancy-form input.
  const TenancyInput({
    required this.tenantId,
    required this.unitId,
    required this.moveInDate,
    required this.agreedRent,
    required this.billingDay,
    this.expectedMoveOutDate,
    this.securityDepositTarget = Money.zero,
    this.advanceRent = Money.zero,
    this.agreementNotes,
  });

  final EntityId tenantId;
  final EntityId unitId;
  final DateTime moveInDate;
  final Money agreedRent;
  final int billingDay;
  final DateTime? expectedMoveOutDate;
  final Money securityDepositTarget;
  final Money advanceRent;
  final String? agreementNotes;
}

/// Tenant profile commands and search queries.
class TenantUseCases {
  /// Creates tenant operations.
  TenantUseCases(this._repository, {Uuid? uuid}) : _uuid = uuid ?? Uuid();

  final TenantRepository _repository;
  final Uuid _uuid;

  /// Creates a tenant profile.
  Future<Result<Tenant>> create(TenantInput input) async {
    final Result<void> validation = _validate(input);
    if (validation case Failure<void>(:final failure)) {
      return Result<Tenant>.failure(failure);
    }
    final DateTime now = DateTime.now().toUtc();
    final Tenant tenant = _fromInput(
      id: EntityId(_uuid.v4()),
      input: input,
      createdAt: now,
      updatedAt: now,
    );
    return _save(tenant);
  }

  /// Updates a profile without overwriting identity or occupancy history.
  Future<Result<Tenant>> update(Tenant existing, TenantInput input) async {
    final Result<void> validation = _validate(input);
    if (validation case Failure<void>(:final failure)) {
      return Result<Tenant>.failure(failure);
    }
    return _save(
      _fromInput(
        id: existing.id,
        input: input,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now().toUtc(),
        isArchived: existing.isArchived,
      ),
    );
  }

  /// Returns a tenant profile by stable local ID.
  Future<Result<Tenant?>> get(EntityId id) => _repository.findById(id);

  /// Searches name, phone, active unit, and active property locally.
  Future<Result<List<TenantSummary>>> search(String query) =>
      _repository.searchSummaries(query);

  /// Archives a profile while retaining all tenancy history rows.
  Future<Result<void>> archive(EntityId id) => _repository.archive(id);

  Result<void> _validate(TenantInput input) {
    if (input.fullName.trim().isEmpty) {
      return Result<void>.failure(
        const ValidationError('Tenant full name is required.'),
      );
    }
    try {
      PhoneNumber(input.phone);
      if (_optional(input.alternativePhone) != null) {
        PhoneNumber(input.alternativePhone!);
      }
      if (_optional(input.emergencyContactPhone) != null) {
        PhoneNumber(input.emergencyContactPhone!);
      }
      return Result<void>.success(null);
    } on ArgumentError {
      return Result<void>.failure(
        const ValidationError('Enter a valid mobile number.'),
      );
    }
  }

  Future<Result<Tenant>> _save(Tenant tenant) async {
    final Result<void> result = await _repository.save(tenant);
    return switch (result) {
      Success<void>() => Result<Tenant>.success(tenant),
      Failure<void>(:final failure) => Result<Tenant>.failure(failure),
    };
  }

  Tenant _fromInput({
    required EntityId id,
    required TenantInput input,
    required DateTime createdAt,
    required DateTime updatedAt,
    bool isArchived = false,
  }) => Tenant(
    id: id,
    fullName: input.fullName.trim(),
    phone: PhoneNumber(input.phone),
    alternativePhone: _phone(input.alternativePhone),
    nidNumber: _optional(input.nidNumber),
    permanentAddress: _optional(input.permanentAddress),
    emergencyContactName: _optional(input.emergencyContactName),
    emergencyContactPhone: _phone(input.emergencyContactPhone),
    notes: _optional(input.notes),
    photoPath: _optional(input.photoPath),
    createdAt: createdAt,
    updatedAt: updatedAt,
    isArchived: isArchived,
  );
}

/// Tenancy commands that preserve history and guard against overlap.
class TenancyUseCases {
  /// Creates tenancy operations.
  TenancyUseCases(this._repository, {Uuid? uuid}) : _uuid = uuid ?? Uuid();

  final TenancyRepository _repository;
  final Uuid _uuid;

  /// Creates an active tenancy only when its unit is free for the move-in date.
  Future<Result<Tenancy>> create(TenancyInput input) async {
    if (input.agreedRent.isNegative ||
        input.securityDepositTarget.isNegative ||
        input.advanceRent.isNegative) {
      return Result<Tenancy>.failure(
        const ValidationError('Tenancy money values cannot be negative.'),
      );
    }
    if (input.billingDay < 1 || input.billingDay > 28) {
      return Result<Tenancy>.failure(
        const ValidationError('Billing day must be between 1 and 28.'),
      );
    }
    if (input.expectedMoveOutDate != null &&
        input.expectedMoveOutDate!.isBefore(input.moveInDate)) {
      return Result<Tenancy>.failure(
        const ValidationError('Expected move-out cannot be before move-in.'),
      );
    }
    final Result<Tenancy?> existing = await _repository.findActiveByUnit(
      input.unitId,
    );
    if (existing case Failure<Tenancy?>(:final failure)) {
      return Result<Tenancy>.failure(failure);
    }
    if (existing case Success<Tenancy?>(value: final Tenancy active?)) {
      return Result<Tenancy>.failure(
        ConflictError(
          'This unit is already occupied since ${active.moveInDate.toIso8601String().substring(0, 10)}.',
        ),
      );
    }
    final Tenancy tenancy = Tenancy(
      id: EntityId(_uuid.v4()),
      tenantId: input.tenantId,
      unitId: input.unitId,
      moveInDate: input.moveInDate.toUtc(),
      expectedMoveOutDate: input.expectedMoveOutDate?.toUtc(),
      agreedRent: input.agreedRent,
      billingDay: input.billingDay,
      securityDepositTarget: input.securityDepositTarget,
      advanceRent: input.advanceRent,
      agreementNotes: _optional(input.agreementNotes),
    );
    final Result<void> saved = await _repository.save(tenancy);
    return switch (saved) {
      Success<void>() => Result<Tenancy>.success(tenancy),
      Failure<void>(:final failure) => Result<Tenancy>.failure(failure),
    };
  }

  /// Records move-out and stops future charge rules without deleting history.
  Future<Result<void>> moveOut(Tenancy tenancy, DateTime effectiveDate) async {
    if (effectiveDate.isBefore(tenancy.moveInDate)) {
      return Result<void>.failure(
        const ValidationError('Move-out date cannot be before move-in.'),
      );
    }
    if (tenancy.status != TenancyStatus.active) {
      return Result<void>.failure(
        const ConflictError('This tenancy has already ended.'),
      );
    }
    return _repository.moveOut(tenancy.id, effectiveDate);
  }

  /// Lists preserved history for a tenant.
  Future<Result<List<Tenancy>>> historyForTenant(EntityId tenantId) =>
      _repository.listByTenant(tenantId);

  /// Lists preserved history for a unit, optionally within a date range.
  Future<Result<List<Tenancy>>> historyForUnit(
    EntityId unitId, {
    DateRange? range,
  }) => _repository.listByUnit(unitId, range: range);
}

String? _optional(String? value) {
  final String? trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

PhoneNumber? _phone(String? value) {
  final String? normalized = _optional(value);
  return normalized == null ? null : PhoneNumber(normalized);
}

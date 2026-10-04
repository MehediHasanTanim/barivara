import 'dart:io';

import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/repositories.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/result/result.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// User-entered repair details, independent of widget state.
class RepairInput {
  const RepairInput({
    required this.propertyId,
    required this.title,
    required this.reportedDate,
    required this.cost,
    this.unitId,
    this.tenancyId,
    this.category = RepairCategory.other,
    this.description,
    this.completedDate,
    this.estimatedCost,
    this.responsibility = RepairResponsibility.landlord,
    this.recoverableFromTenant = false,
    this.status = RepairStatus.open,
    this.notes,
  });

  final EntityId propertyId;
  final EntityId? unitId;
  final EntityId? tenancyId;
  final RepairCategory category;
  final String title;
  final String? description;
  final DateTime reportedDate;
  final DateTime? completedDate;
  final Money? estimatedCost;
  final Money cost;
  final RepairResponsibility responsibility;
  final bool recoverableFromTenant;
  final RepairStatus status;
  final String? notes;
}

/// Coordinates maintenance persistence and its optional explicit bill charge.
class RepairUseCases {
  RepairUseCases(this._repairs, this._bills, {Uuid? uuid})
    : _uuid = uuid ?? Uuid();

  final RepairRepository _repairs;
  final BillingRepository _bills;
  final Uuid _uuid;

  Future<Result<Repair>> save(RepairInput input) async {
    if (input.title.trim().isEmpty) {
      return Result<Repair>.failure(
        const ValidationError('A repair title is required.'),
      );
    }
    if (input.cost.poisha < 0 ||
        (input.estimatedCost != null && input.estimatedCost!.poisha < 0)) {
      return Result<Repair>.failure(
        const ValidationError('Repair amounts cannot be negative.'),
      );
    }
    MonthlyBill? chargeBill;
    if (input.recoverableFromTenant) {
      if (input.tenancyId == null || input.cost.poisha <= 0) {
        return Result<Repair>.failure(
          const ValidationError(
            'A recoverable repair needs an active tenancy and actual cost.',
          ),
        );
      }
      final Result<MonthlyBill?> billResult = await _bills.findForPeriod(
        input.tenancyId!,
        BillingMonth.fromDate(input.reportedDate),
      );
      if (billResult case Failure<MonthlyBill?>(:final failure)) {
        return Result<Repair>.failure(failure);
      }
      chargeBill = (billResult as Success<MonthlyBill?>).value;
      if (chargeBill == null || chargeBill.status != BillStatus.draft) {
        return Result<Repair>.failure(
          const ConflictError(
            'Create or reopen this month\'s draft bill before adding a tenant repair charge.',
          ),
        );
      }
    }

    final Repair repair = Repair(
      id: EntityId(_uuid.v4()),
      propertyId: input.propertyId,
      unitId: input.unitId,
      tenancyId: input.tenancyId,
      category: input.category,
      title: input.title.trim(),
      description: _optional(input.description),
      reportedDate: input.reportedDate.toUtc(),
      completedDate: input.completedDate?.toUtc(),
      estimatedCost: input.estimatedCost,
      cost: input.cost,
      responsibility: input.responsibility,
      recoverableFromTenant: input.recoverableFromTenant,
      status: input.status,
      notes: _optional(input.notes),
    );
    final Result<void> saved = await _repairs.save(repair);
    if (saved case Failure<void>(:final failure)) {
      return Result<Repair>.failure(failure);
    }
    if (chargeBill == null) return Result<Repair>.success(repair);

    final BillLineItem adjustment = BillLineItem(
      id: EntityId(_uuid.v4()),
      billId: chargeBill.id,
      type: ChargeType.other,
      description: 'Repair charge: ${repair.title}',
      amount: repair.cost,
      sourceRuleId: repair.id,
      displayOrder: 10000,
    );
    final Result<MonthlyBill> charged = await _bills.addAdjustment(
      chargeBill.id,
      adjustment,
    );
    if (charged case Failure<MonthlyBill>(:final failure)) {
      return Result<Repair>.failure(failure);
    }
    final Result<void> linked = await _repairs.linkTenantCharge(
      repair.id,
      chargeBill.id,
    );
    if (linked case Failure<void>(:final failure)) {
      return Result<Repair>.failure(failure);
    }
    return Result<Repair>.success(
      Repair(
        id: repair.id,
        propertyId: repair.propertyId,
        unitId: repair.unitId,
        tenancyId: repair.tenancyId,
        category: repair.category,
        title: repair.title,
        description: repair.description,
        reportedDate: repair.reportedDate,
        completedDate: repair.completedDate,
        estimatedCost: repair.estimatedCost,
        cost: repair.cost,
        responsibility: repair.responsibility,
        recoverableFromTenant: true,
        tenantChargeBillId: chargeBill.id,
        status: repair.status,
        notes: repair.notes,
      ),
    );
  }

  Future<Result<RepairExpenseSummary>> expenseSummary(
    EntityId propertyId,
    DateRange range,
  ) => _repairs.expenseSummary(propertyId, range);

  static String? _optional(String? value) {
    final String? trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

/// Copies imported files to application storage and returns durable metadata.
class RepairAttachmentStorage {
  RepairAttachmentStorage({
    Uuid? uuid,
    Future<Directory> Function()? documentsDirectory,
  }) : _uuid = uuid ?? Uuid(),
       _documentsDirectory =
           documentsDirectory ?? getApplicationDocumentsDirectory;

  final Uuid _uuid;
  final Future<Directory> Function() _documentsDirectory;

  Future<Result<RepairAttachment>> importFile({
    required EntityId repairId,
    required String sourcePath,
    required String originalFileName,
  }) async {
    try {
      final File source = File(sourcePath);
      if (!await source.exists()) {
        return Result<RepairAttachment>.failure(
          const FileSystemError(
            'The selected attachment is no longer available.',
          ),
        );
      }
      final String attachmentId = _uuid.v4();
      final String safeName = originalFileName.replaceAll(
        RegExp(r'[^A-Za-z0-9._-]'),
        '_',
      );
      final Directory documents = await _documentsDirectory();
      final Directory destinationFolder = Directory(
        '${documents.path}/repair_attachments/${repairId.value}',
      );
      await destinationFolder.create(recursive: true);
      final String storedName = '$attachmentId-$safeName';
      final File destination = File('${destinationFolder.path}/$storedName');
      await source.copy(destination.path);
      final List<int> bytes = await destination.readAsBytes();
      return Result<RepairAttachment>.success(
        RepairAttachment(
          id: EntityId(attachmentId),
          repairId: repairId,
          fileName: originalFileName,
          relativePath: 'repair_attachments/${repairId.value}/$storedName',
          mimeType: _mimeType(safeName),
          fileSize: bytes.length,
          checksum: sha256.convert(bytes).toString(),
          createdAt: DateTime.now().toUtc(),
        ),
      );
    } on FileSystemException {
      return Result<RepairAttachment>.failure(
        const FileSystemError(
          'The attachment could not be copied to app storage.',
        ),
      );
    }
  }

  static String? _mimeType(String name) {
    final String extension = name.split('.').last.toLowerCase();
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'pdf' => 'application/pdf',
      _ => null,
    };
  }
}

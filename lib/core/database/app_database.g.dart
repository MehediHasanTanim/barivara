// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyTypeMeta = const VerificationMeta(
    'propertyType',
  );
  @override
  late final GeneratedColumn<String> propertyType = GeneratedColumn<String>(
    'property_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('residential'),
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressLineMeta = const VerificationMeta(
    'addressLine',
  );
  @override
  late final GeneratedColumn<String> addressLine = GeneratedColumn<String>(
    'address_line',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityDistrictMeta = const VerificationMeta(
    'cityDistrict',
  );
  @override
  late final GeneratedColumn<String> cityDistrict = GeneratedColumn<String>(
    'city_district',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerPhoneMeta = const VerificationMeta(
    'ownerPhone',
  );
  @override
  late final GeneratedColumn<String> ownerPhone = GeneratedColumn<String>(
    'owner_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    propertyType,
    nickname,
    addressLine,
    area,
    cityDistrict,
    ownerName,
    ownerPhone,
    notes,
    status,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Property> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('property_type')) {
      context.handle(
        _propertyTypeMeta,
        propertyType.isAcceptableOrUnknown(
          data['property_type']!,
          _propertyTypeMeta,
        ),
      );
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('address_line')) {
      context.handle(
        _addressLineMeta,
        addressLine.isAcceptableOrUnknown(
          data['address_line']!,
          _addressLineMeta,
        ),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('city_district')) {
      context.handle(
        _cityDistrictMeta,
        cityDistrict.isAcceptableOrUnknown(
          data['city_district']!,
          _cityDistrictMeta,
        ),
      );
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('owner_phone')) {
      context.handle(
        _ownerPhoneMeta,
        ownerPhone.isAcceptableOrUnknown(data['owner_phone']!, _ownerPhoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      propertyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_type'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      addressLine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      cityDistrict: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_district'],
      ),
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      ),
      ownerPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final String id;
  final String name;
  final String propertyType;
  final String? nickname;
  final String? addressLine;
  final String? area;
  final String? cityDistrict;
  final String? ownerName;
  final String? ownerPhone;
  final String? notes;
  final String status;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Property({
    required this.id,
    required this.name,
    required this.propertyType,
    this.nickname,
    this.addressLine,
    this.area,
    this.cityDistrict,
    this.ownerName,
    this.ownerPhone,
    this.notes,
    required this.status,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['property_type'] = Variable<String>(propertyType);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || addressLine != null) {
      map['address_line'] = Variable<String>(addressLine);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || cityDistrict != null) {
      map['city_district'] = Variable<String>(cityDistrict);
    }
    if (!nullToAbsent || ownerName != null) {
      map['owner_name'] = Variable<String>(ownerName);
    }
    if (!nullToAbsent || ownerPhone != null) {
      map['owner_phone'] = Variable<String>(ownerPhone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      name: Value(name),
      propertyType: Value(propertyType),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      addressLine: addressLine == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      cityDistrict: cityDistrict == null && nullToAbsent
          ? const Value.absent()
          : Value(cityDistrict),
      ownerName: ownerName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerName),
      ownerPhone: ownerPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerPhone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Property.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      propertyType: serializer.fromJson<String>(json['propertyType']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      addressLine: serializer.fromJson<String?>(json['addressLine']),
      area: serializer.fromJson<String?>(json['area']),
      cityDistrict: serializer.fromJson<String?>(json['cityDistrict']),
      ownerName: serializer.fromJson<String?>(json['ownerName']),
      ownerPhone: serializer.fromJson<String?>(json['ownerPhone']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'propertyType': serializer.toJson<String>(propertyType),
      'nickname': serializer.toJson<String?>(nickname),
      'addressLine': serializer.toJson<String?>(addressLine),
      'area': serializer.toJson<String?>(area),
      'cityDistrict': serializer.toJson<String?>(cityDistrict),
      'ownerName': serializer.toJson<String?>(ownerName),
      'ownerPhone': serializer.toJson<String?>(ownerPhone),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Property copyWith({
    String? id,
    String? name,
    String? propertyType,
    Value<String?> nickname = const Value.absent(),
    Value<String?> addressLine = const Value.absent(),
    Value<String?> area = const Value.absent(),
    Value<String?> cityDistrict = const Value.absent(),
    Value<String?> ownerName = const Value.absent(),
    Value<String?> ownerPhone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Property(
    id: id ?? this.id,
    name: name ?? this.name,
    propertyType: propertyType ?? this.propertyType,
    nickname: nickname.present ? nickname.value : this.nickname,
    addressLine: addressLine.present ? addressLine.value : this.addressLine,
    area: area.present ? area.value : this.area,
    cityDistrict: cityDistrict.present ? cityDistrict.value : this.cityDistrict,
    ownerName: ownerName.present ? ownerName.value : this.ownerName,
    ownerPhone: ownerPhone.present ? ownerPhone.value : this.ownerPhone,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      propertyType: data.propertyType.present
          ? data.propertyType.value
          : this.propertyType,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      addressLine: data.addressLine.present
          ? data.addressLine.value
          : this.addressLine,
      area: data.area.present ? data.area.value : this.area,
      cityDistrict: data.cityDistrict.present
          ? data.cityDistrict.value
          : this.cityDistrict,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      ownerPhone: data.ownerPhone.present
          ? data.ownerPhone.value
          : this.ownerPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('propertyType: $propertyType, ')
          ..write('nickname: $nickname, ')
          ..write('addressLine: $addressLine, ')
          ..write('area: $area, ')
          ..write('cityDistrict: $cityDistrict, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerPhone: $ownerPhone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    propertyType,
    nickname,
    addressLine,
    area,
    cityDistrict,
    ownerName,
    ownerPhone,
    notes,
    status,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.name == this.name &&
          other.propertyType == this.propertyType &&
          other.nickname == this.nickname &&
          other.addressLine == this.addressLine &&
          other.area == this.area &&
          other.cityDistrict == this.cityDistrict &&
          other.ownerName == this.ownerName &&
          other.ownerPhone == this.ownerPhone &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> propertyType;
  final Value<String?> nickname;
  final Value<String?> addressLine;
  final Value<String?> area;
  final Value<String?> cityDistrict;
  final Value<String?> ownerName;
  final Value<String?> ownerPhone;
  final Value<String?> notes;
  final Value<String> status;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.propertyType = const Value.absent(),
    this.nickname = const Value.absent(),
    this.addressLine = const Value.absent(),
    this.area = const Value.absent(),
    this.cityDistrict = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertiesCompanion.insert({
    required String id,
    required String name,
    this.propertyType = const Value.absent(),
    this.nickname = const Value.absent(),
    this.addressLine = const Value.absent(),
    this.area = const Value.absent(),
    this.cityDistrict = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? propertyType,
    Expression<String>? nickname,
    Expression<String>? addressLine,
    Expression<String>? area,
    Expression<String>? cityDistrict,
    Expression<String>? ownerName,
    Expression<String>? ownerPhone,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (propertyType != null) 'property_type': propertyType,
      if (nickname != null) 'nickname': nickname,
      if (addressLine != null) 'address_line': addressLine,
      if (area != null) 'area': area,
      if (cityDistrict != null) 'city_district': cityDistrict,
      if (ownerName != null) 'owner_name': ownerName,
      if (ownerPhone != null) 'owner_phone': ownerPhone,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? propertyType,
    Value<String?>? nickname,
    Value<String?>? addressLine,
    Value<String?>? area,
    Value<String?>? cityDistrict,
    Value<String?>? ownerName,
    Value<String?>? ownerPhone,
    Value<String?>? notes,
    Value<String>? status,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PropertiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      propertyType: propertyType ?? this.propertyType,
      nickname: nickname ?? this.nickname,
      addressLine: addressLine ?? this.addressLine,
      area: area ?? this.area,
      cityDistrict: cityDistrict ?? this.cityDistrict,
      ownerName: ownerName ?? this.ownerName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (propertyType.present) {
      map['property_type'] = Variable<String>(propertyType.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (addressLine.present) {
      map['address_line'] = Variable<String>(addressLine.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (cityDistrict.present) {
      map['city_district'] = Variable<String>(cityDistrict.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (ownerPhone.present) {
      map['owner_phone'] = Variable<String>(ownerPhone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('propertyType: $propertyType, ')
          ..write('nickname: $nickname, ')
          ..write('addressLine: $addressLine, ')
          ..write('area: $area, ')
          ..write('cityDistrict: $cityDistrict, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerPhone: $ownerPhone, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UnitsTable extends Units with TableInfo<$UnitsTable, Unit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _floorNameMeta = const VerificationMeta(
    'floorName',
  );
  @override
  late final GeneratedColumn<String> floorName = GeneratedColumn<String>(
    'floor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitTypeMeta = const VerificationMeta(
    'unitType',
  );
  @override
  late final GeneratedColumn<String> unitType = GeneratedColumn<String>(
    'unit_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('apartment'),
  );
  static const VerificationMeta _bedroomsMeta = const VerificationMeta(
    'bedrooms',
  );
  @override
  late final GeneratedColumn<int> bedrooms = GeneratedColumn<int>(
    'bedrooms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultRentPoishaMeta = const VerificationMeta(
    'defaultRentPoisha',
  );
  @override
  late final GeneratedColumn<int> defaultRentPoisha = GeneratedColumn<int>(
    'default_rent_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultServiceChargePoishaMeta =
      const VerificationMeta('defaultServiceChargePoisha');
  @override
  late final GeneratedColumn<int> defaultServiceChargePoisha =
      GeneratedColumn<int>(
        'default_service_charge_poisha',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _defaultGasChargePoishaMeta =
      const VerificationMeta('defaultGasChargePoisha');
  @override
  late final GeneratedColumn<int> defaultGasChargePoisha = GeneratedColumn<int>(
    'default_gas_charge_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultWaterChargePoishaMeta =
      const VerificationMeta('defaultWaterChargePoisha');
  @override
  late final GeneratedColumn<int> defaultWaterChargePoisha =
      GeneratedColumn<int>(
        'default_water_charge_poisha',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _occupancyStatusMeta = const VerificationMeta(
    'occupancyStatus',
  );
  @override
  late final GeneratedColumn<String> occupancyStatus = GeneratedColumn<String>(
    'occupancy_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('vacant'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    name,
    floorName,
    unitType,
    bedrooms,
    defaultRentPoisha,
    defaultServiceChargePoisha,
    defaultGasChargePoisha,
    defaultWaterChargePoisha,
    occupancyStatus,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'units';
  @override
  VerificationContext validateIntegrity(
    Insertable<Unit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('floor_name')) {
      context.handle(
        _floorNameMeta,
        floorName.isAcceptableOrUnknown(data['floor_name']!, _floorNameMeta),
      );
    }
    if (data.containsKey('unit_type')) {
      context.handle(
        _unitTypeMeta,
        unitType.isAcceptableOrUnknown(data['unit_type']!, _unitTypeMeta),
      );
    }
    if (data.containsKey('bedrooms')) {
      context.handle(
        _bedroomsMeta,
        bedrooms.isAcceptableOrUnknown(data['bedrooms']!, _bedroomsMeta),
      );
    }
    if (data.containsKey('default_rent_poisha')) {
      context.handle(
        _defaultRentPoishaMeta,
        defaultRentPoisha.isAcceptableOrUnknown(
          data['default_rent_poisha']!,
          _defaultRentPoishaMeta,
        ),
      );
    }
    if (data.containsKey('default_service_charge_poisha')) {
      context.handle(
        _defaultServiceChargePoishaMeta,
        defaultServiceChargePoisha.isAcceptableOrUnknown(
          data['default_service_charge_poisha']!,
          _defaultServiceChargePoishaMeta,
        ),
      );
    }
    if (data.containsKey('default_gas_charge_poisha')) {
      context.handle(
        _defaultGasChargePoishaMeta,
        defaultGasChargePoisha.isAcceptableOrUnknown(
          data['default_gas_charge_poisha']!,
          _defaultGasChargePoishaMeta,
        ),
      );
    }
    if (data.containsKey('default_water_charge_poisha')) {
      context.handle(
        _defaultWaterChargePoishaMeta,
        defaultWaterChargePoisha.isAcceptableOrUnknown(
          data['default_water_charge_poisha']!,
          _defaultWaterChargePoishaMeta,
        ),
      );
    }
    if (data.containsKey('occupancy_status')) {
      context.handle(
        _occupancyStatusMeta,
        occupancyStatus.isAcceptableOrUnknown(
          data['occupancy_status']!,
          _occupancyStatusMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {propertyId, name},
  ];
  @override
  Unit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Unit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      floorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}floor_name'],
      ),
      unitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_type'],
      )!,
      bedrooms: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedrooms'],
      ),
      defaultRentPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_rent_poisha'],
      )!,
      defaultServiceChargePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_service_charge_poisha'],
      )!,
      defaultGasChargePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_gas_charge_poisha'],
      )!,
      defaultWaterChargePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_water_charge_poisha'],
      )!,
      occupancyStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occupancy_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UnitsTable createAlias(String alias) {
    return $UnitsTable(attachedDatabase, alias);
  }
}

class Unit extends DataClass implements Insertable<Unit> {
  final String id;
  final String propertyId;
  final String name;
  final String? floorName;
  final String unitType;
  final int? bedrooms;
  final int defaultRentPoisha;
  final int defaultServiceChargePoisha;
  final int defaultGasChargePoisha;
  final int defaultWaterChargePoisha;
  final String occupancyStatus;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Unit({
    required this.id,
    required this.propertyId,
    required this.name,
    this.floorName,
    required this.unitType,
    this.bedrooms,
    required this.defaultRentPoisha,
    required this.defaultServiceChargePoisha,
    required this.defaultGasChargePoisha,
    required this.defaultWaterChargePoisha,
    required this.occupancyStatus,
    this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || floorName != null) {
      map['floor_name'] = Variable<String>(floorName);
    }
    map['unit_type'] = Variable<String>(unitType);
    if (!nullToAbsent || bedrooms != null) {
      map['bedrooms'] = Variable<int>(bedrooms);
    }
    map['default_rent_poisha'] = Variable<int>(defaultRentPoisha);
    map['default_service_charge_poisha'] = Variable<int>(
      defaultServiceChargePoisha,
    );
    map['default_gas_charge_poisha'] = Variable<int>(defaultGasChargePoisha);
    map['default_water_charge_poisha'] = Variable<int>(
      defaultWaterChargePoisha,
    );
    map['occupancy_status'] = Variable<String>(occupancyStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UnitsCompanion toCompanion(bool nullToAbsent) {
    return UnitsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      name: Value(name),
      floorName: floorName == null && nullToAbsent
          ? const Value.absent()
          : Value(floorName),
      unitType: Value(unitType),
      bedrooms: bedrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bedrooms),
      defaultRentPoisha: Value(defaultRentPoisha),
      defaultServiceChargePoisha: Value(defaultServiceChargePoisha),
      defaultGasChargePoisha: Value(defaultGasChargePoisha),
      defaultWaterChargePoisha: Value(defaultWaterChargePoisha),
      occupancyStatus: Value(occupancyStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Unit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Unit(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      name: serializer.fromJson<String>(json['name']),
      floorName: serializer.fromJson<String?>(json['floorName']),
      unitType: serializer.fromJson<String>(json['unitType']),
      bedrooms: serializer.fromJson<int?>(json['bedrooms']),
      defaultRentPoisha: serializer.fromJson<int>(json['defaultRentPoisha']),
      defaultServiceChargePoisha: serializer.fromJson<int>(
        json['defaultServiceChargePoisha'],
      ),
      defaultGasChargePoisha: serializer.fromJson<int>(
        json['defaultGasChargePoisha'],
      ),
      defaultWaterChargePoisha: serializer.fromJson<int>(
        json['defaultWaterChargePoisha'],
      ),
      occupancyStatus: serializer.fromJson<String>(json['occupancyStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'name': serializer.toJson<String>(name),
      'floorName': serializer.toJson<String?>(floorName),
      'unitType': serializer.toJson<String>(unitType),
      'bedrooms': serializer.toJson<int?>(bedrooms),
      'defaultRentPoisha': serializer.toJson<int>(defaultRentPoisha),
      'defaultServiceChargePoisha': serializer.toJson<int>(
        defaultServiceChargePoisha,
      ),
      'defaultGasChargePoisha': serializer.toJson<int>(defaultGasChargePoisha),
      'defaultWaterChargePoisha': serializer.toJson<int>(
        defaultWaterChargePoisha,
      ),
      'occupancyStatus': serializer.toJson<String>(occupancyStatus),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Unit copyWith({
    String? id,
    String? propertyId,
    String? name,
    Value<String?> floorName = const Value.absent(),
    String? unitType,
    Value<int?> bedrooms = const Value.absent(),
    int? defaultRentPoisha,
    int? defaultServiceChargePoisha,
    int? defaultGasChargePoisha,
    int? defaultWaterChargePoisha,
    String? occupancyStatus,
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Unit(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    name: name ?? this.name,
    floorName: floorName.present ? floorName.value : this.floorName,
    unitType: unitType ?? this.unitType,
    bedrooms: bedrooms.present ? bedrooms.value : this.bedrooms,
    defaultRentPoisha: defaultRentPoisha ?? this.defaultRentPoisha,
    defaultServiceChargePoisha:
        defaultServiceChargePoisha ?? this.defaultServiceChargePoisha,
    defaultGasChargePoisha:
        defaultGasChargePoisha ?? this.defaultGasChargePoisha,
    defaultWaterChargePoisha:
        defaultWaterChargePoisha ?? this.defaultWaterChargePoisha,
    occupancyStatus: occupancyStatus ?? this.occupancyStatus,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Unit copyWithCompanion(UnitsCompanion data) {
    return Unit(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      name: data.name.present ? data.name.value : this.name,
      floorName: data.floorName.present ? data.floorName.value : this.floorName,
      unitType: data.unitType.present ? data.unitType.value : this.unitType,
      bedrooms: data.bedrooms.present ? data.bedrooms.value : this.bedrooms,
      defaultRentPoisha: data.defaultRentPoisha.present
          ? data.defaultRentPoisha.value
          : this.defaultRentPoisha,
      defaultServiceChargePoisha: data.defaultServiceChargePoisha.present
          ? data.defaultServiceChargePoisha.value
          : this.defaultServiceChargePoisha,
      defaultGasChargePoisha: data.defaultGasChargePoisha.present
          ? data.defaultGasChargePoisha.value
          : this.defaultGasChargePoisha,
      defaultWaterChargePoisha: data.defaultWaterChargePoisha.present
          ? data.defaultWaterChargePoisha.value
          : this.defaultWaterChargePoisha,
      occupancyStatus: data.occupancyStatus.present
          ? data.occupancyStatus.value
          : this.occupancyStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Unit(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('floorName: $floorName, ')
          ..write('unitType: $unitType, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('defaultRentPoisha: $defaultRentPoisha, ')
          ..write('defaultServiceChargePoisha: $defaultServiceChargePoisha, ')
          ..write('defaultGasChargePoisha: $defaultGasChargePoisha, ')
          ..write('defaultWaterChargePoisha: $defaultWaterChargePoisha, ')
          ..write('occupancyStatus: $occupancyStatus, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    name,
    floorName,
    unitType,
    bedrooms,
    defaultRentPoisha,
    defaultServiceChargePoisha,
    defaultGasChargePoisha,
    defaultWaterChargePoisha,
    occupancyStatus,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Unit &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.name == this.name &&
          other.floorName == this.floorName &&
          other.unitType == this.unitType &&
          other.bedrooms == this.bedrooms &&
          other.defaultRentPoisha == this.defaultRentPoisha &&
          other.defaultServiceChargePoisha == this.defaultServiceChargePoisha &&
          other.defaultGasChargePoisha == this.defaultGasChargePoisha &&
          other.defaultWaterChargePoisha == this.defaultWaterChargePoisha &&
          other.occupancyStatus == this.occupancyStatus &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UnitsCompanion extends UpdateCompanion<Unit> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> name;
  final Value<String?> floorName;
  final Value<String> unitType;
  final Value<int?> bedrooms;
  final Value<int> defaultRentPoisha;
  final Value<int> defaultServiceChargePoisha;
  final Value<int> defaultGasChargePoisha;
  final Value<int> defaultWaterChargePoisha;
  final Value<String> occupancyStatus;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UnitsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.name = const Value.absent(),
    this.floorName = const Value.absent(),
    this.unitType = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.defaultRentPoisha = const Value.absent(),
    this.defaultServiceChargePoisha = const Value.absent(),
    this.defaultGasChargePoisha = const Value.absent(),
    this.defaultWaterChargePoisha = const Value.absent(),
    this.occupancyStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UnitsCompanion.insert({
    required String id,
    required String propertyId,
    required String name,
    this.floorName = const Value.absent(),
    this.unitType = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.defaultRentPoisha = const Value.absent(),
    this.defaultServiceChargePoisha = const Value.absent(),
    this.defaultGasChargePoisha = const Value.absent(),
    this.defaultWaterChargePoisha = const Value.absent(),
    this.occupancyStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       name = Value(name);
  static Insertable<Unit> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? name,
    Expression<String>? floorName,
    Expression<String>? unitType,
    Expression<int>? bedrooms,
    Expression<int>? defaultRentPoisha,
    Expression<int>? defaultServiceChargePoisha,
    Expression<int>? defaultGasChargePoisha,
    Expression<int>? defaultWaterChargePoisha,
    Expression<String>? occupancyStatus,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (name != null) 'name': name,
      if (floorName != null) 'floor_name': floorName,
      if (unitType != null) 'unit_type': unitType,
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (defaultRentPoisha != null) 'default_rent_poisha': defaultRentPoisha,
      if (defaultServiceChargePoisha != null)
        'default_service_charge_poisha': defaultServiceChargePoisha,
      if (defaultGasChargePoisha != null)
        'default_gas_charge_poisha': defaultGasChargePoisha,
      if (defaultWaterChargePoisha != null)
        'default_water_charge_poisha': defaultWaterChargePoisha,
      if (occupancyStatus != null) 'occupancy_status': occupancyStatus,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UnitsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String>? name,
    Value<String?>? floorName,
    Value<String>? unitType,
    Value<int?>? bedrooms,
    Value<int>? defaultRentPoisha,
    Value<int>? defaultServiceChargePoisha,
    Value<int>? defaultGasChargePoisha,
    Value<int>? defaultWaterChargePoisha,
    Value<String>? occupancyStatus,
    Value<String?>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UnitsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      floorName: floorName ?? this.floorName,
      unitType: unitType ?? this.unitType,
      bedrooms: bedrooms ?? this.bedrooms,
      defaultRentPoisha: defaultRentPoisha ?? this.defaultRentPoisha,
      defaultServiceChargePoisha:
          defaultServiceChargePoisha ?? this.defaultServiceChargePoisha,
      defaultGasChargePoisha:
          defaultGasChargePoisha ?? this.defaultGasChargePoisha,
      defaultWaterChargePoisha:
          defaultWaterChargePoisha ?? this.defaultWaterChargePoisha,
      occupancyStatus: occupancyStatus ?? this.occupancyStatus,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (floorName.present) {
      map['floor_name'] = Variable<String>(floorName.value);
    }
    if (unitType.present) {
      map['unit_type'] = Variable<String>(unitType.value);
    }
    if (bedrooms.present) {
      map['bedrooms'] = Variable<int>(bedrooms.value);
    }
    if (defaultRentPoisha.present) {
      map['default_rent_poisha'] = Variable<int>(defaultRentPoisha.value);
    }
    if (defaultServiceChargePoisha.present) {
      map['default_service_charge_poisha'] = Variable<int>(
        defaultServiceChargePoisha.value,
      );
    }
    if (defaultGasChargePoisha.present) {
      map['default_gas_charge_poisha'] = Variable<int>(
        defaultGasChargePoisha.value,
      );
    }
    if (defaultWaterChargePoisha.present) {
      map['default_water_charge_poisha'] = Variable<int>(
        defaultWaterChargePoisha.value,
      );
    }
    if (occupancyStatus.present) {
      map['occupancy_status'] = Variable<String>(occupancyStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UnitsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('name: $name, ')
          ..write('floorName: $floorName, ')
          ..write('unitType: $unitType, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('defaultRentPoisha: $defaultRentPoisha, ')
          ..write('defaultServiceChargePoisha: $defaultServiceChargePoisha, ')
          ..write('defaultGasChargePoisha: $defaultGasChargePoisha, ')
          ..write('defaultWaterChargePoisha: $defaultWaterChargePoisha, ')
          ..write('occupancyStatus: $occupancyStatus, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TenantsTable extends Tenants with TableInfo<$TenantsTable, Tenant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _banglaNameMeta = const VerificationMeta(
    'banglaName',
  );
  @override
  late final GeneratedColumn<String> banglaName = GeneratedColumn<String>(
    'bangla_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alternativePhoneMeta = const VerificationMeta(
    'alternativePhone',
  );
  @override
  late final GeneratedColumn<String> alternativePhone = GeneratedColumn<String>(
    'alternative_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nidNumberMeta = const VerificationMeta(
    'nidNumber',
  );
  @override
  late final GeneratedColumn<String> nidNumber = GeneratedColumn<String>(
    'nid_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _permanentAddressMeta = const VerificationMeta(
    'permanentAddress',
  );
  @override
  late final GeneratedColumn<String> permanentAddress = GeneratedColumn<String>(
    'permanent_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyContactNameMeta =
      const VerificationMeta('emergencyContactName');
  @override
  late final GeneratedColumn<String> emergencyContactName =
      GeneratedColumn<String>(
        'emergency_contact_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emergencyContactPhoneMeta =
      const VerificationMeta('emergencyContactPhone');
  @override
  late final GeneratedColumn<String> emergencyContactPhone =
      GeneratedColumn<String>(
        'emergency_contact_phone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    banglaName,
    phone,
    alternativePhone,
    email,
    nidNumber,
    permanentAddress,
    emergencyContactName,
    emergencyContactPhone,
    photoPath,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenants';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tenant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('bangla_name')) {
      context.handle(
        _banglaNameMeta,
        banglaName.isAcceptableOrUnknown(data['bangla_name']!, _banglaNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('alternative_phone')) {
      context.handle(
        _alternativePhoneMeta,
        alternativePhone.isAcceptableOrUnknown(
          data['alternative_phone']!,
          _alternativePhoneMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('nid_number')) {
      context.handle(
        _nidNumberMeta,
        nidNumber.isAcceptableOrUnknown(data['nid_number']!, _nidNumberMeta),
      );
    }
    if (data.containsKey('permanent_address')) {
      context.handle(
        _permanentAddressMeta,
        permanentAddress.isAcceptableOrUnknown(
          data['permanent_address']!,
          _permanentAddressMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_name')) {
      context.handle(
        _emergencyContactNameMeta,
        emergencyContactName.isAcceptableOrUnknown(
          data['emergency_contact_name']!,
          _emergencyContactNameMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_phone')) {
      context.handle(
        _emergencyContactPhoneMeta,
        emergencyContactPhone.isAcceptableOrUnknown(
          data['emergency_contact_phone']!,
          _emergencyContactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tenant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tenant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      banglaName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bangla_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      alternativePhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternative_phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      nidNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nid_number'],
      ),
      permanentAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}permanent_address'],
      ),
      emergencyContactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_name'],
      ),
      emergencyContactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_phone'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TenantsTable createAlias(String alias) {
    return $TenantsTable(attachedDatabase, alias);
  }
}

class Tenant extends DataClass implements Insertable<Tenant> {
  final String id;
  final String fullName;
  final String? banglaName;
  final String phone;
  final String? alternativePhone;
  final String? email;
  final String? nidNumber;
  final String? permanentAddress;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? photoPath;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Tenant({
    required this.id,
    required this.fullName,
    this.banglaName,
    required this.phone,
    this.alternativePhone,
    this.email,
    this.nidNumber,
    this.permanentAddress,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.photoPath,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || banglaName != null) {
      map['bangla_name'] = Variable<String>(banglaName);
    }
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || alternativePhone != null) {
      map['alternative_phone'] = Variable<String>(alternativePhone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || nidNumber != null) {
      map['nid_number'] = Variable<String>(nidNumber);
    }
    if (!nullToAbsent || permanentAddress != null) {
      map['permanent_address'] = Variable<String>(permanentAddress);
    }
    if (!nullToAbsent || emergencyContactName != null) {
      map['emergency_contact_name'] = Variable<String>(emergencyContactName);
    }
    if (!nullToAbsent || emergencyContactPhone != null) {
      map['emergency_contact_phone'] = Variable<String>(emergencyContactPhone);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenantsCompanion toCompanion(bool nullToAbsent) {
    return TenantsCompanion(
      id: Value(id),
      fullName: Value(fullName),
      banglaName: banglaName == null && nullToAbsent
          ? const Value.absent()
          : Value(banglaName),
      phone: Value(phone),
      alternativePhone: alternativePhone == null && nullToAbsent
          ? const Value.absent()
          : Value(alternativePhone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      nidNumber: nidNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(nidNumber),
      permanentAddress: permanentAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(permanentAddress),
      emergencyContactName: emergencyContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactName),
      emergencyContactPhone: emergencyContactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactPhone),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Tenant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tenant(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      banglaName: serializer.fromJson<String?>(json['banglaName']),
      phone: serializer.fromJson<String>(json['phone']),
      alternativePhone: serializer.fromJson<String?>(json['alternativePhone']),
      email: serializer.fromJson<String?>(json['email']),
      nidNumber: serializer.fromJson<String?>(json['nidNumber']),
      permanentAddress: serializer.fromJson<String?>(json['permanentAddress']),
      emergencyContactName: serializer.fromJson<String?>(
        json['emergencyContactName'],
      ),
      emergencyContactPhone: serializer.fromJson<String?>(
        json['emergencyContactPhone'],
      ),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'banglaName': serializer.toJson<String?>(banglaName),
      'phone': serializer.toJson<String>(phone),
      'alternativePhone': serializer.toJson<String?>(alternativePhone),
      'email': serializer.toJson<String?>(email),
      'nidNumber': serializer.toJson<String?>(nidNumber),
      'permanentAddress': serializer.toJson<String?>(permanentAddress),
      'emergencyContactName': serializer.toJson<String?>(emergencyContactName),
      'emergencyContactPhone': serializer.toJson<String?>(
        emergencyContactPhone,
      ),
      'photoPath': serializer.toJson<String?>(photoPath),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Tenant copyWith({
    String? id,
    String? fullName,
    Value<String?> banglaName = const Value.absent(),
    String? phone,
    Value<String?> alternativePhone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> nidNumber = const Value.absent(),
    Value<String?> permanentAddress = const Value.absent(),
    Value<String?> emergencyContactName = const Value.absent(),
    Value<String?> emergencyContactPhone = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Tenant(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    banglaName: banglaName.present ? banglaName.value : this.banglaName,
    phone: phone ?? this.phone,
    alternativePhone: alternativePhone.present
        ? alternativePhone.value
        : this.alternativePhone,
    email: email.present ? email.value : this.email,
    nidNumber: nidNumber.present ? nidNumber.value : this.nidNumber,
    permanentAddress: permanentAddress.present
        ? permanentAddress.value
        : this.permanentAddress,
    emergencyContactName: emergencyContactName.present
        ? emergencyContactName.value
        : this.emergencyContactName,
    emergencyContactPhone: emergencyContactPhone.present
        ? emergencyContactPhone.value
        : this.emergencyContactPhone,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Tenant copyWithCompanion(TenantsCompanion data) {
    return Tenant(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      banglaName: data.banglaName.present
          ? data.banglaName.value
          : this.banglaName,
      phone: data.phone.present ? data.phone.value : this.phone,
      alternativePhone: data.alternativePhone.present
          ? data.alternativePhone.value
          : this.alternativePhone,
      email: data.email.present ? data.email.value : this.email,
      nidNumber: data.nidNumber.present ? data.nidNumber.value : this.nidNumber,
      permanentAddress: data.permanentAddress.present
          ? data.permanentAddress.value
          : this.permanentAddress,
      emergencyContactName: data.emergencyContactName.present
          ? data.emergencyContactName.value
          : this.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone.present
          ? data.emergencyContactPhone.value
          : this.emergencyContactPhone,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tenant(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('banglaName: $banglaName, ')
          ..write('phone: $phone, ')
          ..write('alternativePhone: $alternativePhone, ')
          ..write('email: $email, ')
          ..write('nidNumber: $nidNumber, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('photoPath: $photoPath, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    banglaName,
    phone,
    alternativePhone,
    email,
    nidNumber,
    permanentAddress,
    emergencyContactName,
    emergencyContactPhone,
    photoPath,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tenant &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.banglaName == this.banglaName &&
          other.phone == this.phone &&
          other.alternativePhone == this.alternativePhone &&
          other.email == this.email &&
          other.nidNumber == this.nidNumber &&
          other.permanentAddress == this.permanentAddress &&
          other.emergencyContactName == this.emergencyContactName &&
          other.emergencyContactPhone == this.emergencyContactPhone &&
          other.photoPath == this.photoPath &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TenantsCompanion extends UpdateCompanion<Tenant> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String?> banglaName;
  final Value<String> phone;
  final Value<String?> alternativePhone;
  final Value<String?> email;
  final Value<String?> nidNumber;
  final Value<String?> permanentAddress;
  final Value<String?> emergencyContactName;
  final Value<String?> emergencyContactPhone;
  final Value<String?> photoPath;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TenantsCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.banglaName = const Value.absent(),
    this.phone = const Value.absent(),
    this.alternativePhone = const Value.absent(),
    this.email = const Value.absent(),
    this.nidNumber = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TenantsCompanion.insert({
    required String id,
    required String fullName,
    this.banglaName = const Value.absent(),
    required String phone,
    this.alternativePhone = const Value.absent(),
    this.email = const Value.absent(),
    this.nidNumber = const Value.absent(),
    this.permanentAddress = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       phone = Value(phone);
  static Insertable<Tenant> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? banglaName,
    Expression<String>? phone,
    Expression<String>? alternativePhone,
    Expression<String>? email,
    Expression<String>? nidNumber,
    Expression<String>? permanentAddress,
    Expression<String>? emergencyContactName,
    Expression<String>? emergencyContactPhone,
    Expression<String>? photoPath,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (banglaName != null) 'bangla_name': banglaName,
      if (phone != null) 'phone': phone,
      if (alternativePhone != null) 'alternative_phone': alternativePhone,
      if (email != null) 'email': email,
      if (nidNumber != null) 'nid_number': nidNumber,
      if (permanentAddress != null) 'permanent_address': permanentAddress,
      if (emergencyContactName != null)
        'emergency_contact_name': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergency_contact_phone': emergencyContactPhone,
      if (photoPath != null) 'photo_path': photoPath,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TenantsCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String?>? banglaName,
    Value<String>? phone,
    Value<String?>? alternativePhone,
    Value<String?>? email,
    Value<String?>? nidNumber,
    Value<String?>? permanentAddress,
    Value<String?>? emergencyContactName,
    Value<String?>? emergencyContactPhone,
    Value<String?>? photoPath,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TenantsCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      banglaName: banglaName ?? this.banglaName,
      phone: phone ?? this.phone,
      alternativePhone: alternativePhone ?? this.alternativePhone,
      email: email ?? this.email,
      nidNumber: nidNumber ?? this.nidNumber,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      photoPath: photoPath ?? this.photoPath,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (banglaName.present) {
      map['bangla_name'] = Variable<String>(banglaName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (alternativePhone.present) {
      map['alternative_phone'] = Variable<String>(alternativePhone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (nidNumber.present) {
      map['nid_number'] = Variable<String>(nidNumber.value);
    }
    if (permanentAddress.present) {
      map['permanent_address'] = Variable<String>(permanentAddress.value);
    }
    if (emergencyContactName.present) {
      map['emergency_contact_name'] = Variable<String>(
        emergencyContactName.value,
      );
    }
    if (emergencyContactPhone.present) {
      map['emergency_contact_phone'] = Variable<String>(
        emergencyContactPhone.value,
      );
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenantsCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('banglaName: $banglaName, ')
          ..write('phone: $phone, ')
          ..write('alternativePhone: $alternativePhone, ')
          ..write('email: $email, ')
          ..write('nidNumber: $nidNumber, ')
          ..write('permanentAddress: $permanentAddress, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('photoPath: $photoPath, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TenanciesTable extends Tenancies
    with TableInfo<$TenanciesTable, Tenancy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TenanciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenants (id)',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES units (id)',
    ),
  );
  static const VerificationMeta _moveInDateMeta = const VerificationMeta(
    'moveInDate',
  );
  @override
  late final GeneratedColumn<DateTime> moveInDate = GeneratedColumn<DateTime>(
    'move_in_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedMoveOutDateMeta =
      const VerificationMeta('expectedMoveOutDate');
  @override
  late final GeneratedColumn<DateTime> expectedMoveOutDate =
      GeneratedColumn<DateTime>(
        'expected_move_out_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _actualMoveOutDateMeta = const VerificationMeta(
    'actualMoveOutDate',
  );
  @override
  late final GeneratedColumn<DateTime> actualMoveOutDate =
      GeneratedColumn<DateTime>(
        'actual_move_out_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _agreedRentPoishaMeta = const VerificationMeta(
    'agreedRentPoisha',
  );
  @override
  late final GeneratedColumn<int> agreedRentPoisha = GeneratedColumn<int>(
    'agreed_rent_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _billingDayMeta = const VerificationMeta(
    'billingDay',
  );
  @override
  late final GeneratedColumn<int> billingDay = GeneratedColumn<int>(
    'billing_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _securityDepositTargetPoishaMeta =
      const VerificationMeta('securityDepositTargetPoisha');
  @override
  late final GeneratedColumn<int> securityDepositTargetPoisha =
      GeneratedColumn<int>(
        'security_deposit_target_poisha',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _advanceRentPoishaMeta = const VerificationMeta(
    'advanceRentPoisha',
  );
  @override
  late final GeneratedColumn<int> advanceRentPoisha = GeneratedColumn<int>(
    'advance_rent_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _agreementNotesMeta = const VerificationMeta(
    'agreementNotes',
  );
  @override
  late final GeneratedColumn<String> agreementNotes = GeneratedColumn<String>(
    'agreement_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    unitId,
    moveInDate,
    expectedMoveOutDate,
    actualMoveOutDate,
    agreedRentPoisha,
    billingDay,
    securityDepositTargetPoisha,
    advanceRentPoisha,
    agreementNotes,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tenancies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tenancy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('move_in_date')) {
      context.handle(
        _moveInDateMeta,
        moveInDate.isAcceptableOrUnknown(
          data['move_in_date']!,
          _moveInDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_moveInDateMeta);
    }
    if (data.containsKey('expected_move_out_date')) {
      context.handle(
        _expectedMoveOutDateMeta,
        expectedMoveOutDate.isAcceptableOrUnknown(
          data['expected_move_out_date']!,
          _expectedMoveOutDateMeta,
        ),
      );
    }
    if (data.containsKey('actual_move_out_date')) {
      context.handle(
        _actualMoveOutDateMeta,
        actualMoveOutDate.isAcceptableOrUnknown(
          data['actual_move_out_date']!,
          _actualMoveOutDateMeta,
        ),
      );
    }
    if (data.containsKey('agreed_rent_poisha')) {
      context.handle(
        _agreedRentPoishaMeta,
        agreedRentPoisha.isAcceptableOrUnknown(
          data['agreed_rent_poisha']!,
          _agreedRentPoishaMeta,
        ),
      );
    }
    if (data.containsKey('billing_day')) {
      context.handle(
        _billingDayMeta,
        billingDay.isAcceptableOrUnknown(data['billing_day']!, _billingDayMeta),
      );
    }
    if (data.containsKey('security_deposit_target_poisha')) {
      context.handle(
        _securityDepositTargetPoishaMeta,
        securityDepositTargetPoisha.isAcceptableOrUnknown(
          data['security_deposit_target_poisha']!,
          _securityDepositTargetPoishaMeta,
        ),
      );
    }
    if (data.containsKey('advance_rent_poisha')) {
      context.handle(
        _advanceRentPoishaMeta,
        advanceRentPoisha.isAcceptableOrUnknown(
          data['advance_rent_poisha']!,
          _advanceRentPoishaMeta,
        ),
      );
    }
    if (data.containsKey('agreement_notes')) {
      context.handle(
        _agreementNotesMeta,
        agreementNotes.isAcceptableOrUnknown(
          data['agreement_notes']!,
          _agreementNotesMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tenancy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tenancy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      moveInDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}move_in_date'],
      )!,
      expectedMoveOutDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_move_out_date'],
      ),
      actualMoveOutDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actual_move_out_date'],
      ),
      agreedRentPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agreed_rent_poisha'],
      )!,
      billingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_day'],
      )!,
      securityDepositTargetPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}security_deposit_target_poisha'],
      )!,
      advanceRentPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}advance_rent_poisha'],
      )!,
      agreementNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agreement_notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TenanciesTable createAlias(String alias) {
    return $TenanciesTable(attachedDatabase, alias);
  }
}

class Tenancy extends DataClass implements Insertable<Tenancy> {
  final String id;
  final String tenantId;
  final String unitId;
  final DateTime moveInDate;
  final DateTime? expectedMoveOutDate;
  final DateTime? actualMoveOutDate;
  final int agreedRentPoisha;
  final int billingDay;
  final int securityDepositTargetPoisha;
  final int advanceRentPoisha;
  final String? agreementNotes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Tenancy({
    required this.id,
    required this.tenantId,
    required this.unitId,
    required this.moveInDate,
    this.expectedMoveOutDate,
    this.actualMoveOutDate,
    required this.agreedRentPoisha,
    required this.billingDay,
    required this.securityDepositTargetPoisha,
    required this.advanceRentPoisha,
    this.agreementNotes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['unit_id'] = Variable<String>(unitId);
    map['move_in_date'] = Variable<DateTime>(moveInDate);
    if (!nullToAbsent || expectedMoveOutDate != null) {
      map['expected_move_out_date'] = Variable<DateTime>(expectedMoveOutDate);
    }
    if (!nullToAbsent || actualMoveOutDate != null) {
      map['actual_move_out_date'] = Variable<DateTime>(actualMoveOutDate);
    }
    map['agreed_rent_poisha'] = Variable<int>(agreedRentPoisha);
    map['billing_day'] = Variable<int>(billingDay);
    map['security_deposit_target_poisha'] = Variable<int>(
      securityDepositTargetPoisha,
    );
    map['advance_rent_poisha'] = Variable<int>(advanceRentPoisha);
    if (!nullToAbsent || agreementNotes != null) {
      map['agreement_notes'] = Variable<String>(agreementNotes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TenanciesCompanion toCompanion(bool nullToAbsent) {
    return TenanciesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      unitId: Value(unitId),
      moveInDate: Value(moveInDate),
      expectedMoveOutDate: expectedMoveOutDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedMoveOutDate),
      actualMoveOutDate: actualMoveOutDate == null && nullToAbsent
          ? const Value.absent()
          : Value(actualMoveOutDate),
      agreedRentPoisha: Value(agreedRentPoisha),
      billingDay: Value(billingDay),
      securityDepositTargetPoisha: Value(securityDepositTargetPoisha),
      advanceRentPoisha: Value(advanceRentPoisha),
      agreementNotes: agreementNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(agreementNotes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Tenancy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tenancy(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      moveInDate: serializer.fromJson<DateTime>(json['moveInDate']),
      expectedMoveOutDate: serializer.fromJson<DateTime?>(
        json['expectedMoveOutDate'],
      ),
      actualMoveOutDate: serializer.fromJson<DateTime?>(
        json['actualMoveOutDate'],
      ),
      agreedRentPoisha: serializer.fromJson<int>(json['agreedRentPoisha']),
      billingDay: serializer.fromJson<int>(json['billingDay']),
      securityDepositTargetPoisha: serializer.fromJson<int>(
        json['securityDepositTargetPoisha'],
      ),
      advanceRentPoisha: serializer.fromJson<int>(json['advanceRentPoisha']),
      agreementNotes: serializer.fromJson<String?>(json['agreementNotes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'unitId': serializer.toJson<String>(unitId),
      'moveInDate': serializer.toJson<DateTime>(moveInDate),
      'expectedMoveOutDate': serializer.toJson<DateTime?>(expectedMoveOutDate),
      'actualMoveOutDate': serializer.toJson<DateTime?>(actualMoveOutDate),
      'agreedRentPoisha': serializer.toJson<int>(agreedRentPoisha),
      'billingDay': serializer.toJson<int>(billingDay),
      'securityDepositTargetPoisha': serializer.toJson<int>(
        securityDepositTargetPoisha,
      ),
      'advanceRentPoisha': serializer.toJson<int>(advanceRentPoisha),
      'agreementNotes': serializer.toJson<String?>(agreementNotes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Tenancy copyWith({
    String? id,
    String? tenantId,
    String? unitId,
    DateTime? moveInDate,
    Value<DateTime?> expectedMoveOutDate = const Value.absent(),
    Value<DateTime?> actualMoveOutDate = const Value.absent(),
    int? agreedRentPoisha,
    int? billingDay,
    int? securityDepositTargetPoisha,
    int? advanceRentPoisha,
    Value<String?> agreementNotes = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Tenancy(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    unitId: unitId ?? this.unitId,
    moveInDate: moveInDate ?? this.moveInDate,
    expectedMoveOutDate: expectedMoveOutDate.present
        ? expectedMoveOutDate.value
        : this.expectedMoveOutDate,
    actualMoveOutDate: actualMoveOutDate.present
        ? actualMoveOutDate.value
        : this.actualMoveOutDate,
    agreedRentPoisha: agreedRentPoisha ?? this.agreedRentPoisha,
    billingDay: billingDay ?? this.billingDay,
    securityDepositTargetPoisha:
        securityDepositTargetPoisha ?? this.securityDepositTargetPoisha,
    advanceRentPoisha: advanceRentPoisha ?? this.advanceRentPoisha,
    agreementNotes: agreementNotes.present
        ? agreementNotes.value
        : this.agreementNotes,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Tenancy copyWithCompanion(TenanciesCompanion data) {
    return Tenancy(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      moveInDate: data.moveInDate.present
          ? data.moveInDate.value
          : this.moveInDate,
      expectedMoveOutDate: data.expectedMoveOutDate.present
          ? data.expectedMoveOutDate.value
          : this.expectedMoveOutDate,
      actualMoveOutDate: data.actualMoveOutDate.present
          ? data.actualMoveOutDate.value
          : this.actualMoveOutDate,
      agreedRentPoisha: data.agreedRentPoisha.present
          ? data.agreedRentPoisha.value
          : this.agreedRentPoisha,
      billingDay: data.billingDay.present
          ? data.billingDay.value
          : this.billingDay,
      securityDepositTargetPoisha: data.securityDepositTargetPoisha.present
          ? data.securityDepositTargetPoisha.value
          : this.securityDepositTargetPoisha,
      advanceRentPoisha: data.advanceRentPoisha.present
          ? data.advanceRentPoisha.value
          : this.advanceRentPoisha,
      agreementNotes: data.agreementNotes.present
          ? data.agreementNotes.value
          : this.agreementNotes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tenancy(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('unitId: $unitId, ')
          ..write('moveInDate: $moveInDate, ')
          ..write('expectedMoveOutDate: $expectedMoveOutDate, ')
          ..write('actualMoveOutDate: $actualMoveOutDate, ')
          ..write('agreedRentPoisha: $agreedRentPoisha, ')
          ..write('billingDay: $billingDay, ')
          ..write('securityDepositTargetPoisha: $securityDepositTargetPoisha, ')
          ..write('advanceRentPoisha: $advanceRentPoisha, ')
          ..write('agreementNotes: $agreementNotes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    unitId,
    moveInDate,
    expectedMoveOutDate,
    actualMoveOutDate,
    agreedRentPoisha,
    billingDay,
    securityDepositTargetPoisha,
    advanceRentPoisha,
    agreementNotes,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tenancy &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.unitId == this.unitId &&
          other.moveInDate == this.moveInDate &&
          other.expectedMoveOutDate == this.expectedMoveOutDate &&
          other.actualMoveOutDate == this.actualMoveOutDate &&
          other.agreedRentPoisha == this.agreedRentPoisha &&
          other.billingDay == this.billingDay &&
          other.securityDepositTargetPoisha ==
              this.securityDepositTargetPoisha &&
          other.advanceRentPoisha == this.advanceRentPoisha &&
          other.agreementNotes == this.agreementNotes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TenanciesCompanion extends UpdateCompanion<Tenancy> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> unitId;
  final Value<DateTime> moveInDate;
  final Value<DateTime?> expectedMoveOutDate;
  final Value<DateTime?> actualMoveOutDate;
  final Value<int> agreedRentPoisha;
  final Value<int> billingDay;
  final Value<int> securityDepositTargetPoisha;
  final Value<int> advanceRentPoisha;
  final Value<String?> agreementNotes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TenanciesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.moveInDate = const Value.absent(),
    this.expectedMoveOutDate = const Value.absent(),
    this.actualMoveOutDate = const Value.absent(),
    this.agreedRentPoisha = const Value.absent(),
    this.billingDay = const Value.absent(),
    this.securityDepositTargetPoisha = const Value.absent(),
    this.advanceRentPoisha = const Value.absent(),
    this.agreementNotes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TenanciesCompanion.insert({
    required String id,
    required String tenantId,
    required String unitId,
    required DateTime moveInDate,
    this.expectedMoveOutDate = const Value.absent(),
    this.actualMoveOutDate = const Value.absent(),
    this.agreedRentPoisha = const Value.absent(),
    this.billingDay = const Value.absent(),
    this.securityDepositTargetPoisha = const Value.absent(),
    this.advanceRentPoisha = const Value.absent(),
    this.agreementNotes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       unitId = Value(unitId),
       moveInDate = Value(moveInDate);
  static Insertable<Tenancy> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? unitId,
    Expression<DateTime>? moveInDate,
    Expression<DateTime>? expectedMoveOutDate,
    Expression<DateTime>? actualMoveOutDate,
    Expression<int>? agreedRentPoisha,
    Expression<int>? billingDay,
    Expression<int>? securityDepositTargetPoisha,
    Expression<int>? advanceRentPoisha,
    Expression<String>? agreementNotes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (unitId != null) 'unit_id': unitId,
      if (moveInDate != null) 'move_in_date': moveInDate,
      if (expectedMoveOutDate != null)
        'expected_move_out_date': expectedMoveOutDate,
      if (actualMoveOutDate != null) 'actual_move_out_date': actualMoveOutDate,
      if (agreedRentPoisha != null) 'agreed_rent_poisha': agreedRentPoisha,
      if (billingDay != null) 'billing_day': billingDay,
      if (securityDepositTargetPoisha != null)
        'security_deposit_target_poisha': securityDepositTargetPoisha,
      if (advanceRentPoisha != null) 'advance_rent_poisha': advanceRentPoisha,
      if (agreementNotes != null) 'agreement_notes': agreementNotes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TenanciesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? unitId,
    Value<DateTime>? moveInDate,
    Value<DateTime?>? expectedMoveOutDate,
    Value<DateTime?>? actualMoveOutDate,
    Value<int>? agreedRentPoisha,
    Value<int>? billingDay,
    Value<int>? securityDepositTargetPoisha,
    Value<int>? advanceRentPoisha,
    Value<String?>? agreementNotes,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TenanciesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      unitId: unitId ?? this.unitId,
      moveInDate: moveInDate ?? this.moveInDate,
      expectedMoveOutDate: expectedMoveOutDate ?? this.expectedMoveOutDate,
      actualMoveOutDate: actualMoveOutDate ?? this.actualMoveOutDate,
      agreedRentPoisha: agreedRentPoisha ?? this.agreedRentPoisha,
      billingDay: billingDay ?? this.billingDay,
      securityDepositTargetPoisha:
          securityDepositTargetPoisha ?? this.securityDepositTargetPoisha,
      advanceRentPoisha: advanceRentPoisha ?? this.advanceRentPoisha,
      agreementNotes: agreementNotes ?? this.agreementNotes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (moveInDate.present) {
      map['move_in_date'] = Variable<DateTime>(moveInDate.value);
    }
    if (expectedMoveOutDate.present) {
      map['expected_move_out_date'] = Variable<DateTime>(
        expectedMoveOutDate.value,
      );
    }
    if (actualMoveOutDate.present) {
      map['actual_move_out_date'] = Variable<DateTime>(actualMoveOutDate.value);
    }
    if (agreedRentPoisha.present) {
      map['agreed_rent_poisha'] = Variable<int>(agreedRentPoisha.value);
    }
    if (billingDay.present) {
      map['billing_day'] = Variable<int>(billingDay.value);
    }
    if (securityDepositTargetPoisha.present) {
      map['security_deposit_target_poisha'] = Variable<int>(
        securityDepositTargetPoisha.value,
      );
    }
    if (advanceRentPoisha.present) {
      map['advance_rent_poisha'] = Variable<int>(advanceRentPoisha.value);
    }
    if (agreementNotes.present) {
      map['agreement_notes'] = Variable<String>(agreementNotes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TenanciesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('unitId: $unitId, ')
          ..write('moveInDate: $moveInDate, ')
          ..write('expectedMoveOutDate: $expectedMoveOutDate, ')
          ..write('actualMoveOutDate: $actualMoveOutDate, ')
          ..write('agreedRentPoisha: $agreedRentPoisha, ')
          ..write('billingDay: $billingDay, ')
          ..write('securityDepositTargetPoisha: $securityDepositTargetPoisha, ')
          ..write('advanceRentPoisha: $advanceRentPoisha, ')
          ..write('agreementNotes: $agreementNotes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringChargeRulesTable extends RecurringChargeRules
    with TableInfo<$RecurringChargeRulesTable, RecurringChargeRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringChargeRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenancyIdMeta = const VerificationMeta(
    'tenancyId',
  );
  @override
  late final GeneratedColumn<String> tenancyId = GeneratedColumn<String>(
    'tenancy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenancies (id)',
    ),
  );
  static const VerificationMeta _chargeTypeMeta = const VerificationMeta(
    'chargeType',
  );
  @override
  late final GeneratedColumn<String> chargeType = GeneratedColumn<String>(
    'charge_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calculationMethodMeta = const VerificationMeta(
    'calculationMethod',
  );
  @override
  late final GeneratedColumn<String> calculationMethod =
      GeneratedColumn<String>(
        'calculation_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fixedAmountPoishaMeta = const VerificationMeta(
    'fixedAmountPoisha',
  );
  @override
  late final GeneratedColumn<int> fixedAmountPoisha = GeneratedColumn<int>(
    'fixed_amount_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ratePoishaMeta = const VerificationMeta(
    'ratePoisha',
  );
  @override
  late final GeneratedColumn<int> ratePoisha = GeneratedColumn<int>(
    'rate_poisha',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _effectiveToMeta = const VerificationMeta(
    'effectiveTo',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveTo = GeneratedColumn<DateTime>(
    'effective_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenancyId,
    chargeType,
    calculationMethod,
    fixedAmountPoisha,
    ratePoisha,
    effectiveFrom,
    effectiveTo,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_charge_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringChargeRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenancy_id')) {
      context.handle(
        _tenancyIdMeta,
        tenancyId.isAcceptableOrUnknown(data['tenancy_id']!, _tenancyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenancyIdMeta);
    }
    if (data.containsKey('charge_type')) {
      context.handle(
        _chargeTypeMeta,
        chargeType.isAcceptableOrUnknown(data['charge_type']!, _chargeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_chargeTypeMeta);
    }
    if (data.containsKey('calculation_method')) {
      context.handle(
        _calculationMethodMeta,
        calculationMethod.isAcceptableOrUnknown(
          data['calculation_method']!,
          _calculationMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculationMethodMeta);
    }
    if (data.containsKey('fixed_amount_poisha')) {
      context.handle(
        _fixedAmountPoishaMeta,
        fixedAmountPoisha.isAcceptableOrUnknown(
          data['fixed_amount_poisha']!,
          _fixedAmountPoishaMeta,
        ),
      );
    }
    if (data.containsKey('rate_poisha')) {
      context.handle(
        _ratePoishaMeta,
        ratePoisha.isAcceptableOrUnknown(data['rate_poisha']!, _ratePoishaMeta),
      );
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('effective_to')) {
      context.handle(
        _effectiveToMeta,
        effectiveTo.isAcceptableOrUnknown(
          data['effective_to']!,
          _effectiveToMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringChargeRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringChargeRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenancyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenancy_id'],
      )!,
      chargeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}charge_type'],
      )!,
      calculationMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculation_method'],
      )!,
      fixedAmountPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixed_amount_poisha'],
      )!,
      ratePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_poisha'],
      ),
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
      effectiveTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_to'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecurringChargeRulesTable createAlias(String alias) {
    return $RecurringChargeRulesTable(attachedDatabase, alias);
  }
}

class RecurringChargeRule extends DataClass
    implements Insertable<RecurringChargeRule> {
  final String id;
  final String tenancyId;
  final String chargeType;
  final String calculationMethod;
  final int fixedAmountPoisha;
  final int? ratePoisha;
  final DateTime effectiveFrom;
  final DateTime? effectiveTo;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecurringChargeRule({
    required this.id,
    required this.tenancyId,
    required this.chargeType,
    required this.calculationMethod,
    required this.fixedAmountPoisha,
    this.ratePoisha,
    required this.effectiveFrom,
    this.effectiveTo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenancy_id'] = Variable<String>(tenancyId);
    map['charge_type'] = Variable<String>(chargeType);
    map['calculation_method'] = Variable<String>(calculationMethod);
    map['fixed_amount_poisha'] = Variable<int>(fixedAmountPoisha);
    if (!nullToAbsent || ratePoisha != null) {
      map['rate_poisha'] = Variable<int>(ratePoisha);
    }
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    if (!nullToAbsent || effectiveTo != null) {
      map['effective_to'] = Variable<DateTime>(effectiveTo);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecurringChargeRulesCompanion toCompanion(bool nullToAbsent) {
    return RecurringChargeRulesCompanion(
      id: Value(id),
      tenancyId: Value(tenancyId),
      chargeType: Value(chargeType),
      calculationMethod: Value(calculationMethod),
      fixedAmountPoisha: Value(fixedAmountPoisha),
      ratePoisha: ratePoisha == null && nullToAbsent
          ? const Value.absent()
          : Value(ratePoisha),
      effectiveFrom: Value(effectiveFrom),
      effectiveTo: effectiveTo == null && nullToAbsent
          ? const Value.absent()
          : Value(effectiveTo),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecurringChargeRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringChargeRule(
      id: serializer.fromJson<String>(json['id']),
      tenancyId: serializer.fromJson<String>(json['tenancyId']),
      chargeType: serializer.fromJson<String>(json['chargeType']),
      calculationMethod: serializer.fromJson<String>(json['calculationMethod']),
      fixedAmountPoisha: serializer.fromJson<int>(json['fixedAmountPoisha']),
      ratePoisha: serializer.fromJson<int?>(json['ratePoisha']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      effectiveTo: serializer.fromJson<DateTime?>(json['effectiveTo']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenancyId': serializer.toJson<String>(tenancyId),
      'chargeType': serializer.toJson<String>(chargeType),
      'calculationMethod': serializer.toJson<String>(calculationMethod),
      'fixedAmountPoisha': serializer.toJson<int>(fixedAmountPoisha),
      'ratePoisha': serializer.toJson<int?>(ratePoisha),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'effectiveTo': serializer.toJson<DateTime?>(effectiveTo),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecurringChargeRule copyWith({
    String? id,
    String? tenancyId,
    String? chargeType,
    String? calculationMethod,
    int? fixedAmountPoisha,
    Value<int?> ratePoisha = const Value.absent(),
    DateTime? effectiveFrom,
    Value<DateTime?> effectiveTo = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RecurringChargeRule(
    id: id ?? this.id,
    tenancyId: tenancyId ?? this.tenancyId,
    chargeType: chargeType ?? this.chargeType,
    calculationMethod: calculationMethod ?? this.calculationMethod,
    fixedAmountPoisha: fixedAmountPoisha ?? this.fixedAmountPoisha,
    ratePoisha: ratePoisha.present ? ratePoisha.value : this.ratePoisha,
    effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    effectiveTo: effectiveTo.present ? effectiveTo.value : this.effectiveTo,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecurringChargeRule copyWithCompanion(RecurringChargeRulesCompanion data) {
    return RecurringChargeRule(
      id: data.id.present ? data.id.value : this.id,
      tenancyId: data.tenancyId.present ? data.tenancyId.value : this.tenancyId,
      chargeType: data.chargeType.present
          ? data.chargeType.value
          : this.chargeType,
      calculationMethod: data.calculationMethod.present
          ? data.calculationMethod.value
          : this.calculationMethod,
      fixedAmountPoisha: data.fixedAmountPoisha.present
          ? data.fixedAmountPoisha.value
          : this.fixedAmountPoisha,
      ratePoisha: data.ratePoisha.present
          ? data.ratePoisha.value
          : this.ratePoisha,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      effectiveTo: data.effectiveTo.present
          ? data.effectiveTo.value
          : this.effectiveTo,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringChargeRule(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('chargeType: $chargeType, ')
          ..write('calculationMethod: $calculationMethod, ')
          ..write('fixedAmountPoisha: $fixedAmountPoisha, ')
          ..write('ratePoisha: $ratePoisha, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenancyId,
    chargeType,
    calculationMethod,
    fixedAmountPoisha,
    ratePoisha,
    effectiveFrom,
    effectiveTo,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringChargeRule &&
          other.id == this.id &&
          other.tenancyId == this.tenancyId &&
          other.chargeType == this.chargeType &&
          other.calculationMethod == this.calculationMethod &&
          other.fixedAmountPoisha == this.fixedAmountPoisha &&
          other.ratePoisha == this.ratePoisha &&
          other.effectiveFrom == this.effectiveFrom &&
          other.effectiveTo == this.effectiveTo &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecurringChargeRulesCompanion
    extends UpdateCompanion<RecurringChargeRule> {
  final Value<String> id;
  final Value<String> tenancyId;
  final Value<String> chargeType;
  final Value<String> calculationMethod;
  final Value<int> fixedAmountPoisha;
  final Value<int?> ratePoisha;
  final Value<DateTime> effectiveFrom;
  final Value<DateTime?> effectiveTo;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecurringChargeRulesCompanion({
    this.id = const Value.absent(),
    this.tenancyId = const Value.absent(),
    this.chargeType = const Value.absent(),
    this.calculationMethod = const Value.absent(),
    this.fixedAmountPoisha = const Value.absent(),
    this.ratePoisha = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.effectiveTo = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringChargeRulesCompanion.insert({
    required String id,
    required String tenancyId,
    required String chargeType,
    required String calculationMethod,
    this.fixedAmountPoisha = const Value.absent(),
    this.ratePoisha = const Value.absent(),
    required DateTime effectiveFrom,
    this.effectiveTo = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenancyId = Value(tenancyId),
       chargeType = Value(chargeType),
       calculationMethod = Value(calculationMethod),
       effectiveFrom = Value(effectiveFrom);
  static Insertable<RecurringChargeRule> custom({
    Expression<String>? id,
    Expression<String>? tenancyId,
    Expression<String>? chargeType,
    Expression<String>? calculationMethod,
    Expression<int>? fixedAmountPoisha,
    Expression<int>? ratePoisha,
    Expression<DateTime>? effectiveFrom,
    Expression<DateTime>? effectiveTo,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenancyId != null) 'tenancy_id': tenancyId,
      if (chargeType != null) 'charge_type': chargeType,
      if (calculationMethod != null) 'calculation_method': calculationMethod,
      if (fixedAmountPoisha != null) 'fixed_amount_poisha': fixedAmountPoisha,
      if (ratePoisha != null) 'rate_poisha': ratePoisha,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (effectiveTo != null) 'effective_to': effectiveTo,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringChargeRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenancyId,
    Value<String>? chargeType,
    Value<String>? calculationMethod,
    Value<int>? fixedAmountPoisha,
    Value<int?>? ratePoisha,
    Value<DateTime>? effectiveFrom,
    Value<DateTime?>? effectiveTo,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecurringChargeRulesCompanion(
      id: id ?? this.id,
      tenancyId: tenancyId ?? this.tenancyId,
      chargeType: chargeType ?? this.chargeType,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      fixedAmountPoisha: fixedAmountPoisha ?? this.fixedAmountPoisha,
      ratePoisha: ratePoisha ?? this.ratePoisha,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      effectiveTo: effectiveTo ?? this.effectiveTo,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenancyId.present) {
      map['tenancy_id'] = Variable<String>(tenancyId.value);
    }
    if (chargeType.present) {
      map['charge_type'] = Variable<String>(chargeType.value);
    }
    if (calculationMethod.present) {
      map['calculation_method'] = Variable<String>(calculationMethod.value);
    }
    if (fixedAmountPoisha.present) {
      map['fixed_amount_poisha'] = Variable<int>(fixedAmountPoisha.value);
    }
    if (ratePoisha.present) {
      map['rate_poisha'] = Variable<int>(ratePoisha.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (effectiveTo.present) {
      map['effective_to'] = Variable<DateTime>(effectiveTo.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringChargeRulesCompanion(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('chargeType: $chargeType, ')
          ..write('calculationMethod: $calculationMethod, ')
          ..write('fixedAmountPoisha: $fixedAmountPoisha, ')
          ..write('ratePoisha: $ratePoisha, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('effectiveTo: $effectiveTo, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UtilityMeterConfigsTable extends UtilityMeterConfigs
    with TableInfo<$UtilityMeterConfigsTable, UtilityMeterConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtilityMeterConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES units (id)',
    ),
  );
  static const VerificationMeta _meterNumberMeta = const VerificationMeta(
    'meterNumber',
  );
  @override
  late final GeneratedColumn<String> meterNumber = GeneratedColumn<String>(
    'meter_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _billingModeMeta = const VerificationMeta(
    'billingMode',
  );
  @override
  late final GeneratedColumn<String> billingMode = GeneratedColumn<String>(
    'billing_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePerUnitPoishaMeta = const VerificationMeta(
    'ratePerUnitPoisha',
  );
  @override
  late final GeneratedColumn<int> ratePerUnitPoisha = GeneratedColumn<int>(
    'rate_per_unit_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _additionalChargePoishaMeta =
      const VerificationMeta('additionalChargePoisha');
  @override
  late final GeneratedColumn<int> additionalChargePoisha = GeneratedColumn<int>(
    'additional_charge_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _initialReadingMeta = const VerificationMeta(
    'initialReading',
  );
  @override
  late final GeneratedColumn<int> initialReading = GeneratedColumn<int>(
    'initial_reading',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    unitId,
    meterNumber,
    billingMode,
    ratePerUnitPoisha,
    additionalChargePoisha,
    initialReading,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utility_meter_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtilityMeterConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('meter_number')) {
      context.handle(
        _meterNumberMeta,
        meterNumber.isAcceptableOrUnknown(
          data['meter_number']!,
          _meterNumberMeta,
        ),
      );
    }
    if (data.containsKey('billing_mode')) {
      context.handle(
        _billingModeMeta,
        billingMode.isAcceptableOrUnknown(
          data['billing_mode']!,
          _billingModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingModeMeta);
    }
    if (data.containsKey('rate_per_unit_poisha')) {
      context.handle(
        _ratePerUnitPoishaMeta,
        ratePerUnitPoisha.isAcceptableOrUnknown(
          data['rate_per_unit_poisha']!,
          _ratePerUnitPoishaMeta,
        ),
      );
    }
    if (data.containsKey('additional_charge_poisha')) {
      context.handle(
        _additionalChargePoishaMeta,
        additionalChargePoisha.isAcceptableOrUnknown(
          data['additional_charge_poisha']!,
          _additionalChargePoishaMeta,
        ),
      );
    }
    if (data.containsKey('initial_reading')) {
      context.handle(
        _initialReadingMeta,
        initialReading.isAcceptableOrUnknown(
          data['initial_reading']!,
          _initialReadingMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UtilityMeterConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtilityMeterConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      meterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_number'],
      ),
      billingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}billing_mode'],
      )!,
      ratePerUnitPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_per_unit_poisha'],
      )!,
      additionalChargePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}additional_charge_poisha'],
      )!,
      initialReading: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_reading'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UtilityMeterConfigsTable createAlias(String alias) {
    return $UtilityMeterConfigsTable(attachedDatabase, alias);
  }
}

class UtilityMeterConfig extends DataClass
    implements Insertable<UtilityMeterConfig> {
  final String id;
  final String unitId;
  final String? meterNumber;
  final String billingMode;
  final int ratePerUnitPoisha;
  final int additionalChargePoisha;
  final int initialReading;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UtilityMeterConfig({
    required this.id,
    required this.unitId,
    this.meterNumber,
    required this.billingMode,
    required this.ratePerUnitPoisha,
    required this.additionalChargePoisha,
    required this.initialReading,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['unit_id'] = Variable<String>(unitId);
    if (!nullToAbsent || meterNumber != null) {
      map['meter_number'] = Variable<String>(meterNumber);
    }
    map['billing_mode'] = Variable<String>(billingMode);
    map['rate_per_unit_poisha'] = Variable<int>(ratePerUnitPoisha);
    map['additional_charge_poisha'] = Variable<int>(additionalChargePoisha);
    map['initial_reading'] = Variable<int>(initialReading);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UtilityMeterConfigsCompanion toCompanion(bool nullToAbsent) {
    return UtilityMeterConfigsCompanion(
      id: Value(id),
      unitId: Value(unitId),
      meterNumber: meterNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(meterNumber),
      billingMode: Value(billingMode),
      ratePerUnitPoisha: Value(ratePerUnitPoisha),
      additionalChargePoisha: Value(additionalChargePoisha),
      initialReading: Value(initialReading),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UtilityMeterConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtilityMeterConfig(
      id: serializer.fromJson<String>(json['id']),
      unitId: serializer.fromJson<String>(json['unitId']),
      meterNumber: serializer.fromJson<String?>(json['meterNumber']),
      billingMode: serializer.fromJson<String>(json['billingMode']),
      ratePerUnitPoisha: serializer.fromJson<int>(json['ratePerUnitPoisha']),
      additionalChargePoisha: serializer.fromJson<int>(
        json['additionalChargePoisha'],
      ),
      initialReading: serializer.fromJson<int>(json['initialReading']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unitId': serializer.toJson<String>(unitId),
      'meterNumber': serializer.toJson<String?>(meterNumber),
      'billingMode': serializer.toJson<String>(billingMode),
      'ratePerUnitPoisha': serializer.toJson<int>(ratePerUnitPoisha),
      'additionalChargePoisha': serializer.toJson<int>(additionalChargePoisha),
      'initialReading': serializer.toJson<int>(initialReading),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UtilityMeterConfig copyWith({
    String? id,
    String? unitId,
    Value<String?> meterNumber = const Value.absent(),
    String? billingMode,
    int? ratePerUnitPoisha,
    int? additionalChargePoisha,
    int? initialReading,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UtilityMeterConfig(
    id: id ?? this.id,
    unitId: unitId ?? this.unitId,
    meterNumber: meterNumber.present ? meterNumber.value : this.meterNumber,
    billingMode: billingMode ?? this.billingMode,
    ratePerUnitPoisha: ratePerUnitPoisha ?? this.ratePerUnitPoisha,
    additionalChargePoisha:
        additionalChargePoisha ?? this.additionalChargePoisha,
    initialReading: initialReading ?? this.initialReading,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UtilityMeterConfig copyWithCompanion(UtilityMeterConfigsCompanion data) {
    return UtilityMeterConfig(
      id: data.id.present ? data.id.value : this.id,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      meterNumber: data.meterNumber.present
          ? data.meterNumber.value
          : this.meterNumber,
      billingMode: data.billingMode.present
          ? data.billingMode.value
          : this.billingMode,
      ratePerUnitPoisha: data.ratePerUnitPoisha.present
          ? data.ratePerUnitPoisha.value
          : this.ratePerUnitPoisha,
      additionalChargePoisha: data.additionalChargePoisha.present
          ? data.additionalChargePoisha.value
          : this.additionalChargePoisha,
      initialReading: data.initialReading.present
          ? data.initialReading.value
          : this.initialReading,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtilityMeterConfig(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('billingMode: $billingMode, ')
          ..write('ratePerUnitPoisha: $ratePerUnitPoisha, ')
          ..write('additionalChargePoisha: $additionalChargePoisha, ')
          ..write('initialReading: $initialReading, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    unitId,
    meterNumber,
    billingMode,
    ratePerUnitPoisha,
    additionalChargePoisha,
    initialReading,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtilityMeterConfig &&
          other.id == this.id &&
          other.unitId == this.unitId &&
          other.meterNumber == this.meterNumber &&
          other.billingMode == this.billingMode &&
          other.ratePerUnitPoisha == this.ratePerUnitPoisha &&
          other.additionalChargePoisha == this.additionalChargePoisha &&
          other.initialReading == this.initialReading &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UtilityMeterConfigsCompanion extends UpdateCompanion<UtilityMeterConfig> {
  final Value<String> id;
  final Value<String> unitId;
  final Value<String?> meterNumber;
  final Value<String> billingMode;
  final Value<int> ratePerUnitPoisha;
  final Value<int> additionalChargePoisha;
  final Value<int> initialReading;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UtilityMeterConfigsCompanion({
    this.id = const Value.absent(),
    this.unitId = const Value.absent(),
    this.meterNumber = const Value.absent(),
    this.billingMode = const Value.absent(),
    this.ratePerUnitPoisha = const Value.absent(),
    this.additionalChargePoisha = const Value.absent(),
    this.initialReading = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtilityMeterConfigsCompanion.insert({
    required String id,
    required String unitId,
    this.meterNumber = const Value.absent(),
    required String billingMode,
    this.ratePerUnitPoisha = const Value.absent(),
    this.additionalChargePoisha = const Value.absent(),
    this.initialReading = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       unitId = Value(unitId),
       billingMode = Value(billingMode);
  static Insertable<UtilityMeterConfig> custom({
    Expression<String>? id,
    Expression<String>? unitId,
    Expression<String>? meterNumber,
    Expression<String>? billingMode,
    Expression<int>? ratePerUnitPoisha,
    Expression<int>? additionalChargePoisha,
    Expression<int>? initialReading,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unitId != null) 'unit_id': unitId,
      if (meterNumber != null) 'meter_number': meterNumber,
      if (billingMode != null) 'billing_mode': billingMode,
      if (ratePerUnitPoisha != null) 'rate_per_unit_poisha': ratePerUnitPoisha,
      if (additionalChargePoisha != null)
        'additional_charge_poisha': additionalChargePoisha,
      if (initialReading != null) 'initial_reading': initialReading,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtilityMeterConfigsCompanion copyWith({
    Value<String>? id,
    Value<String>? unitId,
    Value<String?>? meterNumber,
    Value<String>? billingMode,
    Value<int>? ratePerUnitPoisha,
    Value<int>? additionalChargePoisha,
    Value<int>? initialReading,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UtilityMeterConfigsCompanion(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      meterNumber: meterNumber ?? this.meterNumber,
      billingMode: billingMode ?? this.billingMode,
      ratePerUnitPoisha: ratePerUnitPoisha ?? this.ratePerUnitPoisha,
      additionalChargePoisha:
          additionalChargePoisha ?? this.additionalChargePoisha,
      initialReading: initialReading ?? this.initialReading,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (meterNumber.present) {
      map['meter_number'] = Variable<String>(meterNumber.value);
    }
    if (billingMode.present) {
      map['billing_mode'] = Variable<String>(billingMode.value);
    }
    if (ratePerUnitPoisha.present) {
      map['rate_per_unit_poisha'] = Variable<int>(ratePerUnitPoisha.value);
    }
    if (additionalChargePoisha.present) {
      map['additional_charge_poisha'] = Variable<int>(
        additionalChargePoisha.value,
      );
    }
    if (initialReading.present) {
      map['initial_reading'] = Variable<int>(initialReading.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtilityMeterConfigsCompanion(')
          ..write('id: $id, ')
          ..write('unitId: $unitId, ')
          ..write('meterNumber: $meterNumber, ')
          ..write('billingMode: $billingMode, ')
          ..write('ratePerUnitPoisha: $ratePerUnitPoisha, ')
          ..write('additionalChargePoisha: $additionalChargePoisha, ')
          ..write('initialReading: $initialReading, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyBillsTable extends MonthlyBills
    with TableInfo<$MonthlyBillsTable, MonthlyBill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyBillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenancyIdMeta = const VerificationMeta(
    'tenancyId',
  );
  @override
  late final GeneratedColumn<String> tenancyId = GeneratedColumn<String>(
    'tenancy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenancies (id)',
    ),
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES units (id)',
    ),
  );
  static const VerificationMeta _billingYearMeta = const VerificationMeta(
    'billingYear',
  );
  @override
  late final GeneratedColumn<int> billingYear = GeneratedColumn<int>(
    'billing_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billingMonthMeta = const VerificationMeta(
    'billingMonth',
  );
  @override
  late final GeneratedColumn<int> billingMonth = GeneratedColumn<int>(
    'billing_month',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _previousDuePoishaMeta = const VerificationMeta(
    'previousDuePoisha',
  );
  @override
  late final GeneratedColumn<int> previousDuePoisha = GeneratedColumn<int>(
    'previous_due_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _subtotalPoishaMeta = const VerificationMeta(
    'subtotalPoisha',
  );
  @override
  late final GeneratedColumn<int> subtotalPoisha = GeneratedColumn<int>(
    'subtotal_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPoishaMeta = const VerificationMeta(
    'totalPoisha',
  );
  @override
  late final GeneratedColumn<int> totalPoisha = GeneratedColumn<int>(
    'total_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidPoishaMeta = const VerificationMeta(
    'paidPoisha',
  );
  @override
  late final GeneratedColumn<int> paidPoisha = GeneratedColumn<int>(
    'paid_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _balancePoishaMeta = const VerificationMeta(
    'balancePoisha',
  );
  @override
  late final GeneratedColumn<int> balancePoisha = GeneratedColumn<int>(
    'balance_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _finalizedAtMeta = const VerificationMeta(
    'finalizedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finalizedAt = GeneratedColumn<DateTime>(
    'finalized_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenancyId,
    propertyId,
    unitId,
    billingYear,
    billingMonth,
    status,
    previousDuePoisha,
    subtotalPoisha,
    totalPoisha,
    paidPoisha,
    balancePoisha,
    finalizedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyBill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenancy_id')) {
      context.handle(
        _tenancyIdMeta,
        tenancyId.isAcceptableOrUnknown(data['tenancy_id']!, _tenancyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenancyIdMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('billing_year')) {
      context.handle(
        _billingYearMeta,
        billingYear.isAcceptableOrUnknown(
          data['billing_year']!,
          _billingYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingYearMeta);
    }
    if (data.containsKey('billing_month')) {
      context.handle(
        _billingMonthMeta,
        billingMonth.isAcceptableOrUnknown(
          data['billing_month']!,
          _billingMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingMonthMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('previous_due_poisha')) {
      context.handle(
        _previousDuePoishaMeta,
        previousDuePoisha.isAcceptableOrUnknown(
          data['previous_due_poisha']!,
          _previousDuePoishaMeta,
        ),
      );
    }
    if (data.containsKey('subtotal_poisha')) {
      context.handle(
        _subtotalPoishaMeta,
        subtotalPoisha.isAcceptableOrUnknown(
          data['subtotal_poisha']!,
          _subtotalPoishaMeta,
        ),
      );
    }
    if (data.containsKey('total_poisha')) {
      context.handle(
        _totalPoishaMeta,
        totalPoisha.isAcceptableOrUnknown(
          data['total_poisha']!,
          _totalPoishaMeta,
        ),
      );
    }
    if (data.containsKey('paid_poisha')) {
      context.handle(
        _paidPoishaMeta,
        paidPoisha.isAcceptableOrUnknown(data['paid_poisha']!, _paidPoishaMeta),
      );
    }
    if (data.containsKey('balance_poisha')) {
      context.handle(
        _balancePoishaMeta,
        balancePoisha.isAcceptableOrUnknown(
          data['balance_poisha']!,
          _balancePoishaMeta,
        ),
      );
    }
    if (data.containsKey('finalized_at')) {
      context.handle(
        _finalizedAtMeta,
        finalizedAt.isAcceptableOrUnknown(
          data['finalized_at']!,
          _finalizedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tenancyId, billingYear, billingMonth},
  ];
  @override
  MonthlyBill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyBill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenancyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenancy_id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      billingYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_year'],
      )!,
      billingMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_month'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      previousDuePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_due_poisha'],
      )!,
      subtotalPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_poisha'],
      )!,
      totalPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_poisha'],
      )!,
      paidPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}paid_poisha'],
      )!,
      balancePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_poisha'],
      )!,
      finalizedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finalized_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MonthlyBillsTable createAlias(String alias) {
    return $MonthlyBillsTable(attachedDatabase, alias);
  }
}

class MonthlyBill extends DataClass implements Insertable<MonthlyBill> {
  final String id;
  final String tenancyId;
  final String propertyId;
  final String unitId;
  final int billingYear;
  final int billingMonth;
  final String status;
  final int previousDuePoisha;
  final int subtotalPoisha;
  final int totalPoisha;
  final int paidPoisha;
  final int balancePoisha;
  final DateTime? finalizedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MonthlyBill({
    required this.id,
    required this.tenancyId,
    required this.propertyId,
    required this.unitId,
    required this.billingYear,
    required this.billingMonth,
    required this.status,
    required this.previousDuePoisha,
    required this.subtotalPoisha,
    required this.totalPoisha,
    required this.paidPoisha,
    required this.balancePoisha,
    this.finalizedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenancy_id'] = Variable<String>(tenancyId);
    map['property_id'] = Variable<String>(propertyId);
    map['unit_id'] = Variable<String>(unitId);
    map['billing_year'] = Variable<int>(billingYear);
    map['billing_month'] = Variable<int>(billingMonth);
    map['status'] = Variable<String>(status);
    map['previous_due_poisha'] = Variable<int>(previousDuePoisha);
    map['subtotal_poisha'] = Variable<int>(subtotalPoisha);
    map['total_poisha'] = Variable<int>(totalPoisha);
    map['paid_poisha'] = Variable<int>(paidPoisha);
    map['balance_poisha'] = Variable<int>(balancePoisha);
    if (!nullToAbsent || finalizedAt != null) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MonthlyBillsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyBillsCompanion(
      id: Value(id),
      tenancyId: Value(tenancyId),
      propertyId: Value(propertyId),
      unitId: Value(unitId),
      billingYear: Value(billingYear),
      billingMonth: Value(billingMonth),
      status: Value(status),
      previousDuePoisha: Value(previousDuePoisha),
      subtotalPoisha: Value(subtotalPoisha),
      totalPoisha: Value(totalPoisha),
      paidPoisha: Value(paidPoisha),
      balancePoisha: Value(balancePoisha),
      finalizedAt: finalizedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MonthlyBill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyBill(
      id: serializer.fromJson<String>(json['id']),
      tenancyId: serializer.fromJson<String>(json['tenancyId']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      unitId: serializer.fromJson<String>(json['unitId']),
      billingYear: serializer.fromJson<int>(json['billingYear']),
      billingMonth: serializer.fromJson<int>(json['billingMonth']),
      status: serializer.fromJson<String>(json['status']),
      previousDuePoisha: serializer.fromJson<int>(json['previousDuePoisha']),
      subtotalPoisha: serializer.fromJson<int>(json['subtotalPoisha']),
      totalPoisha: serializer.fromJson<int>(json['totalPoisha']),
      paidPoisha: serializer.fromJson<int>(json['paidPoisha']),
      balancePoisha: serializer.fromJson<int>(json['balancePoisha']),
      finalizedAt: serializer.fromJson<DateTime?>(json['finalizedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenancyId': serializer.toJson<String>(tenancyId),
      'propertyId': serializer.toJson<String>(propertyId),
      'unitId': serializer.toJson<String>(unitId),
      'billingYear': serializer.toJson<int>(billingYear),
      'billingMonth': serializer.toJson<int>(billingMonth),
      'status': serializer.toJson<String>(status),
      'previousDuePoisha': serializer.toJson<int>(previousDuePoisha),
      'subtotalPoisha': serializer.toJson<int>(subtotalPoisha),
      'totalPoisha': serializer.toJson<int>(totalPoisha),
      'paidPoisha': serializer.toJson<int>(paidPoisha),
      'balancePoisha': serializer.toJson<int>(balancePoisha),
      'finalizedAt': serializer.toJson<DateTime?>(finalizedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MonthlyBill copyWith({
    String? id,
    String? tenancyId,
    String? propertyId,
    String? unitId,
    int? billingYear,
    int? billingMonth,
    String? status,
    int? previousDuePoisha,
    int? subtotalPoisha,
    int? totalPoisha,
    int? paidPoisha,
    int? balancePoisha,
    Value<DateTime?> finalizedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MonthlyBill(
    id: id ?? this.id,
    tenancyId: tenancyId ?? this.tenancyId,
    propertyId: propertyId ?? this.propertyId,
    unitId: unitId ?? this.unitId,
    billingYear: billingYear ?? this.billingYear,
    billingMonth: billingMonth ?? this.billingMonth,
    status: status ?? this.status,
    previousDuePoisha: previousDuePoisha ?? this.previousDuePoisha,
    subtotalPoisha: subtotalPoisha ?? this.subtotalPoisha,
    totalPoisha: totalPoisha ?? this.totalPoisha,
    paidPoisha: paidPoisha ?? this.paidPoisha,
    balancePoisha: balancePoisha ?? this.balancePoisha,
    finalizedAt: finalizedAt.present ? finalizedAt.value : this.finalizedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MonthlyBill copyWithCompanion(MonthlyBillsCompanion data) {
    return MonthlyBill(
      id: data.id.present ? data.id.value : this.id,
      tenancyId: data.tenancyId.present ? data.tenancyId.value : this.tenancyId,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      billingYear: data.billingYear.present
          ? data.billingYear.value
          : this.billingYear,
      billingMonth: data.billingMonth.present
          ? data.billingMonth.value
          : this.billingMonth,
      status: data.status.present ? data.status.value : this.status,
      previousDuePoisha: data.previousDuePoisha.present
          ? data.previousDuePoisha.value
          : this.previousDuePoisha,
      subtotalPoisha: data.subtotalPoisha.present
          ? data.subtotalPoisha.value
          : this.subtotalPoisha,
      totalPoisha: data.totalPoisha.present
          ? data.totalPoisha.value
          : this.totalPoisha,
      paidPoisha: data.paidPoisha.present
          ? data.paidPoisha.value
          : this.paidPoisha,
      balancePoisha: data.balancePoisha.present
          ? data.balancePoisha.value
          : this.balancePoisha,
      finalizedAt: data.finalizedAt.present
          ? data.finalizedAt.value
          : this.finalizedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyBill(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('propertyId: $propertyId, ')
          ..write('unitId: $unitId, ')
          ..write('billingYear: $billingYear, ')
          ..write('billingMonth: $billingMonth, ')
          ..write('status: $status, ')
          ..write('previousDuePoisha: $previousDuePoisha, ')
          ..write('subtotalPoisha: $subtotalPoisha, ')
          ..write('totalPoisha: $totalPoisha, ')
          ..write('paidPoisha: $paidPoisha, ')
          ..write('balancePoisha: $balancePoisha, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenancyId,
    propertyId,
    unitId,
    billingYear,
    billingMonth,
    status,
    previousDuePoisha,
    subtotalPoisha,
    totalPoisha,
    paidPoisha,
    balancePoisha,
    finalizedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyBill &&
          other.id == this.id &&
          other.tenancyId == this.tenancyId &&
          other.propertyId == this.propertyId &&
          other.unitId == this.unitId &&
          other.billingYear == this.billingYear &&
          other.billingMonth == this.billingMonth &&
          other.status == this.status &&
          other.previousDuePoisha == this.previousDuePoisha &&
          other.subtotalPoisha == this.subtotalPoisha &&
          other.totalPoisha == this.totalPoisha &&
          other.paidPoisha == this.paidPoisha &&
          other.balancePoisha == this.balancePoisha &&
          other.finalizedAt == this.finalizedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MonthlyBillsCompanion extends UpdateCompanion<MonthlyBill> {
  final Value<String> id;
  final Value<String> tenancyId;
  final Value<String> propertyId;
  final Value<String> unitId;
  final Value<int> billingYear;
  final Value<int> billingMonth;
  final Value<String> status;
  final Value<int> previousDuePoisha;
  final Value<int> subtotalPoisha;
  final Value<int> totalPoisha;
  final Value<int> paidPoisha;
  final Value<int> balancePoisha;
  final Value<DateTime?> finalizedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MonthlyBillsCompanion({
    this.id = const Value.absent(),
    this.tenancyId = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.billingYear = const Value.absent(),
    this.billingMonth = const Value.absent(),
    this.status = const Value.absent(),
    this.previousDuePoisha = const Value.absent(),
    this.subtotalPoisha = const Value.absent(),
    this.totalPoisha = const Value.absent(),
    this.paidPoisha = const Value.absent(),
    this.balancePoisha = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyBillsCompanion.insert({
    required String id,
    required String tenancyId,
    required String propertyId,
    required String unitId,
    required int billingYear,
    required int billingMonth,
    this.status = const Value.absent(),
    this.previousDuePoisha = const Value.absent(),
    this.subtotalPoisha = const Value.absent(),
    this.totalPoisha = const Value.absent(),
    this.paidPoisha = const Value.absent(),
    this.balancePoisha = const Value.absent(),
    this.finalizedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenancyId = Value(tenancyId),
       propertyId = Value(propertyId),
       unitId = Value(unitId),
       billingYear = Value(billingYear),
       billingMonth = Value(billingMonth);
  static Insertable<MonthlyBill> custom({
    Expression<String>? id,
    Expression<String>? tenancyId,
    Expression<String>? propertyId,
    Expression<String>? unitId,
    Expression<int>? billingYear,
    Expression<int>? billingMonth,
    Expression<String>? status,
    Expression<int>? previousDuePoisha,
    Expression<int>? subtotalPoisha,
    Expression<int>? totalPoisha,
    Expression<int>? paidPoisha,
    Expression<int>? balancePoisha,
    Expression<DateTime>? finalizedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenancyId != null) 'tenancy_id': tenancyId,
      if (propertyId != null) 'property_id': propertyId,
      if (unitId != null) 'unit_id': unitId,
      if (billingYear != null) 'billing_year': billingYear,
      if (billingMonth != null) 'billing_month': billingMonth,
      if (status != null) 'status': status,
      if (previousDuePoisha != null) 'previous_due_poisha': previousDuePoisha,
      if (subtotalPoisha != null) 'subtotal_poisha': subtotalPoisha,
      if (totalPoisha != null) 'total_poisha': totalPoisha,
      if (paidPoisha != null) 'paid_poisha': paidPoisha,
      if (balancePoisha != null) 'balance_poisha': balancePoisha,
      if (finalizedAt != null) 'finalized_at': finalizedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyBillsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenancyId,
    Value<String>? propertyId,
    Value<String>? unitId,
    Value<int>? billingYear,
    Value<int>? billingMonth,
    Value<String>? status,
    Value<int>? previousDuePoisha,
    Value<int>? subtotalPoisha,
    Value<int>? totalPoisha,
    Value<int>? paidPoisha,
    Value<int>? balancePoisha,
    Value<DateTime?>? finalizedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MonthlyBillsCompanion(
      id: id ?? this.id,
      tenancyId: tenancyId ?? this.tenancyId,
      propertyId: propertyId ?? this.propertyId,
      unitId: unitId ?? this.unitId,
      billingYear: billingYear ?? this.billingYear,
      billingMonth: billingMonth ?? this.billingMonth,
      status: status ?? this.status,
      previousDuePoisha: previousDuePoisha ?? this.previousDuePoisha,
      subtotalPoisha: subtotalPoisha ?? this.subtotalPoisha,
      totalPoisha: totalPoisha ?? this.totalPoisha,
      paidPoisha: paidPoisha ?? this.paidPoisha,
      balancePoisha: balancePoisha ?? this.balancePoisha,
      finalizedAt: finalizedAt ?? this.finalizedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenancyId.present) {
      map['tenancy_id'] = Variable<String>(tenancyId.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (billingYear.present) {
      map['billing_year'] = Variable<int>(billingYear.value);
    }
    if (billingMonth.present) {
      map['billing_month'] = Variable<int>(billingMonth.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (previousDuePoisha.present) {
      map['previous_due_poisha'] = Variable<int>(previousDuePoisha.value);
    }
    if (subtotalPoisha.present) {
      map['subtotal_poisha'] = Variable<int>(subtotalPoisha.value);
    }
    if (totalPoisha.present) {
      map['total_poisha'] = Variable<int>(totalPoisha.value);
    }
    if (paidPoisha.present) {
      map['paid_poisha'] = Variable<int>(paidPoisha.value);
    }
    if (balancePoisha.present) {
      map['balance_poisha'] = Variable<int>(balancePoisha.value);
    }
    if (finalizedAt.present) {
      map['finalized_at'] = Variable<DateTime>(finalizedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyBillsCompanion(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('propertyId: $propertyId, ')
          ..write('unitId: $unitId, ')
          ..write('billingYear: $billingYear, ')
          ..write('billingMonth: $billingMonth, ')
          ..write('status: $status, ')
          ..write('previousDuePoisha: $previousDuePoisha, ')
          ..write('subtotalPoisha: $subtotalPoisha, ')
          ..write('totalPoisha: $totalPoisha, ')
          ..write('paidPoisha: $paidPoisha, ')
          ..write('balancePoisha: $balancePoisha, ')
          ..write('finalizedAt: $finalizedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BillLineItemsTable extends BillLineItems
    with TableInfo<$BillLineItemsTable, BillLineItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillLineItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_bills (id)',
    ),
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitRatePoishaMeta = const VerificationMeta(
    'unitRatePoisha',
  );
  @override
  late final GeneratedColumn<int> unitRatePoisha = GeneratedColumn<int>(
    'unit_rate_poisha',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountPoishaMeta = const VerificationMeta(
    'amountPoisha',
  );
  @override
  late final GeneratedColumn<int> amountPoisha = GeneratedColumn<int>(
    'amount_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    itemType,
    description,
    quantity,
    unitRatePoisha,
    amountPoisha,
    sortOrder,
    metadataJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_line_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillLineItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_rate_poisha')) {
      context.handle(
        _unitRatePoishaMeta,
        unitRatePoisha.isAcceptableOrUnknown(
          data['unit_rate_poisha']!,
          _unitRatePoishaMeta,
        ),
      );
    }
    if (data.containsKey('amount_poisha')) {
      context.handle(
        _amountPoishaMeta,
        amountPoisha.isAcceptableOrUnknown(
          data['amount_poisha']!,
          _amountPoishaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPoishaMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillLineItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillLineItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      ),
      unitRatePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_rate_poisha'],
      ),
      amountPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_poisha'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BillLineItemsTable createAlias(String alias) {
    return $BillLineItemsTable(attachedDatabase, alias);
  }
}

class BillLineItem extends DataClass implements Insertable<BillLineItem> {
  final String id;
  final String billId;
  final String itemType;
  final String description;
  final int? quantity;
  final int? unitRatePoisha;
  final int amountPoisha;
  final int sortOrder;
  final String? metadataJson;
  final DateTime createdAt;
  const BillLineItem({
    required this.id,
    required this.billId,
    required this.itemType,
    required this.description,
    this.quantity,
    this.unitRatePoisha,
    required this.amountPoisha,
    required this.sortOrder,
    this.metadataJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['bill_id'] = Variable<String>(billId);
    map['item_type'] = Variable<String>(itemType);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || unitRatePoisha != null) {
      map['unit_rate_poisha'] = Variable<int>(unitRatePoisha);
    }
    map['amount_poisha'] = Variable<int>(amountPoisha);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillLineItemsCompanion toCompanion(bool nullToAbsent) {
    return BillLineItemsCompanion(
      id: Value(id),
      billId: Value(billId),
      itemType: Value(itemType),
      description: Value(description),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unitRatePoisha: unitRatePoisha == null && nullToAbsent
          ? const Value.absent()
          : Value(unitRatePoisha),
      amountPoisha: Value(amountPoisha),
      sortOrder: Value(sortOrder),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      createdAt: Value(createdAt),
    );
  }

  factory BillLineItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillLineItem(
      id: serializer.fromJson<String>(json['id']),
      billId: serializer.fromJson<String>(json['billId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      unitRatePoisha: serializer.fromJson<int?>(json['unitRatePoisha']),
      amountPoisha: serializer.fromJson<int>(json['amountPoisha']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'billId': serializer.toJson<String>(billId),
      'itemType': serializer.toJson<String>(itemType),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<int?>(quantity),
      'unitRatePoisha': serializer.toJson<int?>(unitRatePoisha),
      'amountPoisha': serializer.toJson<int>(amountPoisha),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BillLineItem copyWith({
    String? id,
    String? billId,
    String? itemType,
    String? description,
    Value<int?> quantity = const Value.absent(),
    Value<int?> unitRatePoisha = const Value.absent(),
    int? amountPoisha,
    int? sortOrder,
    Value<String?> metadataJson = const Value.absent(),
    DateTime? createdAt,
  }) => BillLineItem(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    itemType: itemType ?? this.itemType,
    description: description ?? this.description,
    quantity: quantity.present ? quantity.value : this.quantity,
    unitRatePoisha: unitRatePoisha.present
        ? unitRatePoisha.value
        : this.unitRatePoisha,
    amountPoisha: amountPoisha ?? this.amountPoisha,
    sortOrder: sortOrder ?? this.sortOrder,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
    createdAt: createdAt ?? this.createdAt,
  );
  BillLineItem copyWithCompanion(BillLineItemsCompanion data) {
    return BillLineItem(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitRatePoisha: data.unitRatePoisha.present
          ? data.unitRatePoisha.value
          : this.unitRatePoisha,
      amountPoisha: data.amountPoisha.present
          ? data.amountPoisha.value
          : this.amountPoisha,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillLineItem(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemType: $itemType, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitRatePoisha: $unitRatePoisha, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    billId,
    itemType,
    description,
    quantity,
    unitRatePoisha,
    amountPoisha,
    sortOrder,
    metadataJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillLineItem &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.itemType == this.itemType &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitRatePoisha == this.unitRatePoisha &&
          other.amountPoisha == this.amountPoisha &&
          other.sortOrder == this.sortOrder &&
          other.metadataJson == this.metadataJson &&
          other.createdAt == this.createdAt);
}

class BillLineItemsCompanion extends UpdateCompanion<BillLineItem> {
  final Value<String> id;
  final Value<String> billId;
  final Value<String> itemType;
  final Value<String> description;
  final Value<int?> quantity;
  final Value<int?> unitRatePoisha;
  final Value<int> amountPoisha;
  final Value<int> sortOrder;
  final Value<String?> metadataJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BillLineItemsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitRatePoisha = const Value.absent(),
    this.amountPoisha = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BillLineItemsCompanion.insert({
    required String id,
    required String billId,
    required String itemType,
    required String description,
    this.quantity = const Value.absent(),
    this.unitRatePoisha = const Value.absent(),
    required int amountPoisha,
    this.sortOrder = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       billId = Value(billId),
       itemType = Value(itemType),
       description = Value(description),
       amountPoisha = Value(amountPoisha);
  static Insertable<BillLineItem> custom({
    Expression<String>? id,
    Expression<String>? billId,
    Expression<String>? itemType,
    Expression<String>? description,
    Expression<int>? quantity,
    Expression<int>? unitRatePoisha,
    Expression<int>? amountPoisha,
    Expression<int>? sortOrder,
    Expression<String>? metadataJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (itemType != null) 'item_type': itemType,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitRatePoisha != null) 'unit_rate_poisha': unitRatePoisha,
      if (amountPoisha != null) 'amount_poisha': amountPoisha,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BillLineItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? billId,
    Value<String>? itemType,
    Value<String>? description,
    Value<int?>? quantity,
    Value<int?>? unitRatePoisha,
    Value<int>? amountPoisha,
    Value<int>? sortOrder,
    Value<String?>? metadataJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BillLineItemsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      itemType: itemType ?? this.itemType,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitRatePoisha: unitRatePoisha ?? this.unitRatePoisha,
      amountPoisha: amountPoisha ?? this.amountPoisha,
      sortOrder: sortOrder ?? this.sortOrder,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitRatePoisha.present) {
      map['unit_rate_poisha'] = Variable<int>(unitRatePoisha.value);
    }
    if (amountPoisha.present) {
      map['amount_poisha'] = Variable<int>(amountPoisha.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillLineItemsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemType: $itemType, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitRatePoisha: $unitRatePoisha, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenancyIdMeta = const VerificationMeta(
    'tenancyId',
  );
  @override
  late final GeneratedColumn<String> tenancyId = GeneratedColumn<String>(
    'tenancy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenancies (id)',
    ),
  );
  static const VerificationMeta _paymentNumberMeta = const VerificationMeta(
    'paymentNumber',
  );
  @override
  late final GeneratedColumn<String> paymentNumber = GeneratedColumn<String>(
    'payment_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPoishaMeta = const VerificationMeta(
    'amountPoisha',
  );
  @override
  late final GeneratedColumn<int> amountPoisha = GeneratedColumn<int>(
    'amount_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('posted'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenancyId,
    paymentNumber,
    paymentDate,
    amountPoisha,
    paymentMethod,
    reference,
    note,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenancy_id')) {
      context.handle(
        _tenancyIdMeta,
        tenancyId.isAcceptableOrUnknown(data['tenancy_id']!, _tenancyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenancyIdMeta);
    }
    if (data.containsKey('payment_number')) {
      context.handle(
        _paymentNumberMeta,
        paymentNumber.isAcceptableOrUnknown(
          data['payment_number']!,
          _paymentNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentNumberMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('amount_poisha')) {
      context.handle(
        _amountPoishaMeta,
        amountPoisha.isAcceptableOrUnknown(
          data['amount_poisha']!,
          _amountPoishaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPoishaMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenancyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenancy_id'],
      )!,
      paymentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_number'],
      )!,
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_date'],
      )!,
      amountPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_poisha'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final String tenancyId;
  final String paymentNumber;
  final DateTime paymentDate;
  final int amountPoisha;
  final String paymentMethod;
  final String? reference;
  final String? note;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Payment({
    required this.id,
    required this.tenancyId,
    required this.paymentNumber,
    required this.paymentDate,
    required this.amountPoisha,
    required this.paymentMethod,
    this.reference,
    this.note,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenancy_id'] = Variable<String>(tenancyId);
    map['payment_number'] = Variable<String>(paymentNumber);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['amount_poisha'] = Variable<int>(amountPoisha);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      tenancyId: Value(tenancyId),
      paymentNumber: Value(paymentNumber),
      paymentDate: Value(paymentDate),
      amountPoisha: Value(amountPoisha),
      paymentMethod: Value(paymentMethod),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      tenancyId: serializer.fromJson<String>(json['tenancyId']),
      paymentNumber: serializer.fromJson<String>(json['paymentNumber']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      amountPoisha: serializer.fromJson<int>(json['amountPoisha']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      reference: serializer.fromJson<String?>(json['reference']),
      note: serializer.fromJson<String?>(json['note']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenancyId': serializer.toJson<String>(tenancyId),
      'paymentNumber': serializer.toJson<String>(paymentNumber),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'amountPoisha': serializer.toJson<int>(amountPoisha),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'reference': serializer.toJson<String?>(reference),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Payment copyWith({
    String? id,
    String? tenancyId,
    String? paymentNumber,
    DateTime? paymentDate,
    int? amountPoisha,
    String? paymentMethod,
    Value<String?> reference = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Payment(
    id: id ?? this.id,
    tenancyId: tenancyId ?? this.tenancyId,
    paymentNumber: paymentNumber ?? this.paymentNumber,
    paymentDate: paymentDate ?? this.paymentDate,
    amountPoisha: amountPoisha ?? this.amountPoisha,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    reference: reference.present ? reference.value : this.reference,
    note: note.present ? note.value : this.note,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      tenancyId: data.tenancyId.present ? data.tenancyId.value : this.tenancyId,
      paymentNumber: data.paymentNumber.present
          ? data.paymentNumber.value
          : this.paymentNumber,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      amountPoisha: data.amountPoisha.present
          ? data.amountPoisha.value
          : this.amountPoisha,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      reference: data.reference.present ? data.reference.value : this.reference,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('paymentNumber: $paymentNumber, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenancyId,
    paymentNumber,
    paymentDate,
    amountPoisha,
    paymentMethod,
    reference,
    note,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.tenancyId == this.tenancyId &&
          other.paymentNumber == this.paymentNumber &&
          other.paymentDate == this.paymentDate &&
          other.amountPoisha == this.amountPoisha &&
          other.paymentMethod == this.paymentMethod &&
          other.reference == this.reference &&
          other.note == this.note &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<String> tenancyId;
  final Value<String> paymentNumber;
  final Value<DateTime> paymentDate;
  final Value<int> amountPoisha;
  final Value<String> paymentMethod;
  final Value<String?> reference;
  final Value<String?> note;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.tenancyId = const Value.absent(),
    this.paymentNumber = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.amountPoisha = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.reference = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String tenancyId,
    required String paymentNumber,
    required DateTime paymentDate,
    required int amountPoisha,
    required String paymentMethod,
    this.reference = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenancyId = Value(tenancyId),
       paymentNumber = Value(paymentNumber),
       paymentDate = Value(paymentDate),
       amountPoisha = Value(amountPoisha),
       paymentMethod = Value(paymentMethod);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<String>? tenancyId,
    Expression<String>? paymentNumber,
    Expression<DateTime>? paymentDate,
    Expression<int>? amountPoisha,
    Expression<String>? paymentMethod,
    Expression<String>? reference,
    Expression<String>? note,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenancyId != null) 'tenancy_id': tenancyId,
      if (paymentNumber != null) 'payment_number': paymentNumber,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (amountPoisha != null) 'amount_poisha': amountPoisha,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (reference != null) 'reference': reference,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenancyId,
    Value<String>? paymentNumber,
    Value<DateTime>? paymentDate,
    Value<int>? amountPoisha,
    Value<String>? paymentMethod,
    Value<String?>? reference,
    Value<String?>? note,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      tenancyId: tenancyId ?? this.tenancyId,
      paymentNumber: paymentNumber ?? this.paymentNumber,
      paymentDate: paymentDate ?? this.paymentDate,
      amountPoisha: amountPoisha ?? this.amountPoisha,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      reference: reference ?? this.reference,
      note: note ?? this.note,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenancyId.present) {
      map['tenancy_id'] = Variable<String>(tenancyId.value);
    }
    if (paymentNumber.present) {
      map['payment_number'] = Variable<String>(paymentNumber.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (amountPoisha.present) {
      map['amount_poisha'] = Variable<int>(amountPoisha.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('paymentNumber: $paymentNumber, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('reference: $reference, ')
          ..write('note: $note, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentAllocationsTable extends PaymentAllocations
    with TableInfo<$PaymentAllocationsTable, PaymentAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payments (id)',
    ),
  );
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<String> billId = GeneratedColumn<String>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_bills (id)',
    ),
  );
  static const VerificationMeta _amountPoishaMeta = const VerificationMeta(
    'amountPoisha',
  );
  @override
  late final GeneratedColumn<int> amountPoisha = GeneratedColumn<int>(
    'amount_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    paymentId,
    billId,
    amountPoisha,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('amount_poisha')) {
      context.handle(
        _amountPoishaMeta,
        amountPoisha.isAcceptableOrUnknown(
          data['amount_poisha']!,
          _amountPoishaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPoishaMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bill_id'],
      )!,
      amountPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_poisha'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentAllocationsTable createAlias(String alias) {
    return $PaymentAllocationsTable(attachedDatabase, alias);
  }
}

class PaymentAllocation extends DataClass
    implements Insertable<PaymentAllocation> {
  final String id;
  final String paymentId;
  final String billId;
  final int amountPoisha;
  final DateTime createdAt;
  const PaymentAllocation({
    required this.id,
    required this.paymentId,
    required this.billId,
    required this.amountPoisha,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payment_id'] = Variable<String>(paymentId);
    map['bill_id'] = Variable<String>(billId);
    map['amount_poisha'] = Variable<int>(amountPoisha);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentAllocationsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAllocationsCompanion(
      id: Value(id),
      paymentId: Value(paymentId),
      billId: Value(billId),
      amountPoisha: Value(amountPoisha),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAllocation(
      id: serializer.fromJson<String>(json['id']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      billId: serializer.fromJson<String>(json['billId']),
      amountPoisha: serializer.fromJson<int>(json['amountPoisha']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paymentId': serializer.toJson<String>(paymentId),
      'billId': serializer.toJson<String>(billId),
      'amountPoisha': serializer.toJson<int>(amountPoisha),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentAllocation copyWith({
    String? id,
    String? paymentId,
    String? billId,
    int? amountPoisha,
    DateTime? createdAt,
  }) => PaymentAllocation(
    id: id ?? this.id,
    paymentId: paymentId ?? this.paymentId,
    billId: billId ?? this.billId,
    amountPoisha: amountPoisha ?? this.amountPoisha,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentAllocation copyWithCompanion(PaymentAllocationsCompanion data) {
    return PaymentAllocation(
      id: data.id.present ? data.id.value : this.id,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      billId: data.billId.present ? data.billId.value : this.billId,
      amountPoisha: data.amountPoisha.present
          ? data.amountPoisha.value
          : this.amountPoisha,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocation(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('billId: $billId, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, paymentId, billId, amountPoisha, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAllocation &&
          other.id == this.id &&
          other.paymentId == this.paymentId &&
          other.billId == this.billId &&
          other.amountPoisha == this.amountPoisha &&
          other.createdAt == this.createdAt);
}

class PaymentAllocationsCompanion extends UpdateCompanion<PaymentAllocation> {
  final Value<String> id;
  final Value<String> paymentId;
  final Value<String> billId;
  final Value<int> amountPoisha;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentAllocationsCompanion({
    this.id = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.billId = const Value.absent(),
    this.amountPoisha = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentAllocationsCompanion.insert({
    required String id,
    required String paymentId,
    required String billId,
    required int amountPoisha,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       paymentId = Value(paymentId),
       billId = Value(billId),
       amountPoisha = Value(amountPoisha);
  static Insertable<PaymentAllocation> custom({
    Expression<String>? id,
    Expression<String>? paymentId,
    Expression<String>? billId,
    Expression<int>? amountPoisha,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paymentId != null) 'payment_id': paymentId,
      if (billId != null) 'bill_id': billId,
      if (amountPoisha != null) 'amount_poisha': amountPoisha,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentAllocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? paymentId,
    Value<String>? billId,
    Value<int>? amountPoisha,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentAllocationsCompanion(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      billId: billId ?? this.billId,
      amountPoisha: amountPoisha ?? this.amountPoisha,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<String>(billId.value);
    }
    if (amountPoisha.present) {
      map['amount_poisha'] = Variable<int>(amountPoisha.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('billId: $billId, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepositsTable extends Deposits with TableInfo<$DepositsTable, Deposit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepositsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenancyIdMeta = const VerificationMeta(
    'tenancyId',
  );
  @override
  late final GeneratedColumn<String> tenancyId = GeneratedColumn<String>(
    'tenancy_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenancies (id)',
    ),
  );
  static const VerificationMeta _openingBalancePoishaMeta =
      const VerificationMeta('openingBalancePoisha');
  @override
  late final GeneratedColumn<int> openingBalancePoisha = GeneratedColumn<int>(
    'opening_balance_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentBalancePoishaMeta =
      const VerificationMeta('currentBalancePoisha');
  @override
  late final GeneratedColumn<int> currentBalancePoisha = GeneratedColumn<int>(
    'current_balance_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenancyId,
    openingBalancePoisha,
    currentBalancePoisha,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deposits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deposit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenancy_id')) {
      context.handle(
        _tenancyIdMeta,
        tenancyId.isAcceptableOrUnknown(data['tenancy_id']!, _tenancyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenancyIdMeta);
    }
    if (data.containsKey('opening_balance_poisha')) {
      context.handle(
        _openingBalancePoishaMeta,
        openingBalancePoisha.isAcceptableOrUnknown(
          data['opening_balance_poisha']!,
          _openingBalancePoishaMeta,
        ),
      );
    }
    if (data.containsKey('current_balance_poisha')) {
      context.handle(
        _currentBalancePoishaMeta,
        currentBalancePoisha.isAcceptableOrUnknown(
          data['current_balance_poisha']!,
          _currentBalancePoishaMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tenancyId},
  ];
  @override
  Deposit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deposit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenancyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenancy_id'],
      )!,
      openingBalancePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}opening_balance_poisha'],
      )!,
      currentBalancePoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_balance_poisha'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DepositsTable createAlias(String alias) {
    return $DepositsTable(attachedDatabase, alias);
  }
}

class Deposit extends DataClass implements Insertable<Deposit> {
  final String id;
  final String tenancyId;
  final int openingBalancePoisha;
  final int currentBalancePoisha;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Deposit({
    required this.id,
    required this.tenancyId,
    required this.openingBalancePoisha,
    required this.currentBalancePoisha,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenancy_id'] = Variable<String>(tenancyId);
    map['opening_balance_poisha'] = Variable<int>(openingBalancePoisha);
    map['current_balance_poisha'] = Variable<int>(currentBalancePoisha);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DepositsCompanion toCompanion(bool nullToAbsent) {
    return DepositsCompanion(
      id: Value(id),
      tenancyId: Value(tenancyId),
      openingBalancePoisha: Value(openingBalancePoisha),
      currentBalancePoisha: Value(currentBalancePoisha),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Deposit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deposit(
      id: serializer.fromJson<String>(json['id']),
      tenancyId: serializer.fromJson<String>(json['tenancyId']),
      openingBalancePoisha: serializer.fromJson<int>(
        json['openingBalancePoisha'],
      ),
      currentBalancePoisha: serializer.fromJson<int>(
        json['currentBalancePoisha'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenancyId': serializer.toJson<String>(tenancyId),
      'openingBalancePoisha': serializer.toJson<int>(openingBalancePoisha),
      'currentBalancePoisha': serializer.toJson<int>(currentBalancePoisha),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Deposit copyWith({
    String? id,
    String? tenancyId,
    int? openingBalancePoisha,
    int? currentBalancePoisha,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Deposit(
    id: id ?? this.id,
    tenancyId: tenancyId ?? this.tenancyId,
    openingBalancePoisha: openingBalancePoisha ?? this.openingBalancePoisha,
    currentBalancePoisha: currentBalancePoisha ?? this.currentBalancePoisha,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Deposit copyWithCompanion(DepositsCompanion data) {
    return Deposit(
      id: data.id.present ? data.id.value : this.id,
      tenancyId: data.tenancyId.present ? data.tenancyId.value : this.tenancyId,
      openingBalancePoisha: data.openingBalancePoisha.present
          ? data.openingBalancePoisha.value
          : this.openingBalancePoisha,
      currentBalancePoisha: data.currentBalancePoisha.present
          ? data.currentBalancePoisha.value
          : this.currentBalancePoisha,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deposit(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('openingBalancePoisha: $openingBalancePoisha, ')
          ..write('currentBalancePoisha: $currentBalancePoisha, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenancyId,
    openingBalancePoisha,
    currentBalancePoisha,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deposit &&
          other.id == this.id &&
          other.tenancyId == this.tenancyId &&
          other.openingBalancePoisha == this.openingBalancePoisha &&
          other.currentBalancePoisha == this.currentBalancePoisha &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DepositsCompanion extends UpdateCompanion<Deposit> {
  final Value<String> id;
  final Value<String> tenancyId;
  final Value<int> openingBalancePoisha;
  final Value<int> currentBalancePoisha;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DepositsCompanion({
    this.id = const Value.absent(),
    this.tenancyId = const Value.absent(),
    this.openingBalancePoisha = const Value.absent(),
    this.currentBalancePoisha = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepositsCompanion.insert({
    required String id,
    required String tenancyId,
    this.openingBalancePoisha = const Value.absent(),
    this.currentBalancePoisha = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenancyId = Value(tenancyId);
  static Insertable<Deposit> custom({
    Expression<String>? id,
    Expression<String>? tenancyId,
    Expression<int>? openingBalancePoisha,
    Expression<int>? currentBalancePoisha,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenancyId != null) 'tenancy_id': tenancyId,
      if (openingBalancePoisha != null)
        'opening_balance_poisha': openingBalancePoisha,
      if (currentBalancePoisha != null)
        'current_balance_poisha': currentBalancePoisha,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepositsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenancyId,
    Value<int>? openingBalancePoisha,
    Value<int>? currentBalancePoisha,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DepositsCompanion(
      id: id ?? this.id,
      tenancyId: tenancyId ?? this.tenancyId,
      openingBalancePoisha: openingBalancePoisha ?? this.openingBalancePoisha,
      currentBalancePoisha: currentBalancePoisha ?? this.currentBalancePoisha,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenancyId.present) {
      map['tenancy_id'] = Variable<String>(tenancyId.value);
    }
    if (openingBalancePoisha.present) {
      map['opening_balance_poisha'] = Variable<int>(openingBalancePoisha.value);
    }
    if (currentBalancePoisha.present) {
      map['current_balance_poisha'] = Variable<int>(currentBalancePoisha.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepositsCompanion(')
          ..write('id: $id, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('openingBalancePoisha: $openingBalancePoisha, ')
          ..write('currentBalancePoisha: $currentBalancePoisha, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepositTransactionsTable extends DepositTransactions
    with TableInfo<$DepositTransactionsTable, DepositTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepositTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depositIdMeta = const VerificationMeta(
    'depositId',
  );
  @override
  late final GeneratedColumn<String> depositId = GeneratedColumn<String>(
    'deposit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES deposits (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPoishaMeta = const VerificationMeta(
    'amountPoisha',
  );
  @override
  late final GeneratedColumn<int> amountPoisha = GeneratedColumn<int>(
    'amount_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    depositId,
    type,
    amountPoisha,
    transactionDate,
    referenceType,
    referenceId,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deposit_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DepositTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('deposit_id')) {
      context.handle(
        _depositIdMeta,
        depositId.isAcceptableOrUnknown(data['deposit_id']!, _depositIdMeta),
      );
    } else if (isInserting) {
      context.missing(_depositIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_poisha')) {
      context.handle(
        _amountPoishaMeta,
        amountPoisha.isAcceptableOrUnknown(
          data['amount_poisha']!,
          _amountPoishaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPoishaMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DepositTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DepositTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      depositId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deposit_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amountPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_poisha'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DepositTransactionsTable createAlias(String alias) {
    return $DepositTransactionsTable(attachedDatabase, alias);
  }
}

class DepositTransaction extends DataClass
    implements Insertable<DepositTransaction> {
  final String id;
  final String depositId;
  final String type;
  final int amountPoisha;
  final DateTime transactionDate;
  final String? referenceType;
  final String? referenceId;
  final String? note;
  final DateTime createdAt;
  const DepositTransaction({
    required this.id,
    required this.depositId,
    required this.type,
    required this.amountPoisha,
    required this.transactionDate,
    this.referenceType,
    this.referenceId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['deposit_id'] = Variable<String>(depositId);
    map['type'] = Variable<String>(type);
    map['amount_poisha'] = Variable<int>(amountPoisha);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DepositTransactionsCompanion toCompanion(bool nullToAbsent) {
    return DepositTransactionsCompanion(
      id: Value(id),
      depositId: Value(depositId),
      type: Value(type),
      amountPoisha: Value(amountPoisha),
      transactionDate: Value(transactionDate),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory DepositTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DepositTransaction(
      id: serializer.fromJson<String>(json['id']),
      depositId: serializer.fromJson<String>(json['depositId']),
      type: serializer.fromJson<String>(json['type']),
      amountPoisha: serializer.fromJson<int>(json['amountPoisha']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'depositId': serializer.toJson<String>(depositId),
      'type': serializer.toJson<String>(type),
      'amountPoisha': serializer.toJson<int>(amountPoisha),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'referenceType': serializer.toJson<String?>(referenceType),
      'referenceId': serializer.toJson<String?>(referenceId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DepositTransaction copyWith({
    String? id,
    String? depositId,
    String? type,
    int? amountPoisha,
    DateTime? transactionDate,
    Value<String?> referenceType = const Value.absent(),
    Value<String?> referenceId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => DepositTransaction(
    id: id ?? this.id,
    depositId: depositId ?? this.depositId,
    type: type ?? this.type,
    amountPoisha: amountPoisha ?? this.amountPoisha,
    transactionDate: transactionDate ?? this.transactionDate,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  DepositTransaction copyWithCompanion(DepositTransactionsCompanion data) {
    return DepositTransaction(
      id: data.id.present ? data.id.value : this.id,
      depositId: data.depositId.present ? data.depositId.value : this.depositId,
      type: data.type.present ? data.type.value : this.type,
      amountPoisha: data.amountPoisha.present
          ? data.amountPoisha.value
          : this.amountPoisha,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DepositTransaction(')
          ..write('id: $id, ')
          ..write('depositId: $depositId, ')
          ..write('type: $type, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    depositId,
    type,
    amountPoisha,
    transactionDate,
    referenceType,
    referenceId,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepositTransaction &&
          other.id == this.id &&
          other.depositId == this.depositId &&
          other.type == this.type &&
          other.amountPoisha == this.amountPoisha &&
          other.transactionDate == this.transactionDate &&
          other.referenceType == this.referenceType &&
          other.referenceId == this.referenceId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class DepositTransactionsCompanion extends UpdateCompanion<DepositTransaction> {
  final Value<String> id;
  final Value<String> depositId;
  final Value<String> type;
  final Value<int> amountPoisha;
  final Value<DateTime> transactionDate;
  final Value<String?> referenceType;
  final Value<String?> referenceId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DepositTransactionsCompanion({
    this.id = const Value.absent(),
    this.depositId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountPoisha = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepositTransactionsCompanion.insert({
    required String id,
    required String depositId,
    required String type,
    required int amountPoisha,
    required DateTime transactionDate,
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       depositId = Value(depositId),
       type = Value(type),
       amountPoisha = Value(amountPoisha),
       transactionDate = Value(transactionDate);
  static Insertable<DepositTransaction> custom({
    Expression<String>? id,
    Expression<String>? depositId,
    Expression<String>? type,
    Expression<int>? amountPoisha,
    Expression<DateTime>? transactionDate,
    Expression<String>? referenceType,
    Expression<String>? referenceId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (depositId != null) 'deposit_id': depositId,
      if (type != null) 'type': type,
      if (amountPoisha != null) 'amount_poisha': amountPoisha,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (referenceType != null) 'reference_type': referenceType,
      if (referenceId != null) 'reference_id': referenceId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepositTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? depositId,
    Value<String>? type,
    Value<int>? amountPoisha,
    Value<DateTime>? transactionDate,
    Value<String?>? referenceType,
    Value<String?>? referenceId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DepositTransactionsCompanion(
      id: id ?? this.id,
      depositId: depositId ?? this.depositId,
      type: type ?? this.type,
      amountPoisha: amountPoisha ?? this.amountPoisha,
      transactionDate: transactionDate ?? this.transactionDate,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (depositId.present) {
      map['deposit_id'] = Variable<String>(depositId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountPoisha.present) {
      map['amount_poisha'] = Variable<int>(amountPoisha.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepositTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('depositId: $depositId, ')
          ..write('type: $type, ')
          ..write('amountPoisha: $amountPoisha, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepairsTable extends Repairs with TableInfo<$RepairsTable, Repair> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _propertyIdMeta = const VerificationMeta(
    'propertyId',
  );
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
    'property_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES properties (id)',
    ),
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES units (id)',
    ),
  );
  static const VerificationMeta _tenancyIdMeta = const VerificationMeta(
    'tenancyId',
  );
  @override
  late final GeneratedColumn<String> tenancyId = GeneratedColumn<String>(
    'tenancy_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tenancies (id)',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportedDateMeta = const VerificationMeta(
    'reportedDate',
  );
  @override
  late final GeneratedColumn<DateTime> reportedDate = GeneratedColumn<DateTime>(
    'reported_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedDateMeta = const VerificationMeta(
    'completedDate',
  );
  @override
  late final GeneratedColumn<DateTime> completedDate =
      GeneratedColumn<DateTime>(
        'completed_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _costPoishaMeta = const VerificationMeta(
    'costPoisha',
  );
  @override
  late final GeneratedColumn<int> costPoisha = GeneratedColumn<int>(
    'cost_poisha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _responsibilityMeta = const VerificationMeta(
    'responsibility',
  );
  @override
  late final GeneratedColumn<String> responsibility = GeneratedColumn<String>(
    'responsibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    propertyId,
    unitId,
    tenancyId,
    category,
    title,
    description,
    reportedDate,
    completedDate,
    costPoisha,
    responsibility,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repairs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Repair> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
        _propertyIdMeta,
        propertyId.isAcceptableOrUnknown(data['property_id']!, _propertyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('tenancy_id')) {
      context.handle(
        _tenancyIdMeta,
        tenancyId.isAcceptableOrUnknown(data['tenancy_id']!, _tenancyIdMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('reported_date')) {
      context.handle(
        _reportedDateMeta,
        reportedDate.isAcceptableOrUnknown(
          data['reported_date']!,
          _reportedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportedDateMeta);
    }
    if (data.containsKey('completed_date')) {
      context.handle(
        _completedDateMeta,
        completedDate.isAcceptableOrUnknown(
          data['completed_date']!,
          _completedDateMeta,
        ),
      );
    }
    if (data.containsKey('cost_poisha')) {
      context.handle(
        _costPoishaMeta,
        costPoisha.isAcceptableOrUnknown(data['cost_poisha']!, _costPoishaMeta),
      );
    }
    if (data.containsKey('responsibility')) {
      context.handle(
        _responsibilityMeta,
        responsibility.isAcceptableOrUnknown(
          data['responsibility']!,
          _responsibilityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_responsibilityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repair map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repair(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      propertyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}property_id'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      ),
      tenancyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenancy_id'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      reportedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_date'],
      )!,
      completedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_date'],
      ),
      costPoisha: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_poisha'],
      )!,
      responsibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}responsibility'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RepairsTable createAlias(String alias) {
    return $RepairsTable(attachedDatabase, alias);
  }
}

class Repair extends DataClass implements Insertable<Repair> {
  final String id;
  final String propertyId;
  final String? unitId;
  final String? tenancyId;
  final String category;
  final String title;
  final String? description;
  final DateTime reportedDate;
  final DateTime? completedDate;
  final int costPoisha;
  final String responsibility;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Repair({
    required this.id,
    required this.propertyId,
    this.unitId,
    this.tenancyId,
    required this.category,
    required this.title,
    this.description,
    required this.reportedDate,
    this.completedDate,
    required this.costPoisha,
    required this.responsibility,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<String>(unitId);
    }
    if (!nullToAbsent || tenancyId != null) {
      map['tenancy_id'] = Variable<String>(tenancyId);
    }
    map['category'] = Variable<String>(category);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['reported_date'] = Variable<DateTime>(reportedDate);
    if (!nullToAbsent || completedDate != null) {
      map['completed_date'] = Variable<DateTime>(completedDate);
    }
    map['cost_poisha'] = Variable<int>(costPoisha);
    map['responsibility'] = Variable<String>(responsibility);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RepairsCompanion toCompanion(bool nullToAbsent) {
    return RepairsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      tenancyId: tenancyId == null && nullToAbsent
          ? const Value.absent()
          : Value(tenancyId),
      category: Value(category),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      reportedDate: Value(reportedDate),
      completedDate: completedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDate),
      costPoisha: Value(costPoisha),
      responsibility: Value(responsibility),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Repair.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repair(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      unitId: serializer.fromJson<String?>(json['unitId']),
      tenancyId: serializer.fromJson<String?>(json['tenancyId']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      reportedDate: serializer.fromJson<DateTime>(json['reportedDate']),
      completedDate: serializer.fromJson<DateTime?>(json['completedDate']),
      costPoisha: serializer.fromJson<int>(json['costPoisha']),
      responsibility: serializer.fromJson<String>(json['responsibility']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'unitId': serializer.toJson<String?>(unitId),
      'tenancyId': serializer.toJson<String?>(tenancyId),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'reportedDate': serializer.toJson<DateTime>(reportedDate),
      'completedDate': serializer.toJson<DateTime?>(completedDate),
      'costPoisha': serializer.toJson<int>(costPoisha),
      'responsibility': serializer.toJson<String>(responsibility),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Repair copyWith({
    String? id,
    String? propertyId,
    Value<String?> unitId = const Value.absent(),
    Value<String?> tenancyId = const Value.absent(),
    String? category,
    String? title,
    Value<String?> description = const Value.absent(),
    DateTime? reportedDate,
    Value<DateTime?> completedDate = const Value.absent(),
    int? costPoisha,
    String? responsibility,
    String? status,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Repair(
    id: id ?? this.id,
    propertyId: propertyId ?? this.propertyId,
    unitId: unitId.present ? unitId.value : this.unitId,
    tenancyId: tenancyId.present ? tenancyId.value : this.tenancyId,
    category: category ?? this.category,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    reportedDate: reportedDate ?? this.reportedDate,
    completedDate: completedDate.present
        ? completedDate.value
        : this.completedDate,
    costPoisha: costPoisha ?? this.costPoisha,
    responsibility: responsibility ?? this.responsibility,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Repair copyWithCompanion(RepairsCompanion data) {
    return Repair(
      id: data.id.present ? data.id.value : this.id,
      propertyId: data.propertyId.present
          ? data.propertyId.value
          : this.propertyId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      tenancyId: data.tenancyId.present ? data.tenancyId.value : this.tenancyId,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      reportedDate: data.reportedDate.present
          ? data.reportedDate.value
          : this.reportedDate,
      completedDate: data.completedDate.present
          ? data.completedDate.value
          : this.completedDate,
      costPoisha: data.costPoisha.present
          ? data.costPoisha.value
          : this.costPoisha,
      responsibility: data.responsibility.present
          ? data.responsibility.value
          : this.responsibility,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repair(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('unitId: $unitId, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reportedDate: $reportedDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('costPoisha: $costPoisha, ')
          ..write('responsibility: $responsibility, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    propertyId,
    unitId,
    tenancyId,
    category,
    title,
    description,
    reportedDate,
    completedDate,
    costPoisha,
    responsibility,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repair &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.unitId == this.unitId &&
          other.tenancyId == this.tenancyId &&
          other.category == this.category &&
          other.title == this.title &&
          other.description == this.description &&
          other.reportedDate == this.reportedDate &&
          other.completedDate == this.completedDate &&
          other.costPoisha == this.costPoisha &&
          other.responsibility == this.responsibility &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RepairsCompanion extends UpdateCompanion<Repair> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String?> unitId;
  final Value<String?> tenancyId;
  final Value<String> category;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> reportedDate;
  final Value<DateTime?> completedDate;
  final Value<int> costPoisha;
  final Value<String> responsibility;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RepairsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.tenancyId = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.reportedDate = const Value.absent(),
    this.completedDate = const Value.absent(),
    this.costPoisha = const Value.absent(),
    this.responsibility = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepairsCompanion.insert({
    required String id,
    required String propertyId,
    this.unitId = const Value.absent(),
    this.tenancyId = const Value.absent(),
    required String category,
    required String title,
    this.description = const Value.absent(),
    required DateTime reportedDate,
    this.completedDate = const Value.absent(),
    this.costPoisha = const Value.absent(),
    required String responsibility,
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       propertyId = Value(propertyId),
       category = Value(category),
       title = Value(title),
       reportedDate = Value(reportedDate),
       responsibility = Value(responsibility);
  static Insertable<Repair> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? unitId,
    Expression<String>? tenancyId,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? reportedDate,
    Expression<DateTime>? completedDate,
    Expression<int>? costPoisha,
    Expression<String>? responsibility,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (unitId != null) 'unit_id': unitId,
      if (tenancyId != null) 'tenancy_id': tenancyId,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (reportedDate != null) 'reported_date': reportedDate,
      if (completedDate != null) 'completed_date': completedDate,
      if (costPoisha != null) 'cost_poisha': costPoisha,
      if (responsibility != null) 'responsibility': responsibility,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepairsCompanion copyWith({
    Value<String>? id,
    Value<String>? propertyId,
    Value<String?>? unitId,
    Value<String?>? tenancyId,
    Value<String>? category,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime>? reportedDate,
    Value<DateTime?>? completedDate,
    Value<int>? costPoisha,
    Value<String>? responsibility,
    Value<String>? status,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RepairsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      unitId: unitId ?? this.unitId,
      tenancyId: tenancyId ?? this.tenancyId,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      reportedDate: reportedDate ?? this.reportedDate,
      completedDate: completedDate ?? this.completedDate,
      costPoisha: costPoisha ?? this.costPoisha,
      responsibility: responsibility ?? this.responsibility,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (tenancyId.present) {
      map['tenancy_id'] = Variable<String>(tenancyId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reportedDate.present) {
      map['reported_date'] = Variable<DateTime>(reportedDate.value);
    }
    if (completedDate.present) {
      map['completed_date'] = Variable<DateTime>(completedDate.value);
    }
    if (costPoisha.present) {
      map['cost_poisha'] = Variable<int>(costPoisha.value);
    }
    if (responsibility.present) {
      map['responsibility'] = Variable<String>(responsibility.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('unitId: $unitId, ')
          ..write('tenancyId: $tenancyId, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('reportedDate: $reportedDate, ')
          ..write('completedDate: $completedDate, ')
          ..write('costPoisha: $costPoisha, ')
          ..write('responsibility: $responsibility, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepairAttachmentsTable extends RepairAttachments
    with TableInfo<$RepairAttachmentsTable, RepairAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repairIdMeta = const VerificationMeta(
    'repairId',
  );
  @override
  late final GeneratedColumn<String> repairId = GeneratedColumn<String>(
    'repair_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repairs (id)',
    ),
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    repairId,
    fileName,
    relativePath,
    mimeType,
    fileSize,
    checksum,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairAttachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('repair_id')) {
      context.handle(
        _repairIdMeta,
        repairId.isAcceptableOrUnknown(data['repair_id']!, _repairIdMeta),
      );
    } else if (isInserting) {
      context.missing(_repairIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairAttachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      repairId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}repair_id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      ),
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RepairAttachmentsTable createAlias(String alias) {
    return $RepairAttachmentsTable(attachedDatabase, alias);
  }
}

class RepairAttachment extends DataClass
    implements Insertable<RepairAttachment> {
  final String id;
  final String repairId;
  final String fileName;
  final String relativePath;
  final String? mimeType;
  final int? fileSize;
  final String? checksum;
  final DateTime createdAt;
  const RepairAttachment({
    required this.id,
    required this.repairId,
    required this.fileName,
    required this.relativePath,
    this.mimeType,
    this.fileSize,
    this.checksum,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['repair_id'] = Variable<String>(repairId);
    map['file_name'] = Variable<String>(fileName);
    map['relative_path'] = Variable<String>(relativePath);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RepairAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return RepairAttachmentsCompanion(
      id: Value(id),
      repairId: Value(repairId),
      fileName: Value(fileName),
      relativePath: Value(relativePath),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
      checksum: checksum == null && nullToAbsent
          ? const Value.absent()
          : Value(checksum),
      createdAt: Value(createdAt),
    );
  }

  factory RepairAttachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairAttachment(
      id: serializer.fromJson<String>(json['id']),
      repairId: serializer.fromJson<String>(json['repairId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      fileSize: serializer.fromJson<int?>(json['fileSize']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'repairId': serializer.toJson<String>(repairId),
      'fileName': serializer.toJson<String>(fileName),
      'relativePath': serializer.toJson<String>(relativePath),
      'mimeType': serializer.toJson<String?>(mimeType),
      'fileSize': serializer.toJson<int?>(fileSize),
      'checksum': serializer.toJson<String?>(checksum),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RepairAttachment copyWith({
    String? id,
    String? repairId,
    String? fileName,
    String? relativePath,
    Value<String?> mimeType = const Value.absent(),
    Value<int?> fileSize = const Value.absent(),
    Value<String?> checksum = const Value.absent(),
    DateTime? createdAt,
  }) => RepairAttachment(
    id: id ?? this.id,
    repairId: repairId ?? this.repairId,
    fileName: fileName ?? this.fileName,
    relativePath: relativePath ?? this.relativePath,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    fileSize: fileSize.present ? fileSize.value : this.fileSize,
    checksum: checksum.present ? checksum.value : this.checksum,
    createdAt: createdAt ?? this.createdAt,
  );
  RepairAttachment copyWithCompanion(RepairAttachmentsCompanion data) {
    return RepairAttachment(
      id: data.id.present ? data.id.value : this.id,
      repairId: data.repairId.present ? data.repairId.value : this.repairId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairAttachment(')
          ..write('id: $id, ')
          ..write('repairId: $repairId, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('checksum: $checksum, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    repairId,
    fileName,
    relativePath,
    mimeType,
    fileSize,
    checksum,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairAttachment &&
          other.id == this.id &&
          other.repairId == this.repairId &&
          other.fileName == this.fileName &&
          other.relativePath == this.relativePath &&
          other.mimeType == this.mimeType &&
          other.fileSize == this.fileSize &&
          other.checksum == this.checksum &&
          other.createdAt == this.createdAt);
}

class RepairAttachmentsCompanion extends UpdateCompanion<RepairAttachment> {
  final Value<String> id;
  final Value<String> repairId;
  final Value<String> fileName;
  final Value<String> relativePath;
  final Value<String?> mimeType;
  final Value<int?> fileSize;
  final Value<String?> checksum;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RepairAttachmentsCompanion({
    this.id = const Value.absent(),
    this.repairId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.checksum = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepairAttachmentsCompanion.insert({
    required String id,
    required String repairId,
    required String fileName,
    required String relativePath,
    this.mimeType = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.checksum = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       repairId = Value(repairId),
       fileName = Value(fileName),
       relativePath = Value(relativePath);
  static Insertable<RepairAttachment> custom({
    Expression<String>? id,
    Expression<String>? repairId,
    Expression<String>? fileName,
    Expression<String>? relativePath,
    Expression<String>? mimeType,
    Expression<int>? fileSize,
    Expression<String>? checksum,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairId != null) 'repair_id': repairId,
      if (fileName != null) 'file_name': fileName,
      if (relativePath != null) 'relative_path': relativePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileSize != null) 'file_size': fileSize,
      if (checksum != null) 'checksum': checksum,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepairAttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? repairId,
    Value<String>? fileName,
    Value<String>? relativePath,
    Value<String?>? mimeType,
    Value<int?>? fileSize,
    Value<String?>? checksum,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RepairAttachmentsCompanion(
      id: id ?? this.id,
      repairId: repairId ?? this.repairId,
      fileName: fileName ?? this.fileName,
      relativePath: relativePath ?? this.relativePath,
      mimeType: mimeType ?? this.mimeType,
      fileSize: fileSize ?? this.fileSize,
      checksum: checksum ?? this.checksum,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (repairId.present) {
      map['repair_id'] = Variable<String>(repairId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('repairId: $repairId, ')
          ..write('fileName: $fileName, ')
          ..write('relativePath: $relativePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('checksum: $checksum, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, valueJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String valueJson;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.valueJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? valueJson, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        valueJson: valueJson ?? this.valueJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String valueJson,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       valueJson = Value(valueJson);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? valueJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditEventsTable extends AuditEvents
    with TableInfo<$AuditEventsTable, AuditEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _beforeJsonMeta = const VerificationMeta(
    'beforeJson',
  );
  @override
  late final GeneratedColumn<String> beforeJson = GeneratedColumn<String>(
    'before_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _afterJsonMeta = const VerificationMeta(
    'afterJson',
  );
  @override
  late final GeneratedColumn<String> afterJson = GeneratedColumn<String>(
    'after_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    action,
    summary,
    beforeJson,
    afterJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('before_json')) {
      context.handle(
        _beforeJsonMeta,
        beforeJson.isAcceptableOrUnknown(data['before_json']!, _beforeJsonMeta),
      );
    }
    if (data.containsKey('after_json')) {
      context.handle(
        _afterJsonMeta,
        afterJson.isAcceptableOrUnknown(data['after_json']!, _afterJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      beforeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}before_json'],
      ),
      afterJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}after_json'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditEventsTable createAlias(String alias) {
    return $AuditEventsTable(attachedDatabase, alias);
  }
}

class AuditEvent extends DataClass implements Insertable<AuditEvent> {
  final String id;
  final String entityType;
  final String entityId;
  final String action;
  final String summary;
  final String? beforeJson;
  final String? afterJson;
  final DateTime createdAt;
  const AuditEvent({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.summary,
    this.beforeJson,
    this.afterJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['action'] = Variable<String>(action);
    map['summary'] = Variable<String>(summary);
    if (!nullToAbsent || beforeJson != null) {
      map['before_json'] = Variable<String>(beforeJson);
    }
    if (!nullToAbsent || afterJson != null) {
      map['after_json'] = Variable<String>(afterJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditEventsCompanion toCompanion(bool nullToAbsent) {
    return AuditEventsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      action: Value(action),
      summary: Value(summary),
      beforeJson: beforeJson == null && nullToAbsent
          ? const Value.absent()
          : Value(beforeJson),
      afterJson: afterJson == null && nullToAbsent
          ? const Value.absent()
          : Value(afterJson),
      createdAt: Value(createdAt),
    );
  }

  factory AuditEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditEvent(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      summary: serializer.fromJson<String>(json['summary']),
      beforeJson: serializer.fromJson<String?>(json['beforeJson']),
      afterJson: serializer.fromJson<String?>(json['afterJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'action': serializer.toJson<String>(action),
      'summary': serializer.toJson<String>(summary),
      'beforeJson': serializer.toJson<String?>(beforeJson),
      'afterJson': serializer.toJson<String?>(afterJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditEvent copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? action,
    String? summary,
    Value<String?> beforeJson = const Value.absent(),
    Value<String?> afterJson = const Value.absent(),
    DateTime? createdAt,
  }) => AuditEvent(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    action: action ?? this.action,
    summary: summary ?? this.summary,
    beforeJson: beforeJson.present ? beforeJson.value : this.beforeJson,
    afterJson: afterJson.present ? afterJson.value : this.afterJson,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditEvent copyWithCompanion(AuditEventsCompanion data) {
    return AuditEvent(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      summary: data.summary.present ? data.summary.value : this.summary,
      beforeJson: data.beforeJson.present
          ? data.beforeJson.value
          : this.beforeJson,
      afterJson: data.afterJson.present ? data.afterJson.value : this.afterJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditEvent(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('summary: $summary, ')
          ..write('beforeJson: $beforeJson, ')
          ..write('afterJson: $afterJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    action,
    summary,
    beforeJson,
    afterJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditEvent &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.summary == this.summary &&
          other.beforeJson == this.beforeJson &&
          other.afterJson == this.afterJson &&
          other.createdAt == this.createdAt);
}

class AuditEventsCompanion extends UpdateCompanion<AuditEvent> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> action;
  final Value<String> summary;
  final Value<String?> beforeJson;
  final Value<String?> afterJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditEventsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.summary = const Value.absent(),
    this.beforeJson = const Value.absent(),
    this.afterJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditEventsCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String action,
    required String summary,
    this.beforeJson = const Value.absent(),
    this.afterJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       action = Value(action),
       summary = Value(summary);
  static Insertable<AuditEvent> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? action,
    Expression<String>? summary,
    Expression<String>? beforeJson,
    Expression<String>? afterJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (summary != null) 'summary': summary,
      if (beforeJson != null) 'before_json': beforeJson,
      if (afterJson != null) 'after_json': afterJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? action,
    Value<String>? summary,
    Value<String?>? beforeJson,
    Value<String?>? afterJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AuditEventsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      summary: summary ?? this.summary,
      beforeJson: beforeJson ?? this.beforeJson,
      afterJson: afterJson ?? this.afterJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (beforeJson.present) {
      map['before_json'] = Variable<String>(beforeJson.value);
    }
    if (afterJson.present) {
      map['after_json'] = Variable<String>(afterJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditEventsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('summary: $summary, ')
          ..write('beforeJson: $beforeJson, ')
          ..write('afterJson: $afterJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchemaMetadataTable extends SchemaMetadata
    with TableInfo<$SchemaMetadataTable, SchemaMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchemaMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMigrationAtMeta = const VerificationMeta(
    'lastMigrationAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMigrationAt =
      GeneratedColumn<DateTime>(
        'last_migration_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastMigrationErrorMeta =
      const VerificationMeta('lastMigrationError');
  @override
  late final GeneratedColumn<String> lastMigrationError =
      GeneratedColumn<String>(
        'last_migration_error',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    schemaVersion,
    lastMigrationAt,
    lastMigrationError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schema_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SchemaMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaVersionMeta);
    }
    if (data.containsKey('last_migration_at')) {
      context.handle(
        _lastMigrationAtMeta,
        lastMigrationAt.isAcceptableOrUnknown(
          data['last_migration_at']!,
          _lastMigrationAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastMigrationAtMeta);
    }
    if (data.containsKey('last_migration_error')) {
      context.handle(
        _lastMigrationErrorMeta,
        lastMigrationError.isAcceptableOrUnknown(
          data['last_migration_error']!,
          _lastMigrationErrorMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SchemaMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchemaMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
      lastMigrationAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_migration_at'],
      )!,
      lastMigrationError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_migration_error'],
      ),
    );
  }

  @override
  $SchemaMetadataTable createAlias(String alias) {
    return $SchemaMetadataTable(attachedDatabase, alias);
  }
}

class SchemaMetadataData extends DataClass
    implements Insertable<SchemaMetadataData> {
  final String id;
  final int schemaVersion;
  final DateTime lastMigrationAt;
  final String? lastMigrationError;
  const SchemaMetadataData({
    required this.id,
    required this.schemaVersion,
    required this.lastMigrationAt,
    this.lastMigrationError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['schema_version'] = Variable<int>(schemaVersion);
    map['last_migration_at'] = Variable<DateTime>(lastMigrationAt);
    if (!nullToAbsent || lastMigrationError != null) {
      map['last_migration_error'] = Variable<String>(lastMigrationError);
    }
    return map;
  }

  SchemaMetadataCompanion toCompanion(bool nullToAbsent) {
    return SchemaMetadataCompanion(
      id: Value(id),
      schemaVersion: Value(schemaVersion),
      lastMigrationAt: Value(lastMigrationAt),
      lastMigrationError: lastMigrationError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMigrationError),
    );
  }

  factory SchemaMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchemaMetadataData(
      id: serializer.fromJson<String>(json['id']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
      lastMigrationAt: serializer.fromJson<DateTime>(json['lastMigrationAt']),
      lastMigrationError: serializer.fromJson<String?>(
        json['lastMigrationError'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
      'lastMigrationAt': serializer.toJson<DateTime>(lastMigrationAt),
      'lastMigrationError': serializer.toJson<String?>(lastMigrationError),
    };
  }

  SchemaMetadataData copyWith({
    String? id,
    int? schemaVersion,
    DateTime? lastMigrationAt,
    Value<String?> lastMigrationError = const Value.absent(),
  }) => SchemaMetadataData(
    id: id ?? this.id,
    schemaVersion: schemaVersion ?? this.schemaVersion,
    lastMigrationAt: lastMigrationAt ?? this.lastMigrationAt,
    lastMigrationError: lastMigrationError.present
        ? lastMigrationError.value
        : this.lastMigrationError,
  );
  SchemaMetadataData copyWithCompanion(SchemaMetadataCompanion data) {
    return SchemaMetadataData(
      id: data.id.present ? data.id.value : this.id,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
      lastMigrationAt: data.lastMigrationAt.present
          ? data.lastMigrationAt.value
          : this.lastMigrationAt,
      lastMigrationError: data.lastMigrationError.present
          ? data.lastMigrationError.value
          : this.lastMigrationError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMetadataData(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('lastMigrationAt: $lastMigrationAt, ')
          ..write('lastMigrationError: $lastMigrationError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, schemaVersion, lastMigrationAt, lastMigrationError);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchemaMetadataData &&
          other.id == this.id &&
          other.schemaVersion == this.schemaVersion &&
          other.lastMigrationAt == this.lastMigrationAt &&
          other.lastMigrationError == this.lastMigrationError);
}

class SchemaMetadataCompanion extends UpdateCompanion<SchemaMetadataData> {
  final Value<String> id;
  final Value<int> schemaVersion;
  final Value<DateTime> lastMigrationAt;
  final Value<String?> lastMigrationError;
  final Value<int> rowid;
  const SchemaMetadataCompanion({
    this.id = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.lastMigrationAt = const Value.absent(),
    this.lastMigrationError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchemaMetadataCompanion.insert({
    required String id,
    required int schemaVersion,
    required DateTime lastMigrationAt,
    this.lastMigrationError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       schemaVersion = Value(schemaVersion),
       lastMigrationAt = Value(lastMigrationAt);
  static Insertable<SchemaMetadataData> custom({
    Expression<String>? id,
    Expression<int>? schemaVersion,
    Expression<DateTime>? lastMigrationAt,
    Expression<String>? lastMigrationError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (lastMigrationAt != null) 'last_migration_at': lastMigrationAt,
      if (lastMigrationError != null)
        'last_migration_error': lastMigrationError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchemaMetadataCompanion copyWith({
    Value<String>? id,
    Value<int>? schemaVersion,
    Value<DateTime>? lastMigrationAt,
    Value<String?>? lastMigrationError,
    Value<int>? rowid,
  }) {
    return SchemaMetadataCompanion(
      id: id ?? this.id,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      lastMigrationAt: lastMigrationAt ?? this.lastMigrationAt,
      lastMigrationError: lastMigrationError ?? this.lastMigrationError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (lastMigrationAt.present) {
      map['last_migration_at'] = Variable<DateTime>(lastMigrationAt.value);
    }
    if (lastMigrationError.present) {
      map['last_migration_error'] = Variable<String>(lastMigrationError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMetadataCompanion(')
          ..write('id: $id, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('lastMigrationAt: $lastMigrationAt, ')
          ..write('lastMigrationError: $lastMigrationError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $UnitsTable units = $UnitsTable(this);
  late final $TenantsTable tenants = $TenantsTable(this);
  late final $TenanciesTable tenancies = $TenanciesTable(this);
  late final $RecurringChargeRulesTable recurringChargeRules =
      $RecurringChargeRulesTable(this);
  late final $UtilityMeterConfigsTable utilityMeterConfigs =
      $UtilityMeterConfigsTable(this);
  late final $MonthlyBillsTable monthlyBills = $MonthlyBillsTable(this);
  late final $BillLineItemsTable billLineItems = $BillLineItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $PaymentAllocationsTable paymentAllocations =
      $PaymentAllocationsTable(this);
  late final $DepositsTable deposits = $DepositsTable(this);
  late final $DepositTransactionsTable depositTransactions =
      $DepositTransactionsTable(this);
  late final $RepairsTable repairs = $RepairsTable(this);
  late final $RepairAttachmentsTable repairAttachments =
      $RepairAttachmentsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $AuditEventsTable auditEvents = $AuditEventsTable(this);
  late final $SchemaMetadataTable schemaMetadata = $SchemaMetadataTable(this);
  late final Index unitsPropertyIdIdx = Index(
    'units_property_id_idx',
    'CREATE INDEX units_property_id_idx ON units (property_id)',
  );
  late final Index tenantsStatusIdx = Index(
    'tenants_status_idx',
    'CREATE INDEX tenants_status_idx ON tenants (status)',
  );
  late final Index tenanciesTenantIdIdx = Index(
    'tenancies_tenant_id_idx',
    'CREATE INDEX tenancies_tenant_id_idx ON tenancies (tenant_id)',
  );
  late final Index tenanciesUnitIdIdx = Index(
    'tenancies_unit_id_idx',
    'CREATE INDEX tenancies_unit_id_idx ON tenancies (unit_id)',
  );
  late final Index chargeRulesTenancyIdIdx = Index(
    'charge_rules_tenancy_id_idx',
    'CREATE INDEX charge_rules_tenancy_id_idx ON recurring_charge_rules (tenancy_id)',
  );
  late final Index meterConfigsUnitIdIdx = Index(
    'meter_configs_unit_id_idx',
    'CREATE INDEX meter_configs_unit_id_idx ON utility_meter_configs (unit_id)',
  );
  late final Index billsTenancyIdIdx = Index(
    'bills_tenancy_id_idx',
    'CREATE INDEX bills_tenancy_id_idx ON monthly_bills (tenancy_id)',
  );
  late final Index billsMonthIdx = Index(
    'bills_month_idx',
    'CREATE INDEX bills_month_idx ON monthly_bills (billing_year, billing_month)',
  );
  late final Index billsStatusIdx = Index(
    'bills_status_idx',
    'CREATE INDEX bills_status_idx ON monthly_bills (status)',
  );
  late final Index billItemsBillIdIdx = Index(
    'bill_items_bill_id_idx',
    'CREATE INDEX bill_items_bill_id_idx ON bill_line_items (bill_id)',
  );
  late final Index paymentsTenancyIdIdx = Index(
    'payments_tenancy_id_idx',
    'CREATE INDEX payments_tenancy_id_idx ON payments (tenancy_id)',
  );
  late final Index paymentsDateIdx = Index(
    'payments_date_idx',
    'CREATE INDEX payments_date_idx ON payments (payment_date)',
  );
  late final Index paymentAllocationsPaymentIdIdx = Index(
    'payment_allocations_payment_id_idx',
    'CREATE INDEX payment_allocations_payment_id_idx ON payment_allocations (payment_id)',
  );
  late final Index paymentAllocationsBillIdIdx = Index(
    'payment_allocations_bill_id_idx',
    'CREATE INDEX payment_allocations_bill_id_idx ON payment_allocations (bill_id)',
  );
  late final Index depositsTenancyIdIdx = Index(
    'deposits_tenancy_id_idx',
    'CREATE INDEX deposits_tenancy_id_idx ON deposits (tenancy_id)',
  );
  late final Index depositTransactionsDepositIdIdx = Index(
    'deposit_transactions_deposit_id_idx',
    'CREATE INDEX deposit_transactions_deposit_id_idx ON deposit_transactions (deposit_id)',
  );
  late final Index repairsPropertyIdIdx = Index(
    'repairs_property_id_idx',
    'CREATE INDEX repairs_property_id_idx ON repairs (property_id)',
  );
  late final Index repairsUnitIdIdx = Index(
    'repairs_unit_id_idx',
    'CREATE INDEX repairs_unit_id_idx ON repairs (unit_id)',
  );
  late final Index repairAttachmentsRepairIdIdx = Index(
    'repair_attachments_repair_id_idx',
    'CREATE INDEX repair_attachments_repair_id_idx ON repair_attachments (repair_id)',
  );
  late final Index auditEventsCreatedAtIdx = Index(
    'audit_events_created_at_idx',
    'CREATE INDEX audit_events_created_at_idx ON audit_events (created_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    properties,
    units,
    tenants,
    tenancies,
    recurringChargeRules,
    utilityMeterConfigs,
    monthlyBills,
    billLineItems,
    payments,
    paymentAllocations,
    deposits,
    depositTransactions,
    repairs,
    repairAttachments,
    appSettings,
    auditEvents,
    schemaMetadata,
    unitsPropertyIdIdx,
    tenantsStatusIdx,
    tenanciesTenantIdIdx,
    tenanciesUnitIdIdx,
    chargeRulesTenancyIdIdx,
    meterConfigsUnitIdIdx,
    billsTenancyIdIdx,
    billsMonthIdx,
    billsStatusIdx,
    billItemsBillIdIdx,
    paymentsTenancyIdIdx,
    paymentsDateIdx,
    paymentAllocationsPaymentIdIdx,
    paymentAllocationsBillIdIdx,
    depositsTenancyIdIdx,
    depositTransactionsDepositIdIdx,
    repairsPropertyIdIdx,
    repairsUnitIdIdx,
    repairAttachmentsRepairIdIdx,
    auditEventsCreatedAtIdx,
  ];
}

typedef $$PropertiesTableCreateCompanionBuilder = PropertiesCompanion Function({
  required String id,
  required String name,
  Value<String> propertyType,
  Value<String?> nickname,
  Value<String?> addressLine,
  Value<String?> area,
  Value<String?> cityDistrict,
  Value<String?> ownerName,
  Value<String?> ownerPhone,
  Value<String?> notes,
  Value<String> status,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PropertiesTableUpdateCompanionBuilder = PropertiesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> propertyType,
  Value<String?> nickname,
  Value<String?> addressLine,
  Value<String?> area,
  Value<String?> cityDistrict,
  Value<String?> ownerName,
  Value<String?> ownerPhone,
  Value<String?> notes,
  Value<String> status,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UnitsTable, List<Unit>> _unitsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.units,
    aliasName: 'properties__id__units__property_id',
  );

  $$UnitsTableProcessedTableManager get unitsRefs {
    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_unitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyBillsTable, List<MonthlyBill>>
  _monthlyBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyBills,
    aliasName: 'properties__id__monthly_bills__property_id',
  );

  $$MonthlyBillsTableProcessedTableManager get monthlyBillsRefs {
    final manager = $$MonthlyBillsTableTableManager(
      $_db,
      $_db.monthlyBills,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_monthlyBillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RepairsTable, List<Repair>> _repairsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.repairs,
    aliasName: 'properties__id__repairs__property_id',
  );

  $$RepairsTableProcessedTableManager get repairsRefs {
    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get propertyType => $composableBuilder(
    column: $table.propertyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityDistrict => $composableBuilder(
    column: $table.cityDistrict,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> unitsRefs(
    Expression<bool> Function($$UnitsTableFilterComposer f) f,
  ) {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyBillsRefs(
    Expression<bool> Function($$MonthlyBillsTableFilterComposer f) f,
  ) {
    final $$MonthlyBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repairsRefs(
    Expression<bool> Function($$RepairsTableFilterComposer f) f,
  ) {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get propertyType => $composableBuilder(
    column: $table.propertyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityDistrict => $composableBuilder(
    column: $table.cityDistrict,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get propertyType => $composableBuilder(
    column: $table.propertyType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get cityDistrict => $composableBuilder(
    column: $table.cityDistrict,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get ownerPhone => $composableBuilder(
    column: $table.ownerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> unitsRefs<T extends Object>(
    Expression<T> Function($$UnitsTableAnnotationComposer a) f,
  ) {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> monthlyBillsRefs<T extends Object>(
    Expression<T> Function($$MonthlyBillsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repairsRefs<T extends Object>(
    Expression<T> Function($$RepairsTableAnnotationComposer a) f,
  ) {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.propertyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PropertiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PropertiesTable,
          Property,
          $$PropertiesTableFilterComposer,
          $$PropertiesTableOrderingComposer,
          $$PropertiesTableAnnotationComposer,
          $$PropertiesTableCreateCompanionBuilder,
          $$PropertiesTableUpdateCompanionBuilder,
          (Property, $$PropertiesTableReferences),
          Property,
          PrefetchHooks Function({
            bool unitsRefs,
            bool monthlyBillsRefs,
            bool repairsRefs,
          })
        > {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> propertyType = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String?> addressLine = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> cityDistrict = const Value.absent(),
                Value<String?> ownerName = const Value.absent(),
                Value<String?> ownerPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion(
                id: id,
                name: name,
                propertyType: propertyType,
                nickname: nickname,
                addressLine: addressLine,
                area: area,
                cityDistrict: cityDistrict,
                ownerName: ownerName,
                ownerPhone: ownerPhone,
                notes: notes,
                status: status,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> propertyType = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String?> addressLine = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> cityDistrict = const Value.absent(),
                Value<String?> ownerName = const Value.absent(),
                Value<String?> ownerPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PropertiesCompanion.insert(
                id: id,
                name: name,
                propertyType: propertyType,
                nickname: nickname,
                addressLine: addressLine,
                area: area,
                cityDistrict: cityDistrict,
                ownerName: ownerName,
                ownerPhone: ownerPhone,
                notes: notes,
                status: status,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PropertiesTable, Property>(table),
                  $$PropertiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                unitsRefs = false,
                monthlyBillsRefs = false,
                repairsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (unitsRefs) db.units,
                    if (monthlyBillsRefs) db.monthlyBills,
                    if (repairsRefs) db.repairs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (unitsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Unit
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._unitsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).unitsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyBillsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          MonthlyBill
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._monthlyBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyBillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairsRefs)
                        await $_getPrefetchedData<
                          Property,
                          $PropertiesTable,
                          Repair
                        >(
                          currentTable: table,
                          referencedTable: $$PropertiesTableReferences
                              ._repairsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PropertiesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.propertyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PropertiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PropertiesTable,
      Property,
      $$PropertiesTableFilterComposer,
      $$PropertiesTableOrderingComposer,
      $$PropertiesTableAnnotationComposer,
      $$PropertiesTableCreateCompanionBuilder,
      $$PropertiesTableUpdateCompanionBuilder,
      (Property, $$PropertiesTableReferences),
      Property,
      PrefetchHooks Function({
        bool unitsRefs,
        bool monthlyBillsRefs,
        bool repairsRefs,
      })
    >;
typedef $$UnitsTableCreateCompanionBuilder = UnitsCompanion Function({
  required String id,
  required String propertyId,
  required String name,
  Value<String?> floorName,
  Value<String> unitType,
  Value<int?> bedrooms,
  Value<int> defaultRentPoisha,
  Value<int> defaultServiceChargePoisha,
  Value<int> defaultGasChargePoisha,
  Value<int> defaultWaterChargePoisha,
  Value<String> occupancyStatus,
  Value<String?> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$UnitsTableUpdateCompanionBuilder = UnitsCompanion Function({
  Value<String> id,
  Value<String> propertyId,
  Value<String> name,
  Value<String?> floorName,
  Value<String> unitType,
  Value<int?> bedrooms,
  Value<int> defaultRentPoisha,
  Value<int> defaultServiceChargePoisha,
  Value<int> defaultGasChargePoisha,
  Value<int> defaultWaterChargePoisha,
  Value<String> occupancyStatus,
  Value<String?> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$UnitsTableReferences
    extends BaseReferences<_$AppDatabase, $UnitsTable, Unit> {
  $$UnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('units__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TenanciesTable, List<Tenancy>>
  _tenanciesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tenancies,
    aliasName: 'units__id__tenancies__unit_id',
  );

  $$TenanciesTableProcessedTableManager get tenanciesRefs {
    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tenanciesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UtilityMeterConfigsTable,
    List<UtilityMeterConfig>
  >
  _utilityMeterConfigsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.utilityMeterConfigs,
        aliasName: 'units__id__utility_meter_configs__unit_id',
      );

  $$UtilityMeterConfigsTableProcessedTableManager get utilityMeterConfigsRefs {
    final manager = $$UtilityMeterConfigsTableTableManager(
      $_db,
      $_db.utilityMeterConfigs,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _utilityMeterConfigsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyBillsTable, List<MonthlyBill>>
  _monthlyBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyBills,
    aliasName: 'units__id__monthly_bills__unit_id',
  );

  $$MonthlyBillsTableProcessedTableManager get monthlyBillsRefs {
    final manager = $$MonthlyBillsTableTableManager(
      $_db,
      $_db.monthlyBills,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_monthlyBillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RepairsTable, List<Repair>> _repairsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.repairs,
    aliasName: 'units__id__repairs__unit_id',
  );

  $$RepairsTableProcessedTableManager get repairsRefs {
    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UnitsTableFilterComposer extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get floorName => $composableBuilder(
    column: $table.floorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedrooms => $composableBuilder(
    column: $table.bedrooms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultRentPoisha => $composableBuilder(
    column: $table.defaultRentPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultServiceChargePoisha => $composableBuilder(
    column: $table.defaultServiceChargePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultGasChargePoisha => $composableBuilder(
    column: $table.defaultGasChargePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultWaterChargePoisha => $composableBuilder(
    column: $table.defaultWaterChargePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occupancyStatus => $composableBuilder(
    column: $table.occupancyStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tenanciesRefs(
    Expression<bool> Function($$TenanciesTableFilterComposer f) f,
  ) {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> utilityMeterConfigsRefs(
    Expression<bool> Function($$UtilityMeterConfigsTableFilterComposer f) f,
  ) {
    final $$UtilityMeterConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utilityMeterConfigs,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilityMeterConfigsTableFilterComposer(
            $db: $db,
            $table: $db.utilityMeterConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyBillsRefs(
    Expression<bool> Function($$MonthlyBillsTableFilterComposer f) f,
  ) {
    final $$MonthlyBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repairsRefs(
    Expression<bool> Function($$RepairsTableFilterComposer f) f,
  ) {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get floorName => $composableBuilder(
    column: $table.floorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedrooms => $composableBuilder(
    column: $table.bedrooms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultRentPoisha => $composableBuilder(
    column: $table.defaultRentPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultServiceChargePoisha => $composableBuilder(
    column: $table.defaultServiceChargePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultGasChargePoisha => $composableBuilder(
    column: $table.defaultGasChargePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultWaterChargePoisha => $composableBuilder(
    column: $table.defaultWaterChargePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occupancyStatus => $composableBuilder(
    column: $table.occupancyStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UnitsTable> {
  $$UnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get floorName =>
      $composableBuilder(column: $table.floorName, builder: (column) => column);

  GeneratedColumn<String> get unitType =>
      $composableBuilder(column: $table.unitType, builder: (column) => column);

  GeneratedColumn<int> get bedrooms =>
      $composableBuilder(column: $table.bedrooms, builder: (column) => column);

  GeneratedColumn<int> get defaultRentPoisha => $composableBuilder(
    column: $table.defaultRentPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultServiceChargePoisha => $composableBuilder(
    column: $table.defaultServiceChargePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultGasChargePoisha => $composableBuilder(
    column: $table.defaultGasChargePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultWaterChargePoisha => $composableBuilder(
    column: $table.defaultWaterChargePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<String> get occupancyStatus => $composableBuilder(
    column: $table.occupancyStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tenanciesRefs<T extends Object>(
    Expression<T> Function($$TenanciesTableAnnotationComposer a) f,
  ) {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> utilityMeterConfigsRefs<T extends Object>(
    Expression<T> Function($$UtilityMeterConfigsTableAnnotationComposer a) f,
  ) {
    final $$UtilityMeterConfigsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.utilityMeterConfigs,
          getReferencedColumn: (t) => t.unitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UtilityMeterConfigsTableAnnotationComposer(
                $db: $db,
                $table: $db.utilityMeterConfigs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> monthlyBillsRefs<T extends Object>(
    Expression<T> Function($$MonthlyBillsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repairsRefs<T extends Object>(
    Expression<T> Function($$RepairsTableAnnotationComposer a) f,
  ) {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UnitsTable,
          Unit,
          $$UnitsTableFilterComposer,
          $$UnitsTableOrderingComposer,
          $$UnitsTableAnnotationComposer,
          $$UnitsTableCreateCompanionBuilder,
          $$UnitsTableUpdateCompanionBuilder,
          (Unit, $$UnitsTableReferences),
          Unit,
          PrefetchHooks Function({
            bool propertyId,
            bool tenanciesRefs,
            bool utilityMeterConfigsRefs,
            bool monthlyBillsRefs,
            bool repairsRefs,
          })
        > {
  $$UnitsTableTableManager(_$AppDatabase db, $UnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> floorName = const Value.absent(),
                Value<String> unitType = const Value.absent(),
                Value<int?> bedrooms = const Value.absent(),
                Value<int> defaultRentPoisha = const Value.absent(),
                Value<int> defaultServiceChargePoisha = const Value.absent(),
                Value<int> defaultGasChargePoisha = const Value.absent(),
                Value<int> defaultWaterChargePoisha = const Value.absent(),
                Value<String> occupancyStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion(
                id: id,
                propertyId: propertyId,
                name: name,
                floorName: floorName,
                unitType: unitType,
                bedrooms: bedrooms,
                defaultRentPoisha: defaultRentPoisha,
                defaultServiceChargePoisha: defaultServiceChargePoisha,
                defaultGasChargePoisha: defaultGasChargePoisha,
                defaultWaterChargePoisha: defaultWaterChargePoisha,
                occupancyStatus: occupancyStatus,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                required String name,
                Value<String?> floorName = const Value.absent(),
                Value<String> unitType = const Value.absent(),
                Value<int?> bedrooms = const Value.absent(),
                Value<int> defaultRentPoisha = const Value.absent(),
                Value<int> defaultServiceChargePoisha = const Value.absent(),
                Value<int> defaultGasChargePoisha = const Value.absent(),
                Value<int> defaultWaterChargePoisha = const Value.absent(),
                Value<String> occupancyStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UnitsCompanion.insert(
                id: id,
                propertyId: propertyId,
                name: name,
                floorName: floorName,
                unitType: unitType,
                bedrooms: bedrooms,
                defaultRentPoisha: defaultRentPoisha,
                defaultServiceChargePoisha: defaultServiceChargePoisha,
                defaultGasChargePoisha: defaultGasChargePoisha,
                defaultWaterChargePoisha: defaultWaterChargePoisha,
                occupancyStatus: occupancyStatus,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UnitsTable, Unit>(table),
                  $$UnitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                propertyId = false,
                tenanciesRefs = false,
                utilityMeterConfigsRefs = false,
                monthlyBillsRefs = false,
                repairsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tenanciesRefs) db.tenancies,
                    if (utilityMeterConfigsRefs) db.utilityMeterConfigs,
                    if (monthlyBillsRefs) db.monthlyBills,
                    if (repairsRefs) db.repairs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (propertyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.propertyId,
                            referencedTable: $$UnitsTableReferences
                                ._propertyIdTable(db),
                            referencedColumn: $$UnitsTableReferences
                                ._propertyIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tenanciesRefs)
                        await $_getPrefetchedData<Unit, $UnitsTable, Tenancy>(
                          currentTable: table,
                          referencedTable: $$UnitsTableReferences
                              ._tenanciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UnitsTableReferences(
                                db,
                                table,
                                p0,
                              ).tenanciesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.unitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (utilityMeterConfigsRefs)
                        await $_getPrefetchedData<
                          Unit,
                          $UnitsTable,
                          UtilityMeterConfig
                        >(
                          currentTable: table,
                          referencedTable: $$UnitsTableReferences
                              ._utilityMeterConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UnitsTableReferences(
                                db,
                                table,
                                p0,
                              ).utilityMeterConfigsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.unitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyBillsRefs)
                        await $_getPrefetchedData<
                          Unit,
                          $UnitsTable,
                          MonthlyBill
                        >(
                          currentTable: table,
                          referencedTable: $$UnitsTableReferences
                              ._monthlyBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UnitsTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyBillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.unitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairsRefs)
                        await $_getPrefetchedData<Unit, $UnitsTable, Repair>(
                          currentTable: table,
                          referencedTable: $$UnitsTableReferences
                              ._repairsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UnitsTableReferences(db, table, p0).repairsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.unitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UnitsTable,
      Unit,
      $$UnitsTableFilterComposer,
      $$UnitsTableOrderingComposer,
      $$UnitsTableAnnotationComposer,
      $$UnitsTableCreateCompanionBuilder,
      $$UnitsTableUpdateCompanionBuilder,
      (Unit, $$UnitsTableReferences),
      Unit,
      PrefetchHooks Function({
        bool propertyId,
        bool tenanciesRefs,
        bool utilityMeterConfigsRefs,
        bool monthlyBillsRefs,
        bool repairsRefs,
      })
    >;
typedef $$TenantsTableCreateCompanionBuilder = TenantsCompanion Function({
  required String id,
  required String fullName,
  Value<String?> banglaName,
  required String phone,
  Value<String?> alternativePhone,
  Value<String?> email,
  Value<String?> nidNumber,
  Value<String?> permanentAddress,
  Value<String?> emergencyContactName,
  Value<String?> emergencyContactPhone,
  Value<String?> photoPath,
  Value<String> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$TenantsTableUpdateCompanionBuilder = TenantsCompanion Function({
  Value<String> id,
  Value<String> fullName,
  Value<String?> banglaName,
  Value<String> phone,
  Value<String?> alternativePhone,
  Value<String?> email,
  Value<String?> nidNumber,
  Value<String?> permanentAddress,
  Value<String?> emergencyContactName,
  Value<String?> emergencyContactPhone,
  Value<String?> photoPath,
  Value<String> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TenantsTableReferences
    extends BaseReferences<_$AppDatabase, $TenantsTable, Tenant> {
  $$TenantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TenanciesTable, List<Tenancy>>
  _tenanciesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tenancies,
    aliasName: 'tenants__id__tenancies__tenant_id',
  );

  $$TenanciesTableProcessedTableManager get tenanciesRefs {
    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.tenantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tenanciesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TenantsTableFilterComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get banglaName => $composableBuilder(
    column: $table.banglaName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternativePhone => $composableBuilder(
    column: $table.alternativePhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nidNumber => $composableBuilder(
    column: $table.nidNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tenanciesRefs(
    Expression<bool> Function($$TenanciesTableFilterComposer f) f,
  ) {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.tenantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenantsTableOrderingComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get banglaName => $composableBuilder(
    column: $table.banglaName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternativePhone => $composableBuilder(
    column: $table.alternativePhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nidNumber => $composableBuilder(
    column: $table.nidNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TenantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenantsTable> {
  $$TenantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get banglaName => $composableBuilder(
    column: $table.banglaName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get alternativePhone => $composableBuilder(
    column: $table.alternativePhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get nidNumber =>
      $composableBuilder(column: $table.nidNumber, builder: (column) => column);

  GeneratedColumn<String> get permanentAddress => $composableBuilder(
    column: $table.permanentAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> tenanciesRefs<T extends Object>(
    Expression<T> Function($$TenanciesTableAnnotationComposer a) f,
  ) {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.tenantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenantsTable,
          Tenant,
          $$TenantsTableFilterComposer,
          $$TenantsTableOrderingComposer,
          $$TenantsTableAnnotationComposer,
          $$TenantsTableCreateCompanionBuilder,
          $$TenantsTableUpdateCompanionBuilder,
          (Tenant, $$TenantsTableReferences),
          Tenant,
          PrefetchHooks Function({bool tenanciesRefs})
        > {
  $$TenantsTableTableManager(_$AppDatabase db, $TenantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> banglaName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String?> alternativePhone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> nidNumber = const Value.absent(),
                Value<String?> permanentAddress = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenantsCompanion(
                id: id,
                fullName: fullName,
                banglaName: banglaName,
                phone: phone,
                alternativePhone: alternativePhone,
                email: email,
                nidNumber: nidNumber,
                permanentAddress: permanentAddress,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                photoPath: photoPath,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                Value<String?> banglaName = const Value.absent(),
                required String phone,
                Value<String?> alternativePhone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> nidNumber = const Value.absent(),
                Value<String?> permanentAddress = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenantsCompanion.insert(
                id: id,
                fullName: fullName,
                banglaName: banglaName,
                phone: phone,
                alternativePhone: alternativePhone,
                email: email,
                nidNumber: nidNumber,
                permanentAddress: permanentAddress,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                photoPath: photoPath,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TenantsTable, Tenant>(table),
                  $$TenantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tenanciesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tenanciesRefs) db.tenancies],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tenanciesRefs)
                    await $_getPrefetchedData<Tenant, $TenantsTable, Tenancy>(
                      currentTable: table,
                      referencedTable: $$TenantsTableReferences
                          ._tenanciesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TenantsTableReferences(db, table, p0).tenanciesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tenantId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TenantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenantsTable,
      Tenant,
      $$TenantsTableFilterComposer,
      $$TenantsTableOrderingComposer,
      $$TenantsTableAnnotationComposer,
      $$TenantsTableCreateCompanionBuilder,
      $$TenantsTableUpdateCompanionBuilder,
      (Tenant, $$TenantsTableReferences),
      Tenant,
      PrefetchHooks Function({bool tenanciesRefs})
    >;
typedef $$TenanciesTableCreateCompanionBuilder = TenanciesCompanion Function({
  required String id,
  required String tenantId,
  required String unitId,
  required DateTime moveInDate,
  Value<DateTime?> expectedMoveOutDate,
  Value<DateTime?> actualMoveOutDate,
  Value<int> agreedRentPoisha,
  Value<int> billingDay,
  Value<int> securityDepositTargetPoisha,
  Value<int> advanceRentPoisha,
  Value<String?> agreementNotes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$TenanciesTableUpdateCompanionBuilder = TenanciesCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> unitId,
  Value<DateTime> moveInDate,
  Value<DateTime?> expectedMoveOutDate,
  Value<DateTime?> actualMoveOutDate,
  Value<int> agreedRentPoisha,
  Value<int> billingDay,
  Value<int> securityDepositTargetPoisha,
  Value<int> advanceRentPoisha,
  Value<String?> agreementNotes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TenanciesTableReferences
    extends BaseReferences<_$AppDatabase, $TenanciesTable, Tenancy> {
  $$TenanciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TenantsTable _tenantIdTable(_$AppDatabase db) =>
      db.tenants.createAlias('tenancies__tenant_id__tenants__id');

  $$TenantsTableProcessedTableManager get tenantId {
    final $_column = $_itemColumn<String>('tenant_id')!;

    final manager = $$TenantsTableTableManager(
      $_db,
      $_db.tenants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('tenancies__unit_id__units__id');

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $RecurringChargeRulesTable,
    List<RecurringChargeRule>
  >
  _recurringChargeRulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurringChargeRules,
        aliasName: 'tenancies__id__recurring_charge_rules__tenancy_id',
      );

  $$RecurringChargeRulesTableProcessedTableManager
  get recurringChargeRulesRefs {
    final manager = $$RecurringChargeRulesTableTableManager(
      $_db,
      $_db.recurringChargeRules,
    ).filter((f) => f.tenancyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurringChargeRulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyBillsTable, List<MonthlyBill>>
  _monthlyBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyBills,
    aliasName: 'tenancies__id__monthly_bills__tenancy_id',
  );

  $$MonthlyBillsTableProcessedTableManager get monthlyBillsRefs {
    final manager = $$MonthlyBillsTableTableManager(
      $_db,
      $_db.monthlyBills,
    ).filter((f) => f.tenancyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_monthlyBillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'tenancies__id__payments__tenancy_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.tenancyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepositsTable, List<Deposit>> _depositsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.deposits,
    aliasName: 'tenancies__id__deposits__tenancy_id',
  );

  $$DepositsTableProcessedTableManager get depositsRefs {
    final manager = $$DepositsTableTableManager(
      $_db,
      $_db.deposits,
    ).filter((f) => f.tenancyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_depositsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RepairsTable, List<Repair>> _repairsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.repairs,
    aliasName: 'tenancies__id__repairs__tenancy_id',
  );

  $$RepairsTableProcessedTableManager get repairsRefs {
    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.tenancyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TenanciesTableFilterComposer
    extends Composer<_$AppDatabase, $TenanciesTable> {
  $$TenanciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get moveInDate => $composableBuilder(
    column: $table.moveInDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedMoveOutDate => $composableBuilder(
    column: $table.expectedMoveOutDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualMoveOutDate => $composableBuilder(
    column: $table.actualMoveOutDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agreedRentPoisha => $composableBuilder(
    column: $table.agreedRentPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get securityDepositTargetPoisha => $composableBuilder(
    column: $table.securityDepositTargetPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get advanceRentPoisha => $composableBuilder(
    column: $table.advanceRentPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agreementNotes => $composableBuilder(
    column: $table.agreementNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenantsTableFilterComposer get tenantId {
    final $$TenantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableFilterComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recurringChargeRulesRefs(
    Expression<bool> Function($$RecurringChargeRulesTableFilterComposer f) f,
  ) {
    final $$RecurringChargeRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recurringChargeRules,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurringChargeRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurringChargeRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyBillsRefs(
    Expression<bool> Function($$MonthlyBillsTableFilterComposer f) f,
  ) {
    final $$MonthlyBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> depositsRefs(
    Expression<bool> Function($$DepositsTableFilterComposer f) f,
  ) {
    final $$DepositsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableFilterComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repairsRefs(
    Expression<bool> Function($$RepairsTableFilterComposer f) f,
  ) {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenanciesTableOrderingComposer
    extends Composer<_$AppDatabase, $TenanciesTable> {
  $$TenanciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get moveInDate => $composableBuilder(
    column: $table.moveInDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedMoveOutDate => $composableBuilder(
    column: $table.expectedMoveOutDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualMoveOutDate => $composableBuilder(
    column: $table.actualMoveOutDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agreedRentPoisha => $composableBuilder(
    column: $table.agreedRentPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get securityDepositTargetPoisha => $composableBuilder(
    column: $table.securityDepositTargetPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get advanceRentPoisha => $composableBuilder(
    column: $table.advanceRentPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agreementNotes => $composableBuilder(
    column: $table.agreementNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenantsTableOrderingComposer get tenantId {
    final $$TenantsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableOrderingComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableOrderingComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TenanciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TenanciesTable> {
  $$TenanciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get moveInDate => $composableBuilder(
    column: $table.moveInDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expectedMoveOutDate => $composableBuilder(
    column: $table.expectedMoveOutDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get actualMoveOutDate => $composableBuilder(
    column: $table.actualMoveOutDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get agreedRentPoisha => $composableBuilder(
    column: $table.agreedRentPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get billingDay => $composableBuilder(
    column: $table.billingDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get securityDepositTargetPoisha => $composableBuilder(
    column: $table.securityDepositTargetPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get advanceRentPoisha => $composableBuilder(
    column: $table.advanceRentPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<String> get agreementNotes => $composableBuilder(
    column: $table.agreementNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenantsTableAnnotationComposer get tenantId {
    final $$TenantsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantId,
      referencedTable: $db.tenants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenantsTableAnnotationComposer(
            $db: $db,
            $table: $db.tenants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recurringChargeRulesRefs<T extends Object>(
    Expression<T> Function($$RecurringChargeRulesTableAnnotationComposer a) f,
  ) {
    final $$RecurringChargeRulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurringChargeRules,
          getReferencedColumn: (t) => t.tenancyId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurringChargeRulesTableAnnotationComposer(
                $db: $db,
                $table: $db.recurringChargeRules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> monthlyBillsRefs<T extends Object>(
    Expression<T> Function($$MonthlyBillsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> depositsRefs<T extends Object>(
    Expression<T> Function($$DepositsTableAnnotationComposer a) f,
  ) {
    final $$DepositsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableAnnotationComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repairsRefs<T extends Object>(
    Expression<T> Function($$RepairsTableAnnotationComposer a) f,
  ) {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.tenancyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TenanciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TenanciesTable,
          Tenancy,
          $$TenanciesTableFilterComposer,
          $$TenanciesTableOrderingComposer,
          $$TenanciesTableAnnotationComposer,
          $$TenanciesTableCreateCompanionBuilder,
          $$TenanciesTableUpdateCompanionBuilder,
          (Tenancy, $$TenanciesTableReferences),
          Tenancy,
          PrefetchHooks Function({
            bool tenantId,
            bool unitId,
            bool recurringChargeRulesRefs,
            bool monthlyBillsRefs,
            bool paymentsRefs,
            bool depositsRefs,
            bool repairsRefs,
          })
        > {
  $$TenanciesTableTableManager(_$AppDatabase db, $TenanciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TenanciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TenanciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TenanciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<DateTime> moveInDate = const Value.absent(),
                Value<DateTime?> expectedMoveOutDate = const Value.absent(),
                Value<DateTime?> actualMoveOutDate = const Value.absent(),
                Value<int> agreedRentPoisha = const Value.absent(),
                Value<int> billingDay = const Value.absent(),
                Value<int> securityDepositTargetPoisha = const Value.absent(),
                Value<int> advanceRentPoisha = const Value.absent(),
                Value<String?> agreementNotes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenanciesCompanion(
                id: id,
                tenantId: tenantId,
                unitId: unitId,
                moveInDate: moveInDate,
                expectedMoveOutDate: expectedMoveOutDate,
                actualMoveOutDate: actualMoveOutDate,
                agreedRentPoisha: agreedRentPoisha,
                billingDay: billingDay,
                securityDepositTargetPoisha: securityDepositTargetPoisha,
                advanceRentPoisha: advanceRentPoisha,
                agreementNotes: agreementNotes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String unitId,
                required DateTime moveInDate,
                Value<DateTime?> expectedMoveOutDate = const Value.absent(),
                Value<DateTime?> actualMoveOutDate = const Value.absent(),
                Value<int> agreedRentPoisha = const Value.absent(),
                Value<int> billingDay = const Value.absent(),
                Value<int> securityDepositTargetPoisha = const Value.absent(),
                Value<int> advanceRentPoisha = const Value.absent(),
                Value<String?> agreementNotes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TenanciesCompanion.insert(
                id: id,
                tenantId: tenantId,
                unitId: unitId,
                moveInDate: moveInDate,
                expectedMoveOutDate: expectedMoveOutDate,
                actualMoveOutDate: actualMoveOutDate,
                agreedRentPoisha: agreedRentPoisha,
                billingDay: billingDay,
                securityDepositTargetPoisha: securityDepositTargetPoisha,
                advanceRentPoisha: advanceRentPoisha,
                agreementNotes: agreementNotes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TenanciesTable, Tenancy>(table),
                  $$TenanciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tenantId = false,
                unitId = false,
                recurringChargeRulesRefs = false,
                monthlyBillsRefs = false,
                paymentsRefs = false,
                depositsRefs = false,
                repairsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurringChargeRulesRefs) db.recurringChargeRules,
                    if (monthlyBillsRefs) db.monthlyBills,
                    if (paymentsRefs) db.payments,
                    if (depositsRefs) db.deposits,
                    if (repairsRefs) db.repairs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tenantId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tenantId,
                            referencedTable: $$TenanciesTableReferences
                                ._tenantIdTable(db),
                            referencedColumn: $$TenanciesTableReferences
                                ._tenantIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (unitId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.unitId,
                            referencedTable: $$TenanciesTableReferences
                                ._unitIdTable(db),
                            referencedColumn: $$TenanciesTableReferences
                                ._unitIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurringChargeRulesRefs)
                        await $_getPrefetchedData<
                          Tenancy,
                          $TenanciesTable,
                          RecurringChargeRule
                        >(
                          currentTable: table,
                          referencedTable: $$TenanciesTableReferences
                              ._recurringChargeRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).recurringChargeRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenancyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyBillsRefs)
                        await $_getPrefetchedData<
                          Tenancy,
                          $TenanciesTable,
                          MonthlyBill
                        >(
                          currentTable: table,
                          referencedTable: $$TenanciesTableReferences
                              ._monthlyBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyBillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenancyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Tenancy,
                          $TenanciesTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$TenanciesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenancyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (depositsRefs)
                        await $_getPrefetchedData<
                          Tenancy,
                          $TenanciesTable,
                          Deposit
                        >(
                          currentTable: table,
                          referencedTable: $$TenanciesTableReferences
                              ._depositsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).depositsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenancyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairsRefs)
                        await $_getPrefetchedData<
                          Tenancy,
                          $TenanciesTable,
                          Repair
                        >(
                          currentTable: table,
                          referencedTable: $$TenanciesTableReferences
                              ._repairsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TenanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tenancyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TenanciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TenanciesTable,
      Tenancy,
      $$TenanciesTableFilterComposer,
      $$TenanciesTableOrderingComposer,
      $$TenanciesTableAnnotationComposer,
      $$TenanciesTableCreateCompanionBuilder,
      $$TenanciesTableUpdateCompanionBuilder,
      (Tenancy, $$TenanciesTableReferences),
      Tenancy,
      PrefetchHooks Function({
        bool tenantId,
        bool unitId,
        bool recurringChargeRulesRefs,
        bool monthlyBillsRefs,
        bool paymentsRefs,
        bool depositsRefs,
        bool repairsRefs,
      })
    >;
typedef $$RecurringChargeRulesTableCreateCompanionBuilder =
    RecurringChargeRulesCompanion Function({
      required String id,
      required String tenancyId,
      required String chargeType,
      required String calculationMethod,
      Value<int> fixedAmountPoisha,
      Value<int?> ratePoisha,
      required DateTime effectiveFrom,
      Value<DateTime?> effectiveTo,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$RecurringChargeRulesTableUpdateCompanionBuilder =
    RecurringChargeRulesCompanion Function({
      Value<String> id,
      Value<String> tenancyId,
      Value<String> chargeType,
      Value<String> calculationMethod,
      Value<int> fixedAmountPoisha,
      Value<int?> ratePoisha,
      Value<DateTime> effectiveFrom,
      Value<DateTime?> effectiveTo,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RecurringChargeRulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurringChargeRulesTable,
          RecurringChargeRule
        > {
  $$RecurringChargeRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TenanciesTable _tenancyIdTable(_$AppDatabase db) => db.tenancies
      .createAlias('recurring_charge_rules__tenancy_id__tenancies__id');

  $$TenanciesTableProcessedTableManager get tenancyId {
    final $_column = $_itemColumn<String>('tenancy_id')!;

    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenancyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecurringChargeRulesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringChargeRulesTable> {
  $$RecurringChargeRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chargeType => $composableBuilder(
    column: $table.chargeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculationMethod => $composableBuilder(
    column: $table.calculationMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixedAmountPoisha => $composableBuilder(
    column: $table.fixedAmountPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePoisha => $composableBuilder(
    column: $table.ratePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenanciesTableFilterComposer get tenancyId {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringChargeRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringChargeRulesTable> {
  $$RecurringChargeRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chargeType => $composableBuilder(
    column: $table.chargeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculationMethod => $composableBuilder(
    column: $table.calculationMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixedAmountPoisha => $composableBuilder(
    column: $table.fixedAmountPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePoisha => $composableBuilder(
    column: $table.ratePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenanciesTableOrderingComposer get tenancyId {
    final $$TenanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableOrderingComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringChargeRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringChargeRulesTable> {
  $$RecurringChargeRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get chargeType => $composableBuilder(
    column: $table.chargeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get calculationMethod => $composableBuilder(
    column: $table.calculationMethod,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fixedAmountPoisha => $composableBuilder(
    column: $table.fixedAmountPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ratePoisha => $composableBuilder(
    column: $table.ratePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get effectiveTo => $composableBuilder(
    column: $table.effectiveTo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenanciesTableAnnotationComposer get tenancyId {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurringChargeRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringChargeRulesTable,
          RecurringChargeRule,
          $$RecurringChargeRulesTableFilterComposer,
          $$RecurringChargeRulesTableOrderingComposer,
          $$RecurringChargeRulesTableAnnotationComposer,
          $$RecurringChargeRulesTableCreateCompanionBuilder,
          $$RecurringChargeRulesTableUpdateCompanionBuilder,
          (RecurringChargeRule, $$RecurringChargeRulesTableReferences),
          RecurringChargeRule,
          PrefetchHooks Function({bool tenancyId})
        > {
  $$RecurringChargeRulesTableTableManager(
    _$AppDatabase db,
    $RecurringChargeRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringChargeRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringChargeRulesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurringChargeRulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenancyId = const Value.absent(),
                Value<String> chargeType = const Value.absent(),
                Value<String> calculationMethod = const Value.absent(),
                Value<int> fixedAmountPoisha = const Value.absent(),
                Value<int?> ratePoisha = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
                Value<DateTime?> effectiveTo = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringChargeRulesCompanion(
                id: id,
                tenancyId: tenancyId,
                chargeType: chargeType,
                calculationMethod: calculationMethod,
                fixedAmountPoisha: fixedAmountPoisha,
                ratePoisha: ratePoisha,
                effectiveFrom: effectiveFrom,
                effectiveTo: effectiveTo,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenancyId,
                required String chargeType,
                required String calculationMethod,
                Value<int> fixedAmountPoisha = const Value.absent(),
                Value<int?> ratePoisha = const Value.absent(),
                required DateTime effectiveFrom,
                Value<DateTime?> effectiveTo = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringChargeRulesCompanion.insert(
                id: id,
                tenancyId: tenancyId,
                chargeType: chargeType,
                calculationMethod: calculationMethod,
                fixedAmountPoisha: fixedAmountPoisha,
                ratePoisha: ratePoisha,
                effectiveFrom: effectiveFrom,
                effectiveTo: effectiveTo,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecurringChargeRulesTable, RecurringChargeRule>(
                    table,
                  ),
                  $$RecurringChargeRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tenancyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tenancyId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tenancyId,
                        referencedTable: $$RecurringChargeRulesTableReferences
                            ._tenancyIdTable(db),
                        referencedColumn: $$RecurringChargeRulesTableReferences
                            ._tenancyIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecurringChargeRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringChargeRulesTable,
      RecurringChargeRule,
      $$RecurringChargeRulesTableFilterComposer,
      $$RecurringChargeRulesTableOrderingComposer,
      $$RecurringChargeRulesTableAnnotationComposer,
      $$RecurringChargeRulesTableCreateCompanionBuilder,
      $$RecurringChargeRulesTableUpdateCompanionBuilder,
      (RecurringChargeRule, $$RecurringChargeRulesTableReferences),
      RecurringChargeRule,
      PrefetchHooks Function({bool tenancyId})
    >;
typedef $$UtilityMeterConfigsTableCreateCompanionBuilder =
    UtilityMeterConfigsCompanion Function({
      required String id,
      required String unitId,
      Value<String?> meterNumber,
      required String billingMode,
      Value<int> ratePerUnitPoisha,
      Value<int> additionalChargePoisha,
      Value<int> initialReading,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$UtilityMeterConfigsTableUpdateCompanionBuilder =
    UtilityMeterConfigsCompanion Function({
      Value<String> id,
      Value<String> unitId,
      Value<String?> meterNumber,
      Value<String> billingMode,
      Value<int> ratePerUnitPoisha,
      Value<int> additionalChargePoisha,
      Value<int> initialReading,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UtilityMeterConfigsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UtilityMeterConfigsTable,
          UtilityMeterConfig
        > {
  $$UtilityMeterConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('utility_meter_configs__unit_id__units__id');

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtilityMeterConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $UtilityMeterConfigsTable> {
  $$UtilityMeterConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePerUnitPoisha => $composableBuilder(
    column: $table.ratePerUnitPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get additionalChargePoisha => $composableBuilder(
    column: $table.additionalChargePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialReading => $composableBuilder(
    column: $table.initialReading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityMeterConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $UtilityMeterConfigsTable> {
  $$UtilityMeterConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePerUnitPoisha => $composableBuilder(
    column: $table.ratePerUnitPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get additionalChargePoisha => $composableBuilder(
    column: $table.additionalChargePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialReading => $composableBuilder(
    column: $table.initialReading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableOrderingComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityMeterConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtilityMeterConfigsTable> {
  $$UtilityMeterConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meterNumber => $composableBuilder(
    column: $table.meterNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get billingMode => $composableBuilder(
    column: $table.billingMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ratePerUnitPoisha => $composableBuilder(
    column: $table.ratePerUnitPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get additionalChargePoisha => $composableBuilder(
    column: $table.additionalChargePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get initialReading => $composableBuilder(
    column: $table.initialReading,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityMeterConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtilityMeterConfigsTable,
          UtilityMeterConfig,
          $$UtilityMeterConfigsTableFilterComposer,
          $$UtilityMeterConfigsTableOrderingComposer,
          $$UtilityMeterConfigsTableAnnotationComposer,
          $$UtilityMeterConfigsTableCreateCompanionBuilder,
          $$UtilityMeterConfigsTableUpdateCompanionBuilder,
          (UtilityMeterConfig, $$UtilityMeterConfigsTableReferences),
          UtilityMeterConfig,
          PrefetchHooks Function({bool unitId})
        > {
  $$UtilityMeterConfigsTableTableManager(
    _$AppDatabase db,
    $UtilityMeterConfigsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtilityMeterConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtilityMeterConfigsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UtilityMeterConfigsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<String?> meterNumber = const Value.absent(),
                Value<String> billingMode = const Value.absent(),
                Value<int> ratePerUnitPoisha = const Value.absent(),
                Value<int> additionalChargePoisha = const Value.absent(),
                Value<int> initialReading = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilityMeterConfigsCompanion(
                id: id,
                unitId: unitId,
                meterNumber: meterNumber,
                billingMode: billingMode,
                ratePerUnitPoisha: ratePerUnitPoisha,
                additionalChargePoisha: additionalChargePoisha,
                initialReading: initialReading,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String unitId,
                Value<String?> meterNumber = const Value.absent(),
                required String billingMode,
                Value<int> ratePerUnitPoisha = const Value.absent(),
                Value<int> additionalChargePoisha = const Value.absent(),
                Value<int> initialReading = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilityMeterConfigsCompanion.insert(
                id: id,
                unitId: unitId,
                meterNumber: meterNumber,
                billingMode: billingMode,
                ratePerUnitPoisha: ratePerUnitPoisha,
                additionalChargePoisha: additionalChargePoisha,
                initialReading: initialReading,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UtilityMeterConfigsTable, UtilityMeterConfig>(
                    table,
                  ),
                  $$UtilityMeterConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({unitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (unitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.unitId,
                        referencedTable: $$UtilityMeterConfigsTableReferences
                            ._unitIdTable(db),
                        referencedColumn: $$UtilityMeterConfigsTableReferences
                            ._unitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UtilityMeterConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtilityMeterConfigsTable,
      UtilityMeterConfig,
      $$UtilityMeterConfigsTableFilterComposer,
      $$UtilityMeterConfigsTableOrderingComposer,
      $$UtilityMeterConfigsTableAnnotationComposer,
      $$UtilityMeterConfigsTableCreateCompanionBuilder,
      $$UtilityMeterConfigsTableUpdateCompanionBuilder,
      (UtilityMeterConfig, $$UtilityMeterConfigsTableReferences),
      UtilityMeterConfig,
      PrefetchHooks Function({bool unitId})
    >;
typedef $$MonthlyBillsTableCreateCompanionBuilder =
    MonthlyBillsCompanion Function({
      required String id,
      required String tenancyId,
      required String propertyId,
      required String unitId,
      required int billingYear,
      required int billingMonth,
      Value<String> status,
      Value<int> previousDuePoisha,
      Value<int> subtotalPoisha,
      Value<int> totalPoisha,
      Value<int> paidPoisha,
      Value<int> balancePoisha,
      Value<DateTime?> finalizedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$MonthlyBillsTableUpdateCompanionBuilder =
    MonthlyBillsCompanion Function({
      Value<String> id,
      Value<String> tenancyId,
      Value<String> propertyId,
      Value<String> unitId,
      Value<int> billingYear,
      Value<int> billingMonth,
      Value<String> status,
      Value<int> previousDuePoisha,
      Value<int> subtotalPoisha,
      Value<int> totalPoisha,
      Value<int> paidPoisha,
      Value<int> balancePoisha,
      Value<DateTime?> finalizedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MonthlyBillsTableReferences
    extends BaseReferences<_$AppDatabase, $MonthlyBillsTable, MonthlyBill> {
  $$MonthlyBillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TenanciesTable _tenancyIdTable(_$AppDatabase db) =>
      db.tenancies.createAlias('monthly_bills__tenancy_id__tenancies__id');

  $$TenanciesTableProcessedTableManager get tenancyId {
    final $_column = $_itemColumn<String>('tenancy_id')!;

    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenancyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('monthly_bills__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('monthly_bills__unit_id__units__id');

  $$UnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillLineItemsTable, List<BillLineItem>>
  _billLineItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billLineItems,
    aliasName: 'monthly_bills__id__bill_line_items__bill_id',
  );

  $$BillLineItemsTableProcessedTableManager get billLineItemsRefs {
    final manager = $$BillLineItemsTableTableManager(
      $_db,
      $_db.billLineItems,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_billLineItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentAllocationsTable, List<PaymentAllocation>>
  _paymentAllocationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAllocations,
        aliasName: 'monthly_bills__id__payment_allocations__bill_id',
      );

  $$PaymentAllocationsTableProcessedTableManager get paymentAllocationsRefs {
    final manager = $$PaymentAllocationsTableTableManager(
      $_db,
      $_db.paymentAllocations,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MonthlyBillsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyBillsTable> {
  $$MonthlyBillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingYear => $composableBuilder(
    column: $table.billingYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousDuePoisha => $composableBuilder(
    column: $table.previousDuePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalPoisha => $composableBuilder(
    column: $table.subtotalPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPoisha => $composableBuilder(
    column: $table.totalPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paidPoisha => $composableBuilder(
    column: $table.paidPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balancePoisha => $composableBuilder(
    column: $table.balancePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenanciesTableFilterComposer get tenancyId {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billLineItemsRefs(
    Expression<bool> Function($$BillLineItemsTableFilterComposer f) f,
  ) {
    final $$BillLineItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billLineItems,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillLineItemsTableFilterComposer(
            $db: $db,
            $table: $db.billLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAllocationsRefs(
    Expression<bool> Function($$PaymentAllocationsTableFilterComposer f) f,
  ) {
    final $$PaymentAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentAllocations,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonthlyBillsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyBillsTable> {
  $$MonthlyBillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingYear => $composableBuilder(
    column: $table.billingYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousDuePoisha => $composableBuilder(
    column: $table.previousDuePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalPoisha => $composableBuilder(
    column: $table.subtotalPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPoisha => $composableBuilder(
    column: $table.totalPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paidPoisha => $composableBuilder(
    column: $table.paidPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balancePoisha => $composableBuilder(
    column: $table.balancePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenanciesTableOrderingComposer get tenancyId {
    final $$TenanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableOrderingComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableOrderingComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyBillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyBillsTable> {
  $$MonthlyBillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get billingYear => $composableBuilder(
    column: $table.billingYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get billingMonth => $composableBuilder(
    column: $table.billingMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get previousDuePoisha => $composableBuilder(
    column: $table.previousDuePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalPoisha => $composableBuilder(
    column: $table.subtotalPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPoisha => $composableBuilder(
    column: $table.totalPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paidPoisha => $composableBuilder(
    column: $table.paidPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balancePoisha => $composableBuilder(
    column: $table.balancePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finalizedAt => $composableBuilder(
    column: $table.finalizedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenanciesTableAnnotationComposer get tenancyId {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> billLineItemsRefs<T extends Object>(
    Expression<T> Function($$BillLineItemsTableAnnotationComposer a) f,
  ) {
    final $$BillLineItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billLineItems,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillLineItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.billLineItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentAllocationsRefs<T extends Object>(
    Expression<T> Function($$PaymentAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PaymentAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocations,
          getReferencedColumn: (t) => t.billId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MonthlyBillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyBillsTable,
          MonthlyBill,
          $$MonthlyBillsTableFilterComposer,
          $$MonthlyBillsTableOrderingComposer,
          $$MonthlyBillsTableAnnotationComposer,
          $$MonthlyBillsTableCreateCompanionBuilder,
          $$MonthlyBillsTableUpdateCompanionBuilder,
          (MonthlyBill, $$MonthlyBillsTableReferences),
          MonthlyBill,
          PrefetchHooks Function({
            bool tenancyId,
            bool propertyId,
            bool unitId,
            bool billLineItemsRefs,
            bool paymentAllocationsRefs,
          })
        > {
  $$MonthlyBillsTableTableManager(_$AppDatabase db, $MonthlyBillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyBillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyBillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyBillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenancyId = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<int> billingYear = const Value.absent(),
                Value<int> billingMonth = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> previousDuePoisha = const Value.absent(),
                Value<int> subtotalPoisha = const Value.absent(),
                Value<int> totalPoisha = const Value.absent(),
                Value<int> paidPoisha = const Value.absent(),
                Value<int> balancePoisha = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyBillsCompanion(
                id: id,
                tenancyId: tenancyId,
                propertyId: propertyId,
                unitId: unitId,
                billingYear: billingYear,
                billingMonth: billingMonth,
                status: status,
                previousDuePoisha: previousDuePoisha,
                subtotalPoisha: subtotalPoisha,
                totalPoisha: totalPoisha,
                paidPoisha: paidPoisha,
                balancePoisha: balancePoisha,
                finalizedAt: finalizedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenancyId,
                required String propertyId,
                required String unitId,
                required int billingYear,
                required int billingMonth,
                Value<String> status = const Value.absent(),
                Value<int> previousDuePoisha = const Value.absent(),
                Value<int> subtotalPoisha = const Value.absent(),
                Value<int> totalPoisha = const Value.absent(),
                Value<int> paidPoisha = const Value.absent(),
                Value<int> balancePoisha = const Value.absent(),
                Value<DateTime?> finalizedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyBillsCompanion.insert(
                id: id,
                tenancyId: tenancyId,
                propertyId: propertyId,
                unitId: unitId,
                billingYear: billingYear,
                billingMonth: billingMonth,
                status: status,
                previousDuePoisha: previousDuePoisha,
                subtotalPoisha: subtotalPoisha,
                totalPoisha: totalPoisha,
                paidPoisha: paidPoisha,
                balancePoisha: balancePoisha,
                finalizedAt: finalizedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MonthlyBillsTable, MonthlyBill>(table),
                  $$MonthlyBillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tenancyId = false,
                propertyId = false,
                unitId = false,
                billLineItemsRefs = false,
                paymentAllocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billLineItemsRefs) db.billLineItems,
                    if (paymentAllocationsRefs) db.paymentAllocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tenancyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tenancyId,
                            referencedTable: $$MonthlyBillsTableReferences
                                ._tenancyIdTable(db),
                            referencedColumn: $$MonthlyBillsTableReferences
                                ._tenancyIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (propertyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.propertyId,
                            referencedTable: $$MonthlyBillsTableReferences
                                ._propertyIdTable(db),
                            referencedColumn: $$MonthlyBillsTableReferences
                                ._propertyIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (unitId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.unitId,
                            referencedTable: $$MonthlyBillsTableReferences
                                ._unitIdTable(db),
                            referencedColumn: $$MonthlyBillsTableReferences
                                ._unitIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billLineItemsRefs)
                        await $_getPrefetchedData<
                          MonthlyBill,
                          $MonthlyBillsTable,
                          BillLineItem
                        >(
                          currentTable: table,
                          referencedTable: $$MonthlyBillsTableReferences
                              ._billLineItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyBillsTableReferences(
                                db,
                                table,
                                p0,
                              ).billLineItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAllocationsRefs)
                        await $_getPrefetchedData<
                          MonthlyBill,
                          $MonthlyBillsTable,
                          PaymentAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$MonthlyBillsTableReferences
                              ._paymentAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyBillsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MonthlyBillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyBillsTable,
      MonthlyBill,
      $$MonthlyBillsTableFilterComposer,
      $$MonthlyBillsTableOrderingComposer,
      $$MonthlyBillsTableAnnotationComposer,
      $$MonthlyBillsTableCreateCompanionBuilder,
      $$MonthlyBillsTableUpdateCompanionBuilder,
      (MonthlyBill, $$MonthlyBillsTableReferences),
      MonthlyBill,
      PrefetchHooks Function({
        bool tenancyId,
        bool propertyId,
        bool unitId,
        bool billLineItemsRefs,
        bool paymentAllocationsRefs,
      })
    >;
typedef $$BillLineItemsTableCreateCompanionBuilder =
    BillLineItemsCompanion Function({
      required String id,
      required String billId,
      required String itemType,
      required String description,
      Value<int?> quantity,
      Value<int?> unitRatePoisha,
      required int amountPoisha,
      Value<int> sortOrder,
      Value<String?> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$BillLineItemsTableUpdateCompanionBuilder =
    BillLineItemsCompanion Function({
      Value<String> id,
      Value<String> billId,
      Value<String> itemType,
      Value<String> description,
      Value<int?> quantity,
      Value<int?> unitRatePoisha,
      Value<int> amountPoisha,
      Value<int> sortOrder,
      Value<String?> metadataJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$BillLineItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BillLineItemsTable, BillLineItem> {
  $$BillLineItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyBillsTable _billIdTable(_$AppDatabase db) => db.monthlyBills
      .createAlias('bill_line_items__bill_id__monthly_bills__id');

  $$MonthlyBillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<String>('bill_id')!;

    final manager = $$MonthlyBillsTableTableManager(
      $_db,
      $_db.monthlyBills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BillLineItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BillLineItemsTable> {
  $$BillLineItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitRatePoisha => $composableBuilder(
    column: $table.unitRatePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyBillsTableFilterComposer get billId {
    final $$MonthlyBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillLineItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BillLineItemsTable> {
  $$BillLineItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitRatePoisha => $composableBuilder(
    column: $table.unitRatePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyBillsTableOrderingComposer get billId {
    final $$MonthlyBillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableOrderingComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillLineItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillLineItemsTable> {
  $$BillLineItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get unitRatePoisha => $composableBuilder(
    column: $table.unitRatePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MonthlyBillsTableAnnotationComposer get billId {
    final $$MonthlyBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillLineItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillLineItemsTable,
          BillLineItem,
          $$BillLineItemsTableFilterComposer,
          $$BillLineItemsTableOrderingComposer,
          $$BillLineItemsTableAnnotationComposer,
          $$BillLineItemsTableCreateCompanionBuilder,
          $$BillLineItemsTableUpdateCompanionBuilder,
          (BillLineItem, $$BillLineItemsTableReferences),
          BillLineItem,
          PrefetchHooks Function({bool billId})
        > {
  $$BillLineItemsTableTableManager(_$AppDatabase db, $BillLineItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillLineItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillLineItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillLineItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> billId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
                Value<int?> unitRatePoisha = const Value.absent(),
                Value<int> amountPoisha = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillLineItemsCompanion(
                id: id,
                billId: billId,
                itemType: itemType,
                description: description,
                quantity: quantity,
                unitRatePoisha: unitRatePoisha,
                amountPoisha: amountPoisha,
                sortOrder: sortOrder,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String billId,
                required String itemType,
                required String description,
                Value<int?> quantity = const Value.absent(),
                Value<int?> unitRatePoisha = const Value.absent(),
                required int amountPoisha,
                Value<int> sortOrder = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BillLineItemsCompanion.insert(
                id: id,
                billId: billId,
                itemType: itemType,
                description: description,
                quantity: quantity,
                unitRatePoisha: unitRatePoisha,
                amountPoisha: amountPoisha,
                sortOrder: sortOrder,
                metadataJson: metadataJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BillLineItemsTable, BillLineItem>(table),
                  $$BillLineItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({billId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (billId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.billId,
                        referencedTable: $$BillLineItemsTableReferences
                            ._billIdTable(db),
                        referencedColumn: $$BillLineItemsTableReferences
                            ._billIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BillLineItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillLineItemsTable,
      BillLineItem,
      $$BillLineItemsTableFilterComposer,
      $$BillLineItemsTableOrderingComposer,
      $$BillLineItemsTableAnnotationComposer,
      $$BillLineItemsTableCreateCompanionBuilder,
      $$BillLineItemsTableUpdateCompanionBuilder,
      (BillLineItem, $$BillLineItemsTableReferences),
      BillLineItem,
      PrefetchHooks Function({bool billId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  required String id,
  required String tenancyId,
  required String paymentNumber,
  required DateTime paymentDate,
  required int amountPoisha,
  required String paymentMethod,
  Value<String?> reference,
  Value<String?> note,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<String> tenancyId,
  Value<String> paymentNumber,
  Value<DateTime> paymentDate,
  Value<int> amountPoisha,
  Value<String> paymentMethod,
  Value<String?> reference,
  Value<String?> note,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TenanciesTable _tenancyIdTable(_$AppDatabase db) =>
      db.tenancies.createAlias('payments__tenancy_id__tenancies__id');

  $$TenanciesTableProcessedTableManager get tenancyId {
    final $_column = $_itemColumn<String>('tenancy_id')!;

    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenancyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PaymentAllocationsTable, List<PaymentAllocation>>
  _paymentAllocationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAllocations,
        aliasName: 'payments__id__payment_allocations__payment_id',
      );

  $$PaymentAllocationsTableProcessedTableManager get paymentAllocationsRefs {
    final manager = $$PaymentAllocationsTableTableManager(
      $_db,
      $_db.paymentAllocations,
    ).filter((f) => f.paymentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenanciesTableFilterComposer get tenancyId {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> paymentAllocationsRefs(
    Expression<bool> Function($$PaymentAllocationsTableFilterComposer f) f,
  ) {
    final $$PaymentAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paymentAllocations,
      getReferencedColumn: (t) => t.paymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenanciesTableOrderingComposer get tenancyId {
    final $$TenanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableOrderingComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get paymentNumber => $composableBuilder(
    column: $table.paymentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenanciesTableAnnotationComposer get tenancyId {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> paymentAllocationsRefs<T extends Object>(
    Expression<T> Function($$PaymentAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PaymentAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAllocations,
          getReferencedColumn: (t) => t.paymentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool tenancyId, bool paymentAllocationsRefs})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenancyId = const Value.absent(),
                Value<String> paymentNumber = const Value.absent(),
                Value<DateTime> paymentDate = const Value.absent(),
                Value<int> amountPoisha = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                tenancyId: tenancyId,
                paymentNumber: paymentNumber,
                paymentDate: paymentDate,
                amountPoisha: amountPoisha,
                paymentMethod: paymentMethod,
                reference: reference,
                note: note,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenancyId,
                required String paymentNumber,
                required DateTime paymentDate,
                required int amountPoisha,
                required String paymentMethod,
                Value<String?> reference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                tenancyId: tenancyId,
                paymentNumber: paymentNumber,
                paymentDate: paymentDate,
                amountPoisha: amountPoisha,
                paymentMethod: paymentMethod,
                reference: reference,
                note: note,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentsTable, Payment>(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tenancyId = false, paymentAllocationsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (paymentAllocationsRefs) db.paymentAllocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tenancyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tenancyId,
                            referencedTable: $$PaymentsTableReferences
                                ._tenancyIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._tenancyIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (paymentAllocationsRefs)
                        await $_getPrefetchedData<
                          Payment,
                          $PaymentsTable,
                          PaymentAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentsTableReferences
                              ._paymentAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paymentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool tenancyId, bool paymentAllocationsRefs})
    >;
typedef $$PaymentAllocationsTableCreateCompanionBuilder =
    PaymentAllocationsCompanion Function({
      required String id,
      required String paymentId,
      required String billId,
      required int amountPoisha,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PaymentAllocationsTableUpdateCompanionBuilder =
    PaymentAllocationsCompanion Function({
      Value<String> id,
      Value<String> paymentId,
      Value<String> billId,
      Value<int> amountPoisha,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaymentAllocationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PaymentAllocationsTable,
          PaymentAllocation
        > {
  $$PaymentAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PaymentsTable _paymentIdTable(_$AppDatabase db) =>
      db.payments.createAlias('payment_allocations__payment_id__payments__id');

  $$PaymentsTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<String>('payment_id')!;

    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MonthlyBillsTable _billIdTable(_$AppDatabase db) => db.monthlyBills
      .createAlias('payment_allocations__bill_id__monthly_bills__id');

  $$MonthlyBillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<String>('bill_id')!;

    final manager = $$MonthlyBillsTableTableManager(
      $_db,
      $_db.monthlyBills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentsTableFilterComposer get paymentId {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MonthlyBillsTableFilterComposer get billId {
    final $$MonthlyBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentsTableOrderingComposer get paymentId {
    final $$PaymentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableOrderingComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MonthlyBillsTableOrderingComposer get billId {
    final $$MonthlyBillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableOrderingComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentAllocationsTable> {
  $$PaymentAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PaymentsTableAnnotationComposer get paymentId {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MonthlyBillsTableAnnotationComposer get billId {
    final $$MonthlyBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.monthlyBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentAllocationsTable,
          PaymentAllocation,
          $$PaymentAllocationsTableFilterComposer,
          $$PaymentAllocationsTableOrderingComposer,
          $$PaymentAllocationsTableAnnotationComposer,
          $$PaymentAllocationsTableCreateCompanionBuilder,
          $$PaymentAllocationsTableUpdateCompanionBuilder,
          (PaymentAllocation, $$PaymentAllocationsTableReferences),
          PaymentAllocation,
          PrefetchHooks Function({bool paymentId, bool billId})
        > {
  $$PaymentAllocationsTableTableManager(
    _$AppDatabase db,
    $PaymentAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> billId = const Value.absent(),
                Value<int> amountPoisha = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAllocationsCompanion(
                id: id,
                paymentId: paymentId,
                billId: billId,
                amountPoisha: amountPoisha,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String paymentId,
                required String billId,
                required int amountPoisha,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentAllocationsCompanion.insert(
                id: id,
                paymentId: paymentId,
                billId: billId,
                amountPoisha: amountPoisha,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentAllocationsTable, PaymentAllocation>(
                    table,
                  ),
                  $$PaymentAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentId = false, billId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (paymentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.paymentId,
                        referencedTable: $$PaymentAllocationsTableReferences
                            ._paymentIdTable(db),
                        referencedColumn: $$PaymentAllocationsTableReferences
                            ._paymentIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (billId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.billId,
                        referencedTable: $$PaymentAllocationsTableReferences
                            ._billIdTable(db),
                        referencedColumn: $$PaymentAllocationsTableReferences
                            ._billIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentAllocationsTable,
      PaymentAllocation,
      $$PaymentAllocationsTableFilterComposer,
      $$PaymentAllocationsTableOrderingComposer,
      $$PaymentAllocationsTableAnnotationComposer,
      $$PaymentAllocationsTableCreateCompanionBuilder,
      $$PaymentAllocationsTableUpdateCompanionBuilder,
      (PaymentAllocation, $$PaymentAllocationsTableReferences),
      PaymentAllocation,
      PrefetchHooks Function({bool paymentId, bool billId})
    >;
typedef $$DepositsTableCreateCompanionBuilder = DepositsCompanion Function({
  required String id,
  required String tenancyId,
  Value<int> openingBalancePoisha,
  Value<int> currentBalancePoisha,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$DepositsTableUpdateCompanionBuilder = DepositsCompanion Function({
  Value<String> id,
  Value<String> tenancyId,
  Value<int> openingBalancePoisha,
  Value<int> currentBalancePoisha,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$DepositsTableReferences
    extends BaseReferences<_$AppDatabase, $DepositsTable, Deposit> {
  $$DepositsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TenanciesTable _tenancyIdTable(_$AppDatabase db) =>
      db.tenancies.createAlias('deposits__tenancy_id__tenancies__id');

  $$TenanciesTableProcessedTableManager get tenancyId {
    final $_column = $_itemColumn<String>('tenancy_id')!;

    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenancyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $DepositTransactionsTable,
    List<DepositTransaction>
  >
  _depositTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.depositTransactions,
        aliasName: 'deposits__id__deposit_transactions__deposit_id',
      );

  $$DepositTransactionsTableProcessedTableManager get depositTransactionsRefs {
    final manager = $$DepositTransactionsTableTableManager(
      $_db,
      $_db.depositTransactions,
    ).filter((f) => f.depositId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _depositTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DepositsTableFilterComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openingBalancePoisha => $composableBuilder(
    column: $table.openingBalancePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentBalancePoisha => $composableBuilder(
    column: $table.currentBalancePoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TenanciesTableFilterComposer get tenancyId {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> depositTransactionsRefs(
    Expression<bool> Function($$DepositTransactionsTableFilterComposer f) f,
  ) {
    final $$DepositTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.depositTransactions,
      getReferencedColumn: (t) => t.depositId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.depositTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DepositsTableOrderingComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openingBalancePoisha => $composableBuilder(
    column: $table.openingBalancePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentBalancePoisha => $composableBuilder(
    column: $table.currentBalancePoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TenanciesTableOrderingComposer get tenancyId {
    final $$TenanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableOrderingComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get openingBalancePoisha => $composableBuilder(
    column: $table.openingBalancePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentBalancePoisha => $composableBuilder(
    column: $table.currentBalancePoisha,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TenanciesTableAnnotationComposer get tenancyId {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> depositTransactionsRefs<T extends Object>(
    Expression<T> Function($$DepositTransactionsTableAnnotationComposer a) f,
  ) {
    final $$DepositTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.depositTransactions,
          getReferencedColumn: (t) => t.depositId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DepositTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.depositTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DepositsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepositsTable,
          Deposit,
          $$DepositsTableFilterComposer,
          $$DepositsTableOrderingComposer,
          $$DepositsTableAnnotationComposer,
          $$DepositsTableCreateCompanionBuilder,
          $$DepositsTableUpdateCompanionBuilder,
          (Deposit, $$DepositsTableReferences),
          Deposit,
          PrefetchHooks Function({bool tenancyId, bool depositTransactionsRefs})
        > {
  $$DepositsTableTableManager(_$AppDatabase db, $DepositsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepositsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepositsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepositsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenancyId = const Value.absent(),
                Value<int> openingBalancePoisha = const Value.absent(),
                Value<int> currentBalancePoisha = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepositsCompanion(
                id: id,
                tenancyId: tenancyId,
                openingBalancePoisha: openingBalancePoisha,
                currentBalancePoisha: currentBalancePoisha,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenancyId,
                Value<int> openingBalancePoisha = const Value.absent(),
                Value<int> currentBalancePoisha = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepositsCompanion.insert(
                id: id,
                tenancyId: tenancyId,
                openingBalancePoisha: openingBalancePoisha,
                currentBalancePoisha: currentBalancePoisha,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DepositsTable, Deposit>(table),
                  $$DepositsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({tenancyId = false, depositTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (depositTransactionsRefs) db.depositTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (tenancyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tenancyId,
                            referencedTable: $$DepositsTableReferences
                                ._tenancyIdTable(db),
                            referencedColumn: $$DepositsTableReferences
                                ._tenancyIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (depositTransactionsRefs)
                        await $_getPrefetchedData<
                          Deposit,
                          $DepositsTable,
                          DepositTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$DepositsTableReferences
                              ._depositTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DepositsTableReferences(
                                db,
                                table,
                                p0,
                              ).depositTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.depositId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DepositsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepositsTable,
      Deposit,
      $$DepositsTableFilterComposer,
      $$DepositsTableOrderingComposer,
      $$DepositsTableAnnotationComposer,
      $$DepositsTableCreateCompanionBuilder,
      $$DepositsTableUpdateCompanionBuilder,
      (Deposit, $$DepositsTableReferences),
      Deposit,
      PrefetchHooks Function({bool tenancyId, bool depositTransactionsRefs})
    >;
typedef $$DepositTransactionsTableCreateCompanionBuilder =
    DepositTransactionsCompanion Function({
      required String id,
      required String depositId,
      required String type,
      required int amountPoisha,
      required DateTime transactionDate,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$DepositTransactionsTableUpdateCompanionBuilder =
    DepositTransactionsCompanion Function({
      Value<String> id,
      Value<String> depositId,
      Value<String> type,
      Value<int> amountPoisha,
      Value<DateTime> transactionDate,
      Value<String?> referenceType,
      Value<String?> referenceId,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$DepositTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DepositTransactionsTable,
          DepositTransaction
        > {
  $$DepositTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DepositsTable _depositIdTable(_$AppDatabase db) =>
      db.deposits.createAlias('deposit_transactions__deposit_id__deposits__id');

  $$DepositsTableProcessedTableManager get depositId {
    final $_column = $_itemColumn<String>('deposit_id')!;

    final manager = $$DepositsTableTableManager(
      $_db,
      $_db.deposits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_depositIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DepositTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $DepositTransactionsTable> {
  $$DepositTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DepositsTableFilterComposer get depositId {
    final $$DepositsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.depositId,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableFilterComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DepositTransactionsTable> {
  $$DepositTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DepositsTableOrderingComposer get depositId {
    final $$DepositsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.depositId,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableOrderingComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepositTransactionsTable> {
  $$DepositTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountPoisha => $composableBuilder(
    column: $table.amountPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DepositsTableAnnotationComposer get depositId {
    final $$DepositsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.depositId,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableAnnotationComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepositTransactionsTable,
          DepositTransaction,
          $$DepositTransactionsTableFilterComposer,
          $$DepositTransactionsTableOrderingComposer,
          $$DepositTransactionsTableAnnotationComposer,
          $$DepositTransactionsTableCreateCompanionBuilder,
          $$DepositTransactionsTableUpdateCompanionBuilder,
          (DepositTransaction, $$DepositTransactionsTableReferences),
          DepositTransaction,
          PrefetchHooks Function({bool depositId})
        > {
  $$DepositTransactionsTableTableManager(
    _$AppDatabase db,
    $DepositTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepositTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepositTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DepositTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> depositId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amountPoisha = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepositTransactionsCompanion(
                id: id,
                depositId: depositId,
                type: type,
                amountPoisha: amountPoisha,
                transactionDate: transactionDate,
                referenceType: referenceType,
                referenceId: referenceId,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String depositId,
                required String type,
                required int amountPoisha,
                required DateTime transactionDate,
                Value<String?> referenceType = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepositTransactionsCompanion.insert(
                id: id,
                depositId: depositId,
                type: type,
                amountPoisha: amountPoisha,
                transactionDate: transactionDate,
                referenceType: referenceType,
                referenceId: referenceId,
                note: note,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DepositTransactionsTable, DepositTransaction>(
                    table,
                  ),
                  $$DepositTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({depositId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (depositId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.depositId,
                        referencedTable: $$DepositTransactionsTableReferences
                            ._depositIdTable(db),
                        referencedColumn: $$DepositTransactionsTableReferences
                            ._depositIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DepositTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepositTransactionsTable,
      DepositTransaction,
      $$DepositTransactionsTableFilterComposer,
      $$DepositTransactionsTableOrderingComposer,
      $$DepositTransactionsTableAnnotationComposer,
      $$DepositTransactionsTableCreateCompanionBuilder,
      $$DepositTransactionsTableUpdateCompanionBuilder,
      (DepositTransaction, $$DepositTransactionsTableReferences),
      DepositTransaction,
      PrefetchHooks Function({bool depositId})
    >;
typedef $$RepairsTableCreateCompanionBuilder = RepairsCompanion Function({
  required String id,
  required String propertyId,
  Value<String?> unitId,
  Value<String?> tenancyId,
  required String category,
  required String title,
  Value<String?> description,
  required DateTime reportedDate,
  Value<DateTime?> completedDate,
  Value<int> costPoisha,
  required String responsibility,
  Value<String> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$RepairsTableUpdateCompanionBuilder = RepairsCompanion Function({
  Value<String> id,
  Value<String> propertyId,
  Value<String?> unitId,
  Value<String?> tenancyId,
  Value<String> category,
  Value<String> title,
  Value<String?> description,
  Value<DateTime> reportedDate,
  Value<DateTime?> completedDate,
  Value<int> costPoisha,
  Value<String> responsibility,
  Value<String> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RepairsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairsTable, Repair> {
  $$RepairsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias('repairs__property_id__properties__id');

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager(
      $_db,
      $_db.properties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UnitsTable _unitIdTable(_$AppDatabase db) =>
      db.units.createAlias('repairs__unit_id__units__id');

  $$UnitsTableProcessedTableManager? get unitId {
    final $_column = $_itemColumn<String>('unit_id');
    if ($_column == null) return null;
    final manager = $$UnitsTableTableManager(
      $_db,
      $_db.units,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TenanciesTable _tenancyIdTable(_$AppDatabase db) =>
      db.tenancies.createAlias('repairs__tenancy_id__tenancies__id');

  $$TenanciesTableProcessedTableManager? get tenancyId {
    final $_column = $_itemColumn<String>('tenancy_id');
    if ($_column == null) return null;
    final manager = $$TenanciesTableTableManager(
      $_db,
      $_db.tenancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenancyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RepairAttachmentsTable, List<RepairAttachment>>
  _repairAttachmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.repairAttachments,
        aliasName: 'repairs__id__repair_attachments__repair_id',
      );

  $$RepairAttachmentsTableProcessedTableManager get repairAttachmentsRefs {
    final manager = $$RepairAttachmentsTableTableManager(
      $_db,
      $_db.repairAttachments,
    ).filter((f) => f.repairId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _repairAttachmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepairsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costPoisha => $composableBuilder(
    column: $table.costPoisha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responsibility => $composableBuilder(
    column: $table.responsibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableFilterComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableFilterComposer get unitId {
    final $$UnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableFilterComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenanciesTableFilterComposer get tenancyId {
    final $$TenanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableFilterComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> repairAttachmentsRefs(
    Expression<bool> Function($$RepairAttachmentsTableFilterComposer f) f,
  ) {
    final $$RepairAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairAttachments,
      getReferencedColumn: (t) => t.repairId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.repairAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepairsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costPoisha => $composableBuilder(
    column: $table.costPoisha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responsibility => $composableBuilder(
    column: $table.responsibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableOrderingComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableOrderingComposer get unitId {
    final $$UnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableOrderingComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenanciesTableOrderingComposer get tenancyId {
    final $$TenanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableOrderingComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairsTable> {
  $$RepairsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reportedDate => $composableBuilder(
    column: $table.reportedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedDate => $composableBuilder(
    column: $table.completedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costPoisha => $composableBuilder(
    column: $table.costPoisha,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responsibility => $composableBuilder(
    column: $table.responsibility,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.propertyId,
      referencedTable: $db.properties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PropertiesTableAnnotationComposer(
            $db: $db,
            $table: $db.properties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UnitsTableAnnotationComposer get unitId {
    final $$UnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.units,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.units,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TenanciesTableAnnotationComposer get tenancyId {
    final $$TenanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenancyId,
      referencedTable: $db.tenancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TenanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.tenancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> repairAttachmentsRefs<T extends Object>(
    Expression<T> Function($$RepairAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$RepairAttachmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.repairAttachments,
          getReferencedColumn: (t) => t.repairId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RepairAttachmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.repairAttachments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RepairsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairsTable,
          Repair,
          $$RepairsTableFilterComposer,
          $$RepairsTableOrderingComposer,
          $$RepairsTableAnnotationComposer,
          $$RepairsTableCreateCompanionBuilder,
          $$RepairsTableUpdateCompanionBuilder,
          (Repair, $$RepairsTableReferences),
          Repair,
          PrefetchHooks Function({
            bool propertyId,
            bool unitId,
            bool tenancyId,
            bool repairAttachmentsRefs,
          })
        > {
  $$RepairsTableTableManager(_$AppDatabase db, $RepairsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> propertyId = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<String?> tenancyId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> reportedDate = const Value.absent(),
                Value<DateTime?> completedDate = const Value.absent(),
                Value<int> costPoisha = const Value.absent(),
                Value<String> responsibility = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairsCompanion(
                id: id,
                propertyId: propertyId,
                unitId: unitId,
                tenancyId: tenancyId,
                category: category,
                title: title,
                description: description,
                reportedDate: reportedDate,
                completedDate: completedDate,
                costPoisha: costPoisha,
                responsibility: responsibility,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String propertyId,
                Value<String?> unitId = const Value.absent(),
                Value<String?> tenancyId = const Value.absent(),
                required String category,
                required String title,
                Value<String?> description = const Value.absent(),
                required DateTime reportedDate,
                Value<DateTime?> completedDate = const Value.absent(),
                Value<int> costPoisha = const Value.absent(),
                required String responsibility,
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairsCompanion.insert(
                id: id,
                propertyId: propertyId,
                unitId: unitId,
                tenancyId: tenancyId,
                category: category,
                title: title,
                description: description,
                reportedDate: reportedDate,
                completedDate: completedDate,
                costPoisha: costPoisha,
                responsibility: responsibility,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepairsTable, Repair>(table),
                  $$RepairsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                propertyId = false,
                unitId = false,
                tenancyId = false,
                repairAttachmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairAttachmentsRefs) db.repairAttachments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (propertyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.propertyId,
                            referencedTable: $$RepairsTableReferences
                                ._propertyIdTable(db),
                            referencedColumn: $$RepairsTableReferences
                                ._propertyIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (unitId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.unitId,
                            referencedTable: $$RepairsTableReferences
                                ._unitIdTable(db),
                            referencedColumn: $$RepairsTableReferences
                                ._unitIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (tenancyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.tenancyId,
                            referencedTable: $$RepairsTableReferences
                                ._tenancyIdTable(db),
                            referencedColumn: $$RepairsTableReferences
                                ._tenancyIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairAttachmentsRefs)
                        await $_getPrefetchedData<
                          Repair,
                          $RepairsTable,
                          RepairAttachment
                        >(
                          currentTable: table,
                          referencedTable: $$RepairsTableReferences
                              ._repairAttachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairsTableReferences(
                                db,
                                table,
                                p0,
                              ).repairAttachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RepairsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairsTable,
      Repair,
      $$RepairsTableFilterComposer,
      $$RepairsTableOrderingComposer,
      $$RepairsTableAnnotationComposer,
      $$RepairsTableCreateCompanionBuilder,
      $$RepairsTableUpdateCompanionBuilder,
      (Repair, $$RepairsTableReferences),
      Repair,
      PrefetchHooks Function({
        bool propertyId,
        bool unitId,
        bool tenancyId,
        bool repairAttachmentsRefs,
      })
    >;
typedef $$RepairAttachmentsTableCreateCompanionBuilder =
    RepairAttachmentsCompanion Function({
      required String id,
      required String repairId,
      required String fileName,
      required String relativePath,
      Value<String?> mimeType,
      Value<int?> fileSize,
      Value<String?> checksum,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$RepairAttachmentsTableUpdateCompanionBuilder =
    RepairAttachmentsCompanion Function({
      Value<String> id,
      Value<String> repairId,
      Value<String> fileName,
      Value<String> relativePath,
      Value<String?> mimeType,
      Value<int?> fileSize,
      Value<String?> checksum,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RepairAttachmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RepairAttachmentsTable,
          RepairAttachment
        > {
  $$RepairAttachmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RepairsTable _repairIdTable(_$AppDatabase db) =>
      db.repairs.createAlias('repair_attachments__repair_id__repairs__id');

  $$RepairsTableProcessedTableManager get repairId {
    final $_column = $_itemColumn<String>('repair_id')!;

    final manager = $$RepairsTableTableManager(
      $_db,
      $_db.repairs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepairAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairsTableFilterComposer get repairId {
    final $$RepairsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableFilterComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairsTableOrderingComposer get repairId {
    final $$RepairsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableOrderingComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RepairsTableAnnotationComposer get repairId {
    final $$RepairsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairId,
      referencedTable: $db.repairs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairAttachmentsTable,
          RepairAttachment,
          $$RepairAttachmentsTableFilterComposer,
          $$RepairAttachmentsTableOrderingComposer,
          $$RepairAttachmentsTableAnnotationComposer,
          $$RepairAttachmentsTableCreateCompanionBuilder,
          $$RepairAttachmentsTableUpdateCompanionBuilder,
          (RepairAttachment, $$RepairAttachmentsTableReferences),
          RepairAttachment,
          PrefetchHooks Function({bool repairId})
        > {
  $$RepairAttachmentsTableTableManager(
    _$AppDatabase db,
    $RepairAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairAttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairAttachmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> repairId = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairAttachmentsCompanion(
                id: id,
                repairId: repairId,
                fileName: fileName,
                relativePath: relativePath,
                mimeType: mimeType,
                fileSize: fileSize,
                checksum: checksum,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String repairId,
                required String fileName,
                required String relativePath,
                Value<String?> mimeType = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RepairAttachmentsCompanion.insert(
                id: id,
                repairId: repairId,
                fileName: fileName,
                relativePath: relativePath,
                mimeType: mimeType,
                fileSize: fileSize,
                checksum: checksum,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepairAttachmentsTable, RepairAttachment>(table),
                  $$RepairAttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (repairId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.repairId,
                        referencedTable: $$RepairAttachmentsTableReferences
                            ._repairIdTable(db),
                        referencedColumn: $$RepairAttachmentsTableReferences
                            ._repairIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RepairAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairAttachmentsTable,
      RepairAttachment,
      $$RepairAttachmentsTableFilterComposer,
      $$RepairAttachmentsTableOrderingComposer,
      $$RepairAttachmentsTableAnnotationComposer,
      $$RepairAttachmentsTableCreateCompanionBuilder,
      $$RepairAttachmentsTableUpdateCompanionBuilder,
      (RepairAttachment, $$RepairAttachmentsTableReferences),
      RepairAttachment,
      PrefetchHooks Function({bool repairId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String valueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> valueJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String valueJson,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$AuditEventsTableCreateCompanionBuilder =
    AuditEventsCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String action,
      required String summary,
      Value<String?> beforeJson,
      Value<String?> afterJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AuditEventsTableUpdateCompanionBuilder =
    AuditEventsCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> action,
      Value<String> summary,
      Value<String?> beforeJson,
      Value<String?> afterJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AuditEventsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beforeJson => $composableBuilder(
    column: $table.beforeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get afterJson => $composableBuilder(
    column: $table.afterJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beforeJson => $composableBuilder(
    column: $table.beforeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get afterJson => $composableBuilder(
    column: $table.afterJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditEventsTable> {
  $$AuditEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get beforeJson => $composableBuilder(
    column: $table.beforeJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get afterJson =>
      $composableBuilder(column: $table.afterJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditEventsTable,
          AuditEvent,
          $$AuditEventsTableFilterComposer,
          $$AuditEventsTableOrderingComposer,
          $$AuditEventsTableAnnotationComposer,
          $$AuditEventsTableCreateCompanionBuilder,
          $$AuditEventsTableUpdateCompanionBuilder,
          (
            AuditEvent,
            BaseReferences<_$AppDatabase, $AuditEventsTable, AuditEvent>,
          ),
          AuditEvent,
          PrefetchHooks Function()
        > {
  $$AuditEventsTableTableManager(_$AppDatabase db, $AuditEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String?> beforeJson = const Value.absent(),
                Value<String?> afterJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                summary: summary,
                beforeJson: beforeJson,
                afterJson: afterJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String action,
                required String summary,
                Value<String?> beforeJson = const Value.absent(),
                Value<String?> afterJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditEventsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                summary: summary,
                beforeJson: beforeJson,
                afterJson: afterJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditEventsTable, AuditEvent>(table),
                  BaseReferences<_$AppDatabase, $AuditEventsTable, AuditEvent>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditEventsTable,
      AuditEvent,
      $$AuditEventsTableFilterComposer,
      $$AuditEventsTableOrderingComposer,
      $$AuditEventsTableAnnotationComposer,
      $$AuditEventsTableCreateCompanionBuilder,
      $$AuditEventsTableUpdateCompanionBuilder,
      (
        AuditEvent,
        BaseReferences<_$AppDatabase, $AuditEventsTable, AuditEvent>,
      ),
      AuditEvent,
      PrefetchHooks Function()
    >;
typedef $$SchemaMetadataTableCreateCompanionBuilder =
    SchemaMetadataCompanion Function({
      required String id,
      required int schemaVersion,
      required DateTime lastMigrationAt,
      Value<String?> lastMigrationError,
      Value<int> rowid,
    });
typedef $$SchemaMetadataTableUpdateCompanionBuilder =
    SchemaMetadataCompanion Function({
      Value<String> id,
      Value<int> schemaVersion,
      Value<DateTime> lastMigrationAt,
      Value<String?> lastMigrationError,
      Value<int> rowid,
    });

class $$SchemaMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SchemaMetadataTable> {
  $$SchemaMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMigrationAt => $composableBuilder(
    column: $table.lastMigrationAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMigrationError => $composableBuilder(
    column: $table.lastMigrationError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SchemaMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SchemaMetadataTable> {
  $$SchemaMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMigrationAt => $composableBuilder(
    column: $table.lastMigrationAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMigrationError => $composableBuilder(
    column: $table.lastMigrationError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SchemaMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchemaMetadataTable> {
  $$SchemaMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMigrationAt => $composableBuilder(
    column: $table.lastMigrationAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMigrationError => $composableBuilder(
    column: $table.lastMigrationError,
    builder: (column) => column,
  );
}

class $$SchemaMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SchemaMetadataTable,
          SchemaMetadataData,
          $$SchemaMetadataTableFilterComposer,
          $$SchemaMetadataTableOrderingComposer,
          $$SchemaMetadataTableAnnotationComposer,
          $$SchemaMetadataTableCreateCompanionBuilder,
          $$SchemaMetadataTableUpdateCompanionBuilder,
          (
            SchemaMetadataData,
            BaseReferences<
              _$AppDatabase,
              $SchemaMetadataTable,
              SchemaMetadataData
            >,
          ),
          SchemaMetadataData,
          PrefetchHooks Function()
        > {
  $$SchemaMetadataTableTableManager(
    _$AppDatabase db,
    $SchemaMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchemaMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchemaMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchemaMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<DateTime> lastMigrationAt = const Value.absent(),
                Value<String?> lastMigrationError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SchemaMetadataCompanion(
                id: id,
                schemaVersion: schemaVersion,
                lastMigrationAt: lastMigrationAt,
                lastMigrationError: lastMigrationError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int schemaVersion,
                required DateTime lastMigrationAt,
                Value<String?> lastMigrationError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SchemaMetadataCompanion.insert(
                id: id,
                schemaVersion: schemaVersion,
                lastMigrationAt: lastMigrationAt,
                lastMigrationError: lastMigrationError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SchemaMetadataTable, SchemaMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SchemaMetadataTable,
                    SchemaMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SchemaMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SchemaMetadataTable,
      SchemaMetadataData,
      $$SchemaMetadataTableFilterComposer,
      $$SchemaMetadataTableOrderingComposer,
      $$SchemaMetadataTableAnnotationComposer,
      $$SchemaMetadataTableCreateCompanionBuilder,
      $$SchemaMetadataTableUpdateCompanionBuilder,
      (
        SchemaMetadataData,
        BaseReferences<_$AppDatabase, $SchemaMetadataTable, SchemaMetadataData>,
      ),
      SchemaMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
  $$UnitsTableTableManager get units =>
      $$UnitsTableTableManager(_db, _db.units);
  $$TenantsTableTableManager get tenants =>
      $$TenantsTableTableManager(_db, _db.tenants);
  $$TenanciesTableTableManager get tenancies =>
      $$TenanciesTableTableManager(_db, _db.tenancies);
  $$RecurringChargeRulesTableTableManager get recurringChargeRules =>
      $$RecurringChargeRulesTableTableManager(_db, _db.recurringChargeRules);
  $$UtilityMeterConfigsTableTableManager get utilityMeterConfigs =>
      $$UtilityMeterConfigsTableTableManager(_db, _db.utilityMeterConfigs);
  $$MonthlyBillsTableTableManager get monthlyBills =>
      $$MonthlyBillsTableTableManager(_db, _db.monthlyBills);
  $$BillLineItemsTableTableManager get billLineItems =>
      $$BillLineItemsTableTableManager(_db, _db.billLineItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$PaymentAllocationsTableTableManager get paymentAllocations =>
      $$PaymentAllocationsTableTableManager(_db, _db.paymentAllocations);
  $$DepositsTableTableManager get deposits =>
      $$DepositsTableTableManager(_db, _db.deposits);
  $$DepositTransactionsTableTableManager get depositTransactions =>
      $$DepositTransactionsTableTableManager(_db, _db.depositTransactions);
  $$RepairsTableTableManager get repairs =>
      $$RepairsTableTableManager(_db, _db.repairs);
  $$RepairAttachmentsTableTableManager get repairAttachments =>
      $$RepairAttachmentsTableTableManager(_db, _db.repairAttachments);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$AuditEventsTableTableManager get auditEvents =>
      $$AuditEventsTableTableManager(_db, _db.auditEvents);
  $$SchemaMetadataTableTableManager get schemaMetadata =>
      $$SchemaMetadataTableTableManager(_db, _db.schemaMetadata);
}

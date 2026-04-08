// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlantsTable extends Plants with TableInfo<$PlantsTable, PlantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesIdMeta =
      const VerificationMeta('speciesId');
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
      'species_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('happy'));
  static const VerificationMeta _growthStageMeta =
      const VerificationMeta('growthStage');
  @override
  late final GeneratedColumn<String> growthStage = GeneratedColumn<String>(
      'growth_stage', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('seedling'));
  static const VerificationMeta _lastWateredMeta =
      const VerificationMeta('lastWatered');
  @override
  late final GeneratedColumn<DateTime> lastWatered = GeneratedColumn<DateTime>(
      'last_watered', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastFertilizedMeta =
      const VerificationMeta('lastFertilized');
  @override
  late final GeneratedColumn<DateTime> lastFertilized =
      GeneratedColumn<DateTime>('last_fertilized', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastRepottedMeta =
      const VerificationMeta('lastRepotted');
  @override
  late final GeneratedColumn<DateTime> lastRepotted = GeneratedColumn<DateTime>(
      'last_repotted', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _streakDaysMeta =
      const VerificationMeta('streakDays');
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
      'streak_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nickname,
        speciesId,
        location,
        status,
        growthStage,
        lastWatered,
        lastFertilized,
        lastRepotted,
        createdAt,
        streakDays
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plants';
  @override
  VerificationContext validateIntegrity(Insertable<PlantRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(_speciesIdMeta,
          speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta));
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('growth_stage')) {
      context.handle(
          _growthStageMeta,
          growthStage.isAcceptableOrUnknown(
              data['growth_stage']!, _growthStageMeta));
    }
    if (data.containsKey('last_watered')) {
      context.handle(
          _lastWateredMeta,
          lastWatered.isAcceptableOrUnknown(
              data['last_watered']!, _lastWateredMeta));
    }
    if (data.containsKey('last_fertilized')) {
      context.handle(
          _lastFertilizedMeta,
          lastFertilized.isAcceptableOrUnknown(
              data['last_fertilized']!, _lastFertilizedMeta));
    }
    if (data.containsKey('last_repotted')) {
      context.handle(
          _lastRepottedMeta,
          lastRepotted.isAcceptableOrUnknown(
              data['last_repotted']!, _lastRepottedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('streak_days')) {
      context.handle(
          _streakDaysMeta,
          streakDays.isAcceptableOrUnknown(
              data['streak_days']!, _streakDaysMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlantRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname'])!,
      speciesId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_id'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      growthStage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}growth_stage'])!,
      lastWatered: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_watered']),
      lastFertilized: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_fertilized']),
      lastRepotted: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_repotted']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      streakDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}streak_days'])!,
    );
  }

  @override
  $PlantsTable createAlias(String alias) {
    return $PlantsTable(attachedDatabase, alias);
  }
}

class PlantRow extends DataClass implements Insertable<PlantRow> {
  final String id;
  final String nickname;
  final String speciesId;
  final String location;
  final String status;
  final String growthStage;
  final DateTime? lastWatered;
  final DateTime? lastFertilized;
  final DateTime? lastRepotted;
  final DateTime createdAt;
  final int streakDays;
  const PlantRow(
      {required this.id,
      required this.nickname,
      required this.speciesId,
      required this.location,
      required this.status,
      required this.growthStage,
      this.lastWatered,
      this.lastFertilized,
      this.lastRepotted,
      required this.createdAt,
      required this.streakDays});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nickname'] = Variable<String>(nickname);
    map['species_id'] = Variable<String>(speciesId);
    map['location'] = Variable<String>(location);
    map['status'] = Variable<String>(status);
    map['growth_stage'] = Variable<String>(growthStage);
    if (!nullToAbsent || lastWatered != null) {
      map['last_watered'] = Variable<DateTime>(lastWatered);
    }
    if (!nullToAbsent || lastFertilized != null) {
      map['last_fertilized'] = Variable<DateTime>(lastFertilized);
    }
    if (!nullToAbsent || lastRepotted != null) {
      map['last_repotted'] = Variable<DateTime>(lastRepotted);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['streak_days'] = Variable<int>(streakDays);
    return map;
  }

  PlantsCompanion toCompanion(bool nullToAbsent) {
    return PlantsCompanion(
      id: Value(id),
      nickname: Value(nickname),
      speciesId: Value(speciesId),
      location: Value(location),
      status: Value(status),
      growthStage: Value(growthStage),
      lastWatered: lastWatered == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWatered),
      lastFertilized: lastFertilized == null && nullToAbsent
          ? const Value.absent()
          : Value(lastFertilized),
      lastRepotted: lastRepotted == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRepotted),
      createdAt: Value(createdAt),
      streakDays: Value(streakDays),
    );
  }

  factory PlantRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlantRow(
      id: serializer.fromJson<String>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      location: serializer.fromJson<String>(json['location']),
      status: serializer.fromJson<String>(json['status']),
      growthStage: serializer.fromJson<String>(json['growthStage']),
      lastWatered: serializer.fromJson<DateTime?>(json['lastWatered']),
      lastFertilized: serializer.fromJson<DateTime?>(json['lastFertilized']),
      lastRepotted: serializer.fromJson<DateTime?>(json['lastRepotted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickname': serializer.toJson<String>(nickname),
      'speciesId': serializer.toJson<String>(speciesId),
      'location': serializer.toJson<String>(location),
      'status': serializer.toJson<String>(status),
      'growthStage': serializer.toJson<String>(growthStage),
      'lastWatered': serializer.toJson<DateTime?>(lastWatered),
      'lastFertilized': serializer.toJson<DateTime?>(lastFertilized),
      'lastRepotted': serializer.toJson<DateTime?>(lastRepotted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'streakDays': serializer.toJson<int>(streakDays),
    };
  }

  PlantRow copyWith(
          {String? id,
          String? nickname,
          String? speciesId,
          String? location,
          String? status,
          String? growthStage,
          Value<DateTime?> lastWatered = const Value.absent(),
          Value<DateTime?> lastFertilized = const Value.absent(),
          Value<DateTime?> lastRepotted = const Value.absent(),
          DateTime? createdAt,
          int? streakDays}) =>
      PlantRow(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        speciesId: speciesId ?? this.speciesId,
        location: location ?? this.location,
        status: status ?? this.status,
        growthStage: growthStage ?? this.growthStage,
        lastWatered: lastWatered.present ? lastWatered.value : this.lastWatered,
        lastFertilized:
            lastFertilized.present ? lastFertilized.value : this.lastFertilized,
        lastRepotted:
            lastRepotted.present ? lastRepotted.value : this.lastRepotted,
        createdAt: createdAt ?? this.createdAt,
        streakDays: streakDays ?? this.streakDays,
      );
  PlantRow copyWithCompanion(PlantsCompanion data) {
    return PlantRow(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      location: data.location.present ? data.location.value : this.location,
      status: data.status.present ? data.status.value : this.status,
      growthStage:
          data.growthStage.present ? data.growthStage.value : this.growthStage,
      lastWatered:
          data.lastWatered.present ? data.lastWatered.value : this.lastWatered,
      lastFertilized: data.lastFertilized.present
          ? data.lastFertilized.value
          : this.lastFertilized,
      lastRepotted: data.lastRepotted.present
          ? data.lastRepotted.value
          : this.lastRepotted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      streakDays:
          data.streakDays.present ? data.streakDays.value : this.streakDays,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlantRow(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('speciesId: $speciesId, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('growthStage: $growthStage, ')
          ..write('lastWatered: $lastWatered, ')
          ..write('lastFertilized: $lastFertilized, ')
          ..write('lastRepotted: $lastRepotted, ')
          ..write('createdAt: $createdAt, ')
          ..write('streakDays: $streakDays')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nickname,
      speciesId,
      location,
      status,
      growthStage,
      lastWatered,
      lastFertilized,
      lastRepotted,
      createdAt,
      streakDays);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlantRow &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.speciesId == this.speciesId &&
          other.location == this.location &&
          other.status == this.status &&
          other.growthStage == this.growthStage &&
          other.lastWatered == this.lastWatered &&
          other.lastFertilized == this.lastFertilized &&
          other.lastRepotted == this.lastRepotted &&
          other.createdAt == this.createdAt &&
          other.streakDays == this.streakDays);
}

class PlantsCompanion extends UpdateCompanion<PlantRow> {
  final Value<String> id;
  final Value<String> nickname;
  final Value<String> speciesId;
  final Value<String> location;
  final Value<String> status;
  final Value<String> growthStage;
  final Value<DateTime?> lastWatered;
  final Value<DateTime?> lastFertilized;
  final Value<DateTime?> lastRepotted;
  final Value<DateTime> createdAt;
  final Value<int> streakDays;
  final Value<int> rowid;
  const PlantsCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.location = const Value.absent(),
    this.status = const Value.absent(),
    this.growthStage = const Value.absent(),
    this.lastWatered = const Value.absent(),
    this.lastFertilized = const Value.absent(),
    this.lastRepotted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlantsCompanion.insert({
    required String id,
    required String nickname,
    required String speciesId,
    required String location,
    this.status = const Value.absent(),
    this.growthStage = const Value.absent(),
    this.lastWatered = const Value.absent(),
    this.lastFertilized = const Value.absent(),
    this.lastRepotted = const Value.absent(),
    required DateTime createdAt,
    this.streakDays = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nickname = Value(nickname),
        speciesId = Value(speciesId),
        location = Value(location),
        createdAt = Value(createdAt);
  static Insertable<PlantRow> custom({
    Expression<String>? id,
    Expression<String>? nickname,
    Expression<String>? speciesId,
    Expression<String>? location,
    Expression<String>? status,
    Expression<String>? growthStage,
    Expression<DateTime>? lastWatered,
    Expression<DateTime>? lastFertilized,
    Expression<DateTime>? lastRepotted,
    Expression<DateTime>? createdAt,
    Expression<int>? streakDays,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (speciesId != null) 'species_id': speciesId,
      if (location != null) 'location': location,
      if (status != null) 'status': status,
      if (growthStage != null) 'growth_stage': growthStage,
      if (lastWatered != null) 'last_watered': lastWatered,
      if (lastFertilized != null) 'last_fertilized': lastFertilized,
      if (lastRepotted != null) 'last_repotted': lastRepotted,
      if (createdAt != null) 'created_at': createdAt,
      if (streakDays != null) 'streak_days': streakDays,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlantsCompanion copyWith(
      {Value<String>? id,
      Value<String>? nickname,
      Value<String>? speciesId,
      Value<String>? location,
      Value<String>? status,
      Value<String>? growthStage,
      Value<DateTime?>? lastWatered,
      Value<DateTime?>? lastFertilized,
      Value<DateTime?>? lastRepotted,
      Value<DateTime>? createdAt,
      Value<int>? streakDays,
      Value<int>? rowid}) {
    return PlantsCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      speciesId: speciesId ?? this.speciesId,
      location: location ?? this.location,
      status: status ?? this.status,
      growthStage: growthStage ?? this.growthStage,
      lastWatered: lastWatered ?? this.lastWatered,
      lastFertilized: lastFertilized ?? this.lastFertilized,
      lastRepotted: lastRepotted ?? this.lastRepotted,
      createdAt: createdAt ?? this.createdAt,
      streakDays: streakDays ?? this.streakDays,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (growthStage.present) {
      map['growth_stage'] = Variable<String>(growthStage.value);
    }
    if (lastWatered.present) {
      map['last_watered'] = Variable<DateTime>(lastWatered.value);
    }
    if (lastFertilized.present) {
      map['last_fertilized'] = Variable<DateTime>(lastFertilized.value);
    }
    if (lastRepotted.present) {
      map['last_repotted'] = Variable<DateTime>(lastRepotted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlantsCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('speciesId: $speciesId, ')
          ..write('location: $location, ')
          ..write('status: $status, ')
          ..write('growthStage: $growthStage, ')
          ..write('lastWatered: $lastWatered, ')
          ..write('lastFertilized: $lastFertilized, ')
          ..write('lastRepotted: $lastRepotted, ')
          ..write('createdAt: $createdAt, ')
          ..write('streakDays: $streakDays, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareLogsTable extends CareLogs
    with TableInfo<$CareLogsTable, CareLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plantIdMeta =
      const VerificationMeta('plantId');
  @override
  late final GeneratedColumn<String> plantId = GeneratedColumn<String>(
      'plant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES plants (id) ON DELETE CASCADE'));
  static const VerificationMeta _careTypeMeta =
      const VerificationMeta('careType');
  @override
  late final GeneratedColumn<String> careType = GeneratedColumn<String>(
      'care_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _performedAtMeta =
      const VerificationMeta('performedAt');
  @override
  late final GeneratedColumn<DateTime> performedAt = GeneratedColumn<DateTime>(
      'performed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, plantId, careType, performedAt, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_logs';
  @override
  VerificationContext validateIntegrity(Insertable<CareLogRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plant_id')) {
      context.handle(_plantIdMeta,
          plantId.isAcceptableOrUnknown(data['plant_id']!, _plantIdMeta));
    } else if (isInserting) {
      context.missing(_plantIdMeta);
    }
    if (data.containsKey('care_type')) {
      context.handle(_careTypeMeta,
          careType.isAcceptableOrUnknown(data['care_type']!, _careTypeMeta));
    } else if (isInserting) {
      context.missing(_careTypeMeta);
    }
    if (data.containsKey('performed_at')) {
      context.handle(
          _performedAtMeta,
          performedAt.isAcceptableOrUnknown(
              data['performed_at']!, _performedAtMeta));
    } else if (isInserting) {
      context.missing(_performedAtMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareLogRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      plantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plant_id'])!,
      careType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}care_type'])!,
      performedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}performed_at'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $CareLogsTable createAlias(String alias) {
    return $CareLogsTable(attachedDatabase, alias);
  }
}

class CareLogRow extends DataClass implements Insertable<CareLogRow> {
  final String id;
  final String plantId;
  final String careType;
  final DateTime performedAt;
  final String? note;
  const CareLogRow(
      {required this.id,
      required this.plantId,
      required this.careType,
      required this.performedAt,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plant_id'] = Variable<String>(plantId);
    map['care_type'] = Variable<String>(careType);
    map['performed_at'] = Variable<DateTime>(performedAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CareLogsCompanion toCompanion(bool nullToAbsent) {
    return CareLogsCompanion(
      id: Value(id),
      plantId: Value(plantId),
      careType: Value(careType),
      performedAt: Value(performedAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory CareLogRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareLogRow(
      id: serializer.fromJson<String>(json['id']),
      plantId: serializer.fromJson<String>(json['plantId']),
      careType: serializer.fromJson<String>(json['careType']),
      performedAt: serializer.fromJson<DateTime>(json['performedAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'plantId': serializer.toJson<String>(plantId),
      'careType': serializer.toJson<String>(careType),
      'performedAt': serializer.toJson<DateTime>(performedAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  CareLogRow copyWith(
          {String? id,
          String? plantId,
          String? careType,
          DateTime? performedAt,
          Value<String?> note = const Value.absent()}) =>
      CareLogRow(
        id: id ?? this.id,
        plantId: plantId ?? this.plantId,
        careType: careType ?? this.careType,
        performedAt: performedAt ?? this.performedAt,
        note: note.present ? note.value : this.note,
      );
  CareLogRow copyWithCompanion(CareLogsCompanion data) {
    return CareLogRow(
      id: data.id.present ? data.id.value : this.id,
      plantId: data.plantId.present ? data.plantId.value : this.plantId,
      careType: data.careType.present ? data.careType.value : this.careType,
      performedAt:
          data.performedAt.present ? data.performedAt.value : this.performedAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareLogRow(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('careType: $careType, ')
          ..write('performedAt: $performedAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, plantId, careType, performedAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareLogRow &&
          other.id == this.id &&
          other.plantId == this.plantId &&
          other.careType == this.careType &&
          other.performedAt == this.performedAt &&
          other.note == this.note);
}

class CareLogsCompanion extends UpdateCompanion<CareLogRow> {
  final Value<String> id;
  final Value<String> plantId;
  final Value<String> careType;
  final Value<DateTime> performedAt;
  final Value<String?> note;
  final Value<int> rowid;
  const CareLogsCompanion({
    this.id = const Value.absent(),
    this.plantId = const Value.absent(),
    this.careType = const Value.absent(),
    this.performedAt = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareLogsCompanion.insert({
    required String id,
    required String plantId,
    required String careType,
    required DateTime performedAt,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        plantId = Value(plantId),
        careType = Value(careType),
        performedAt = Value(performedAt);
  static Insertable<CareLogRow> custom({
    Expression<String>? id,
    Expression<String>? plantId,
    Expression<String>? careType,
    Expression<DateTime>? performedAt,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plantId != null) 'plant_id': plantId,
      if (careType != null) 'care_type': careType,
      if (performedAt != null) 'performed_at': performedAt,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? plantId,
      Value<String>? careType,
      Value<DateTime>? performedAt,
      Value<String?>? note,
      Value<int>? rowid}) {
    return CareLogsCompanion(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      careType: careType ?? this.careType,
      performedAt: performedAt ?? this.performedAt,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (plantId.present) {
      map['plant_id'] = Variable<String>(plantId.value);
    }
    if (careType.present) {
      map['care_type'] = Variable<String>(careType.value);
    }
    if (performedAt.present) {
      map['performed_at'] = Variable<DateTime>(performedAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareLogsCompanion(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('careType: $careType, ')
          ..write('performedAt: $performedAt, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareSchedulesTable extends CareSchedules
    with TableInfo<$CareSchedulesTable, CareScheduleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareSchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plantIdMeta =
      const VerificationMeta('plantId');
  @override
  late final GeneratedColumn<String> plantId = GeneratedColumn<String>(
      'plant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES plants (id) ON DELETE CASCADE'));
  static const VerificationMeta _careTypeMeta =
      const VerificationMeta('careType');
  @override
  late final GeneratedColumn<String> careType = GeneratedColumn<String>(
      'care_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nextDueDateMeta =
      const VerificationMeta('nextDueDate');
  @override
  late final GeneratedColumn<DateTime> nextDueDate = GeneratedColumn<DateTime>(
      'next_due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, plantId, careType, intervalDays, nextDueDate, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_schedules';
  @override
  VerificationContext validateIntegrity(Insertable<CareScheduleRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plant_id')) {
      context.handle(_plantIdMeta,
          plantId.isAcceptableOrUnknown(data['plant_id']!, _plantIdMeta));
    } else if (isInserting) {
      context.missing(_plantIdMeta);
    }
    if (data.containsKey('care_type')) {
      context.handle(_careTypeMeta,
          careType.isAcceptableOrUnknown(data['care_type']!, _careTypeMeta));
    } else if (isInserting) {
      context.missing(_careTypeMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    } else if (isInserting) {
      context.missing(_intervalDaysMeta);
    }
    if (data.containsKey('next_due_date')) {
      context.handle(
          _nextDueDateMeta,
          nextDueDate.isAcceptableOrUnknown(
              data['next_due_date']!, _nextDueDateMeta));
    } else if (isInserting) {
      context.missing(_nextDueDateMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareScheduleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareScheduleRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      plantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plant_id'])!,
      careType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}care_type'])!,
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      nextDueDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_due_date'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $CareSchedulesTable createAlias(String alias) {
    return $CareSchedulesTable(attachedDatabase, alias);
  }
}

class CareScheduleRow extends DataClass implements Insertable<CareScheduleRow> {
  final String id;
  final String plantId;
  final String careType;
  final int intervalDays;
  final DateTime nextDueDate;
  final bool isEnabled;
  const CareScheduleRow(
      {required this.id,
      required this.plantId,
      required this.careType,
      required this.intervalDays,
      required this.nextDueDate,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plant_id'] = Variable<String>(plantId);
    map['care_type'] = Variable<String>(careType);
    map['interval_days'] = Variable<int>(intervalDays);
    map['next_due_date'] = Variable<DateTime>(nextDueDate);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  CareSchedulesCompanion toCompanion(bool nullToAbsent) {
    return CareSchedulesCompanion(
      id: Value(id),
      plantId: Value(plantId),
      careType: Value(careType),
      intervalDays: Value(intervalDays),
      nextDueDate: Value(nextDueDate),
      isEnabled: Value(isEnabled),
    );
  }

  factory CareScheduleRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareScheduleRow(
      id: serializer.fromJson<String>(json['id']),
      plantId: serializer.fromJson<String>(json['plantId']),
      careType: serializer.fromJson<String>(json['careType']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      nextDueDate: serializer.fromJson<DateTime>(json['nextDueDate']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'plantId': serializer.toJson<String>(plantId),
      'careType': serializer.toJson<String>(careType),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'nextDueDate': serializer.toJson<DateTime>(nextDueDate),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  CareScheduleRow copyWith(
          {String? id,
          String? plantId,
          String? careType,
          int? intervalDays,
          DateTime? nextDueDate,
          bool? isEnabled}) =>
      CareScheduleRow(
        id: id ?? this.id,
        plantId: plantId ?? this.plantId,
        careType: careType ?? this.careType,
        intervalDays: intervalDays ?? this.intervalDays,
        nextDueDate: nextDueDate ?? this.nextDueDate,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  CareScheduleRow copyWithCompanion(CareSchedulesCompanion data) {
    return CareScheduleRow(
      id: data.id.present ? data.id.value : this.id,
      plantId: data.plantId.present ? data.plantId.value : this.plantId,
      careType: data.careType.present ? data.careType.value : this.careType,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      nextDueDate:
          data.nextDueDate.present ? data.nextDueDate.value : this.nextDueDate,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareScheduleRow(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('careType: $careType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, plantId, careType, intervalDays, nextDueDate, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareScheduleRow &&
          other.id == this.id &&
          other.plantId == this.plantId &&
          other.careType == this.careType &&
          other.intervalDays == this.intervalDays &&
          other.nextDueDate == this.nextDueDate &&
          other.isEnabled == this.isEnabled);
}

class CareSchedulesCompanion extends UpdateCompanion<CareScheduleRow> {
  final Value<String> id;
  final Value<String> plantId;
  final Value<String> careType;
  final Value<int> intervalDays;
  final Value<DateTime> nextDueDate;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const CareSchedulesCompanion({
    this.id = const Value.absent(),
    this.plantId = const Value.absent(),
    this.careType = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.nextDueDate = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareSchedulesCompanion.insert({
    required String id,
    required String plantId,
    required String careType,
    required int intervalDays,
    required DateTime nextDueDate,
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        plantId = Value(plantId),
        careType = Value(careType),
        intervalDays = Value(intervalDays),
        nextDueDate = Value(nextDueDate);
  static Insertable<CareScheduleRow> custom({
    Expression<String>? id,
    Expression<String>? plantId,
    Expression<String>? careType,
    Expression<int>? intervalDays,
    Expression<DateTime>? nextDueDate,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plantId != null) 'plant_id': plantId,
      if (careType != null) 'care_type': careType,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (nextDueDate != null) 'next_due_date': nextDueDate,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareSchedulesCompanion copyWith(
      {Value<String>? id,
      Value<String>? plantId,
      Value<String>? careType,
      Value<int>? intervalDays,
      Value<DateTime>? nextDueDate,
      Value<bool>? isEnabled,
      Value<int>? rowid}) {
    return CareSchedulesCompanion(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      careType: careType ?? this.careType,
      intervalDays: intervalDays ?? this.intervalDays,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (plantId.present) {
      map['plant_id'] = Variable<String>(plantId.value);
    }
    if (careType.present) {
      map['care_type'] = Variable<String>(careType.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (nextDueDate.present) {
      map['next_due_date'] = Variable<DateTime>(nextDueDate.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareSchedulesCompanion(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('careType: $careType, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('nextDueDate: $nextDueDate, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlantPhotosTable extends PlantPhotos
    with TableInfo<$PlantPhotosTable, PlantPhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlantPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _plantIdMeta =
      const VerificationMeta('plantId');
  @override
  late final GeneratedColumn<String> plantId = GeneratedColumn<String>(
      'plant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES plants (id) ON DELETE CASCADE'));
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, plantId, filePath, caption, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plant_photos';
  @override
  VerificationContext validateIntegrity(Insertable<PlantPhotoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plant_id')) {
      context.handle(_plantIdMeta,
          plantId.isAcceptableOrUnknown(data['plant_id']!, _plantIdMeta));
    } else if (isInserting) {
      context.missing(_plantIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlantPhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlantPhotoRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      plantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plant_id'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlantPhotosTable createAlias(String alias) {
    return $PlantPhotosTable(attachedDatabase, alias);
  }
}

class PlantPhotoRow extends DataClass implements Insertable<PlantPhotoRow> {
  final String id;
  final String plantId;
  final String filePath;
  final String? caption;
  final DateTime createdAt;
  const PlantPhotoRow(
      {required this.id,
      required this.plantId,
      required this.filePath,
      this.caption,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plant_id'] = Variable<String>(plantId);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlantPhotosCompanion toCompanion(bool nullToAbsent) {
    return PlantPhotosCompanion(
      id: Value(id),
      plantId: Value(plantId),
      filePath: Value(filePath),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      createdAt: Value(createdAt),
    );
  }

  factory PlantPhotoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlantPhotoRow(
      id: serializer.fromJson<String>(json['id']),
      plantId: serializer.fromJson<String>(json['plantId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      caption: serializer.fromJson<String?>(json['caption']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'plantId': serializer.toJson<String>(plantId),
      'filePath': serializer.toJson<String>(filePath),
      'caption': serializer.toJson<String?>(caption),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlantPhotoRow copyWith(
          {String? id,
          String? plantId,
          String? filePath,
          Value<String?> caption = const Value.absent(),
          DateTime? createdAt}) =>
      PlantPhotoRow(
        id: id ?? this.id,
        plantId: plantId ?? this.plantId,
        filePath: filePath ?? this.filePath,
        caption: caption.present ? caption.value : this.caption,
        createdAt: createdAt ?? this.createdAt,
      );
  PlantPhotoRow copyWithCompanion(PlantPhotosCompanion data) {
    return PlantPhotoRow(
      id: data.id.present ? data.id.value : this.id,
      plantId: data.plantId.present ? data.plantId.value : this.plantId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      caption: data.caption.present ? data.caption.value : this.caption,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlantPhotoRow(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, plantId, filePath, caption, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlantPhotoRow &&
          other.id == this.id &&
          other.plantId == this.plantId &&
          other.filePath == this.filePath &&
          other.caption == this.caption &&
          other.createdAt == this.createdAt);
}

class PlantPhotosCompanion extends UpdateCompanion<PlantPhotoRow> {
  final Value<String> id;
  final Value<String> plantId;
  final Value<String> filePath;
  final Value<String?> caption;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlantPhotosCompanion({
    this.id = const Value.absent(),
    this.plantId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.caption = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlantPhotosCompanion.insert({
    required String id,
    required String plantId,
    required String filePath,
    this.caption = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        plantId = Value(plantId),
        filePath = Value(filePath),
        createdAt = Value(createdAt);
  static Insertable<PlantPhotoRow> custom({
    Expression<String>? id,
    Expression<String>? plantId,
    Expression<String>? filePath,
    Expression<String>? caption,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plantId != null) 'plant_id': plantId,
      if (filePath != null) 'file_path': filePath,
      if (caption != null) 'caption': caption,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlantPhotosCompanion copyWith(
      {Value<String>? id,
      Value<String>? plantId,
      Value<String>? filePath,
      Value<String?>? caption,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PlantPhotosCompanion(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      filePath: filePath ?? this.filePath,
      caption: caption ?? this.caption,
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
    if (plantId.present) {
      map['plant_id'] = Variable<String>(plantId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
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
    return (StringBuffer('PlantPhotosCompanion(')
          ..write('id: $id, ')
          ..write('plantId: $plantId, ')
          ..write('filePath: $filePath, ')
          ..write('caption: $caption, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTableTable extends UserSettingsTable
    with TableInfo<$UserSettingsTableTable, UserSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _notificationEnabledMeta =
      const VerificationMeta('notificationEnabled');
  @override
  late final GeneratedColumn<bool> notificationEnabled = GeneratedColumn<bool>(
      'notification_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _waterReminderHourMeta =
      const VerificationMeta('waterReminderHour');
  @override
  late final GeneratedColumn<int> waterReminderHour = GeneratedColumn<int>(
      'water_reminder_hour', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(8));
  static const VerificationMeta _waterReminderMinuteMeta =
      const VerificationMeta('waterReminderMinute');
  @override
  late final GeneratedColumn<int> waterReminderMinute = GeneratedColumn<int>(
      'water_reminder_minute', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _fertilizerReminderEnabledMeta =
      const VerificationMeta('fertilizerReminderEnabled');
  @override
  late final GeneratedColumn<bool> fertilizerReminderEnabled =
      GeneratedColumn<bool>('fertilizer_reminder_enabled', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("fertilizer_reminder_enabled" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _isDarkModeMeta =
      const VerificationMeta('isDarkMode');
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
      'is_dark_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_dark_mode" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        notificationEnabled,
        waterReminderHour,
        waterReminderMinute,
        fertilizerReminderEnabled,
        isDarkMode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserSettingsRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notification_enabled')) {
      context.handle(
          _notificationEnabledMeta,
          notificationEnabled.isAcceptableOrUnknown(
              data['notification_enabled']!, _notificationEnabledMeta));
    }
    if (data.containsKey('water_reminder_hour')) {
      context.handle(
          _waterReminderHourMeta,
          waterReminderHour.isAcceptableOrUnknown(
              data['water_reminder_hour']!, _waterReminderHourMeta));
    }
    if (data.containsKey('water_reminder_minute')) {
      context.handle(
          _waterReminderMinuteMeta,
          waterReminderMinute.isAcceptableOrUnknown(
              data['water_reminder_minute']!, _waterReminderMinuteMeta));
    }
    if (data.containsKey('fertilizer_reminder_enabled')) {
      context.handle(
          _fertilizerReminderEnabledMeta,
          fertilizerReminderEnabled.isAcceptableOrUnknown(
              data['fertilizer_reminder_enabled']!,
              _fertilizerReminderEnabledMeta));
    }
    if (data.containsKey('is_dark_mode')) {
      context.handle(
          _isDarkModeMeta,
          isDarkMode.isAcceptableOrUnknown(
              data['is_dark_mode']!, _isDarkModeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notificationEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notification_enabled'])!,
      waterReminderHour: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}water_reminder_hour'])!,
      waterReminderMinute: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}water_reminder_minute'])!,
      fertilizerReminderEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}fertilizer_reminder_enabled'])!,
      isDarkMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dark_mode'])!,
    );
  }

  @override
  $UserSettingsTableTable createAlias(String alias) {
    return $UserSettingsTableTable(attachedDatabase, alias);
  }
}

class UserSettingsRow extends DataClass implements Insertable<UserSettingsRow> {
  final int id;
  final bool notificationEnabled;
  final int waterReminderHour;
  final int waterReminderMinute;
  final bool fertilizerReminderEnabled;
  final bool isDarkMode;
  const UserSettingsRow(
      {required this.id,
      required this.notificationEnabled,
      required this.waterReminderHour,
      required this.waterReminderMinute,
      required this.fertilizerReminderEnabled,
      required this.isDarkMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notification_enabled'] = Variable<bool>(notificationEnabled);
    map['water_reminder_hour'] = Variable<int>(waterReminderHour);
    map['water_reminder_minute'] = Variable<int>(waterReminderMinute);
    map['fertilizer_reminder_enabled'] =
        Variable<bool>(fertilizerReminderEnabled);
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    return map;
  }

  UserSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsTableCompanion(
      id: Value(id),
      notificationEnabled: Value(notificationEnabled),
      waterReminderHour: Value(waterReminderHour),
      waterReminderMinute: Value(waterReminderMinute),
      fertilizerReminderEnabled: Value(fertilizerReminderEnabled),
      isDarkMode: Value(isDarkMode),
    );
  }

  factory UserSettingsRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      notificationEnabled:
          serializer.fromJson<bool>(json['notificationEnabled']),
      waterReminderHour: serializer.fromJson<int>(json['waterReminderHour']),
      waterReminderMinute:
          serializer.fromJson<int>(json['waterReminderMinute']),
      fertilizerReminderEnabled:
          serializer.fromJson<bool>(json['fertilizerReminderEnabled']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationEnabled': serializer.toJson<bool>(notificationEnabled),
      'waterReminderHour': serializer.toJson<int>(waterReminderHour),
      'waterReminderMinute': serializer.toJson<int>(waterReminderMinute),
      'fertilizerReminderEnabled':
          serializer.toJson<bool>(fertilizerReminderEnabled),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
    };
  }

  UserSettingsRow copyWith(
          {int? id,
          bool? notificationEnabled,
          int? waterReminderHour,
          int? waterReminderMinute,
          bool? fertilizerReminderEnabled,
          bool? isDarkMode}) =>
      UserSettingsRow(
        id: id ?? this.id,
        notificationEnabled: notificationEnabled ?? this.notificationEnabled,
        waterReminderHour: waterReminderHour ?? this.waterReminderHour,
        waterReminderMinute: waterReminderMinute ?? this.waterReminderMinute,
        fertilizerReminderEnabled:
            fertilizerReminderEnabled ?? this.fertilizerReminderEnabled,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
  UserSettingsRow copyWithCompanion(UserSettingsTableCompanion data) {
    return UserSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      notificationEnabled: data.notificationEnabled.present
          ? data.notificationEnabled.value
          : this.notificationEnabled,
      waterReminderHour: data.waterReminderHour.present
          ? data.waterReminderHour.value
          : this.waterReminderHour,
      waterReminderMinute: data.waterReminderMinute.present
          ? data.waterReminderMinute.value
          : this.waterReminderMinute,
      fertilizerReminderEnabled: data.fertilizerReminderEnabled.present
          ? data.fertilizerReminderEnabled.value
          : this.fertilizerReminderEnabled,
      isDarkMode:
          data.isDarkMode.present ? data.isDarkMode.value : this.isDarkMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsRow(')
          ..write('id: $id, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('waterReminderHour: $waterReminderHour, ')
          ..write('waterReminderMinute: $waterReminderMinute, ')
          ..write('fertilizerReminderEnabled: $fertilizerReminderEnabled, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, notificationEnabled, waterReminderHour,
      waterReminderMinute, fertilizerReminderEnabled, isDarkMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsRow &&
          other.id == this.id &&
          other.notificationEnabled == this.notificationEnabled &&
          other.waterReminderHour == this.waterReminderHour &&
          other.waterReminderMinute == this.waterReminderMinute &&
          other.fertilizerReminderEnabled == this.fertilizerReminderEnabled &&
          other.isDarkMode == this.isDarkMode);
}

class UserSettingsTableCompanion extends UpdateCompanion<UserSettingsRow> {
  final Value<int> id;
  final Value<bool> notificationEnabled;
  final Value<int> waterReminderHour;
  final Value<int> waterReminderMinute;
  final Value<bool> fertilizerReminderEnabled;
  final Value<bool> isDarkMode;
  const UserSettingsTableCompanion({
    this.id = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.waterReminderHour = const Value.absent(),
    this.waterReminderMinute = const Value.absent(),
    this.fertilizerReminderEnabled = const Value.absent(),
    this.isDarkMode = const Value.absent(),
  });
  UserSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.notificationEnabled = const Value.absent(),
    this.waterReminderHour = const Value.absent(),
    this.waterReminderMinute = const Value.absent(),
    this.fertilizerReminderEnabled = const Value.absent(),
    this.isDarkMode = const Value.absent(),
  });
  static Insertable<UserSettingsRow> custom({
    Expression<int>? id,
    Expression<bool>? notificationEnabled,
    Expression<int>? waterReminderHour,
    Expression<int>? waterReminderMinute,
    Expression<bool>? fertilizerReminderEnabled,
    Expression<bool>? isDarkMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationEnabled != null)
        'notification_enabled': notificationEnabled,
      if (waterReminderHour != null) 'water_reminder_hour': waterReminderHour,
      if (waterReminderMinute != null)
        'water_reminder_minute': waterReminderMinute,
      if (fertilizerReminderEnabled != null)
        'fertilizer_reminder_enabled': fertilizerReminderEnabled,
      if (isDarkMode != null) 'is_dark_mode': isDarkMode,
    });
  }

  UserSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? notificationEnabled,
      Value<int>? waterReminderHour,
      Value<int>? waterReminderMinute,
      Value<bool>? fertilizerReminderEnabled,
      Value<bool>? isDarkMode}) {
    return UserSettingsTableCompanion(
      id: id ?? this.id,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      waterReminderHour: waterReminderHour ?? this.waterReminderHour,
      waterReminderMinute: waterReminderMinute ?? this.waterReminderMinute,
      fertilizerReminderEnabled:
          fertilizerReminderEnabled ?? this.fertilizerReminderEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationEnabled.present) {
      map['notification_enabled'] = Variable<bool>(notificationEnabled.value);
    }
    if (waterReminderHour.present) {
      map['water_reminder_hour'] = Variable<int>(waterReminderHour.value);
    }
    if (waterReminderMinute.present) {
      map['water_reminder_minute'] = Variable<int>(waterReminderMinute.value);
    }
    if (fertilizerReminderEnabled.present) {
      map['fertilizer_reminder_enabled'] =
          Variable<bool>(fertilizerReminderEnabled.value);
    }
    if (isDarkMode.present) {
      map['is_dark_mode'] = Variable<bool>(isDarkMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('notificationEnabled: $notificationEnabled, ')
          ..write('waterReminderHour: $waterReminderHour, ')
          ..write('waterReminderMinute: $waterReminderMinute, ')
          ..write('fertilizerReminderEnabled: $fertilizerReminderEnabled, ')
          ..write('isDarkMode: $isDarkMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlantsTable plants = $PlantsTable(this);
  late final $CareLogsTable careLogs = $CareLogsTable(this);
  late final $CareSchedulesTable careSchedules = $CareSchedulesTable(this);
  late final $PlantPhotosTable plantPhotos = $PlantPhotosTable(this);
  late final $UserSettingsTableTable userSettingsTable =
      $UserSettingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [plants, careLogs, careSchedules, plantPhotos, userSettingsTable];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('plants',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('care_logs', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('plants',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('care_schedules', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('plants',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('plant_photos', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PlantsTableCreateCompanionBuilder = PlantsCompanion Function({
  required String id,
  required String nickname,
  required String speciesId,
  required String location,
  Value<String> status,
  Value<String> growthStage,
  Value<DateTime?> lastWatered,
  Value<DateTime?> lastFertilized,
  Value<DateTime?> lastRepotted,
  required DateTime createdAt,
  Value<int> streakDays,
  Value<int> rowid,
});
typedef $$PlantsTableUpdateCompanionBuilder = PlantsCompanion Function({
  Value<String> id,
  Value<String> nickname,
  Value<String> speciesId,
  Value<String> location,
  Value<String> status,
  Value<String> growthStage,
  Value<DateTime?> lastWatered,
  Value<DateTime?> lastFertilized,
  Value<DateTime?> lastRepotted,
  Value<DateTime> createdAt,
  Value<int> streakDays,
  Value<int> rowid,
});

final class $$PlantsTableReferences
    extends BaseReferences<_$AppDatabase, $PlantsTable, PlantRow> {
  $$PlantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CareLogsTable, List<CareLogRow>>
      _careLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.careLogs,
          aliasName: $_aliasNameGenerator(db.plants.id, db.careLogs.plantId));

  $$CareLogsTableProcessedTableManager get careLogsRefs {
    final manager = $$CareLogsTableTableManager($_db, $_db.careLogs)
        .filter((f) => f.plantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CareSchedulesTable, List<CareScheduleRow>>
      _careSchedulesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.careSchedules,
              aliasName:
                  $_aliasNameGenerator(db.plants.id, db.careSchedules.plantId));

  $$CareSchedulesTableProcessedTableManager get careSchedulesRefs {
    final manager = $$CareSchedulesTableTableManager($_db, $_db.careSchedules)
        .filter((f) => f.plantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careSchedulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlantPhotosTable, List<PlantPhotoRow>>
      _plantPhotosRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.plantPhotos,
              aliasName:
                  $_aliasNameGenerator(db.plants.id, db.plantPhotos.plantId));

  $$PlantPhotosTableProcessedTableManager get plantPhotosRefs {
    final manager = $$PlantPhotosTableTableManager($_db, $_db.plantPhotos)
        .filter((f) => f.plantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_plantPhotosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlantsTableFilterComposer
    extends Composer<_$AppDatabase, $PlantsTable> {
  $$PlantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get growthStage => $composableBuilder(
      column: $table.growthStage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastWatered => $composableBuilder(
      column: $table.lastWatered, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastFertilized => $composableBuilder(
      column: $table.lastFertilized,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastRepotted => $composableBuilder(
      column: $table.lastRepotted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnFilters(column));

  Expression<bool> careLogsRefs(
      Expression<bool> Function($$CareLogsTableFilterComposer f) f) {
    final $$CareLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.careLogs,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CareLogsTableFilterComposer(
              $db: $db,
              $table: $db.careLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> careSchedulesRefs(
      Expression<bool> Function($$CareSchedulesTableFilterComposer f) f) {
    final $$CareSchedulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.careSchedules,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CareSchedulesTableFilterComposer(
              $db: $db,
              $table: $db.careSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> plantPhotosRefs(
      Expression<bool> Function($$PlantPhotosTableFilterComposer f) f) {
    final $$PlantPhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.plantPhotos,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantPhotosTableFilterComposer(
              $db: $db,
              $table: $db.plantPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlantsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlantsTable> {
  $$PlantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get speciesId => $composableBuilder(
      column: $table.speciesId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get growthStage => $composableBuilder(
      column: $table.growthStage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastWatered => $composableBuilder(
      column: $table.lastWatered, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastFertilized => $composableBuilder(
      column: $table.lastFertilized,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastRepotted => $composableBuilder(
      column: $table.lastRepotted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => ColumnOrderings(column));
}

class $$PlantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlantsTable> {
  $$PlantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get growthStage => $composableBuilder(
      column: $table.growthStage, builder: (column) => column);

  GeneratedColumn<DateTime> get lastWatered => $composableBuilder(
      column: $table.lastWatered, builder: (column) => column);

  GeneratedColumn<DateTime> get lastFertilized => $composableBuilder(
      column: $table.lastFertilized, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRepotted => $composableBuilder(
      column: $table.lastRepotted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
      column: $table.streakDays, builder: (column) => column);

  Expression<T> careLogsRefs<T extends Object>(
      Expression<T> Function($$CareLogsTableAnnotationComposer a) f) {
    final $$CareLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.careLogs,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CareLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.careLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> careSchedulesRefs<T extends Object>(
      Expression<T> Function($$CareSchedulesTableAnnotationComposer a) f) {
    final $$CareSchedulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.careSchedules,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CareSchedulesTableAnnotationComposer(
              $db: $db,
              $table: $db.careSchedules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> plantPhotosRefs<T extends Object>(
      Expression<T> Function($$PlantPhotosTableAnnotationComposer a) f) {
    final $$PlantPhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.plantPhotos,
        getReferencedColumn: (t) => t.plantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantPhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.plantPhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlantsTable,
    PlantRow,
    $$PlantsTableFilterComposer,
    $$PlantsTableOrderingComposer,
    $$PlantsTableAnnotationComposer,
    $$PlantsTableCreateCompanionBuilder,
    $$PlantsTableUpdateCompanionBuilder,
    (PlantRow, $$PlantsTableReferences),
    PlantRow,
    PrefetchHooks Function(
        {bool careLogsRefs, bool careSchedulesRefs, bool plantPhotosRefs})> {
  $$PlantsTableTableManager(_$AppDatabase db, $PlantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nickname = const Value.absent(),
            Value<String> speciesId = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> growthStage = const Value.absent(),
            Value<DateTime?> lastWatered = const Value.absent(),
            Value<DateTime?> lastFertilized = const Value.absent(),
            Value<DateTime?> lastRepotted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> streakDays = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlantsCompanion(
            id: id,
            nickname: nickname,
            speciesId: speciesId,
            location: location,
            status: status,
            growthStage: growthStage,
            lastWatered: lastWatered,
            lastFertilized: lastFertilized,
            lastRepotted: lastRepotted,
            createdAt: createdAt,
            streakDays: streakDays,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nickname,
            required String speciesId,
            required String location,
            Value<String> status = const Value.absent(),
            Value<String> growthStage = const Value.absent(),
            Value<DateTime?> lastWatered = const Value.absent(),
            Value<DateTime?> lastFertilized = const Value.absent(),
            Value<DateTime?> lastRepotted = const Value.absent(),
            required DateTime createdAt,
            Value<int> streakDays = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlantsCompanion.insert(
            id: id,
            nickname: nickname,
            speciesId: speciesId,
            location: location,
            status: status,
            growthStage: growthStage,
            lastWatered: lastWatered,
            lastFertilized: lastFertilized,
            lastRepotted: lastRepotted,
            createdAt: createdAt,
            streakDays: streakDays,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlantsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {careLogsRefs = false,
              careSchedulesRefs = false,
              plantPhotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (careLogsRefs) db.careLogs,
                if (careSchedulesRefs) db.careSchedules,
                if (plantPhotosRefs) db.plantPhotos
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (careLogsRefs)
                    await $_getPrefetchedData<PlantRow, $PlantsTable,
                            CareLogRow>(
                        currentTable: table,
                        referencedTable:
                            $$PlantsTableReferences._careLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlantsTableReferences(db, table, p0).careLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.plantId == item.id),
                        typedResults: items),
                  if (careSchedulesRefs)
                    await $_getPrefetchedData<PlantRow, $PlantsTable,
                            CareScheduleRow>(
                        currentTable: table,
                        referencedTable:
                            $$PlantsTableReferences._careSchedulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlantsTableReferences(db, table, p0)
                                .careSchedulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.plantId == item.id),
                        typedResults: items),
                  if (plantPhotosRefs)
                    await $_getPrefetchedData<PlantRow, $PlantsTable,
                            PlantPhotoRow>(
                        currentTable: table,
                        referencedTable:
                            $$PlantsTableReferences._plantPhotosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlantsTableReferences(db, table, p0)
                                .plantPhotosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.plantId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlantsTable,
    PlantRow,
    $$PlantsTableFilterComposer,
    $$PlantsTableOrderingComposer,
    $$PlantsTableAnnotationComposer,
    $$PlantsTableCreateCompanionBuilder,
    $$PlantsTableUpdateCompanionBuilder,
    (PlantRow, $$PlantsTableReferences),
    PlantRow,
    PrefetchHooks Function(
        {bool careLogsRefs, bool careSchedulesRefs, bool plantPhotosRefs})>;
typedef $$CareLogsTableCreateCompanionBuilder = CareLogsCompanion Function({
  required String id,
  required String plantId,
  required String careType,
  required DateTime performedAt,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$CareLogsTableUpdateCompanionBuilder = CareLogsCompanion Function({
  Value<String> id,
  Value<String> plantId,
  Value<String> careType,
  Value<DateTime> performedAt,
  Value<String?> note,
  Value<int> rowid,
});

final class $$CareLogsTableReferences
    extends BaseReferences<_$AppDatabase, $CareLogsTable, CareLogRow> {
  $$CareLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlantsTable _plantIdTable(_$AppDatabase db) => db.plants
      .createAlias($_aliasNameGenerator(db.careLogs.plantId, db.plants.id));

  $$PlantsTableProcessedTableManager get plantId {
    final $_column = $_itemColumn<String>('plant_id')!;

    final manager = $$PlantsTableTableManager($_db, $_db.plants)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CareLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get careType => $composableBuilder(
      column: $table.careType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get performedAt => $composableBuilder(
      column: $table.performedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  $$PlantsTableFilterComposer get plantId {
    final $$PlantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableFilterComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get careType => $composableBuilder(
      column: $table.careType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get performedAt => $composableBuilder(
      column: $table.performedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  $$PlantsTableOrderingComposer get plantId {
    final $$PlantsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableOrderingComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareLogsTable> {
  $$CareLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get careType =>
      $composableBuilder(column: $table.careType, builder: (column) => column);

  GeneratedColumn<DateTime> get performedAt => $composableBuilder(
      column: $table.performedAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$PlantsTableAnnotationComposer get plantId {
    final $$PlantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableAnnotationComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CareLogsTable,
    CareLogRow,
    $$CareLogsTableFilterComposer,
    $$CareLogsTableOrderingComposer,
    $$CareLogsTableAnnotationComposer,
    $$CareLogsTableCreateCompanionBuilder,
    $$CareLogsTableUpdateCompanionBuilder,
    (CareLogRow, $$CareLogsTableReferences),
    CareLogRow,
    PrefetchHooks Function({bool plantId})> {
  $$CareLogsTableTableManager(_$AppDatabase db, $CareLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> plantId = const Value.absent(),
            Value<String> careType = const Value.absent(),
            Value<DateTime> performedAt = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CareLogsCompanion(
            id: id,
            plantId: plantId,
            careType: careType,
            performedAt: performedAt,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String plantId,
            required String careType,
            required DateTime performedAt,
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CareLogsCompanion.insert(
            id: id,
            plantId: plantId,
            careType: careType,
            performedAt: performedAt,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CareLogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({plantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (plantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.plantId,
                    referencedTable:
                        $$CareLogsTableReferences._plantIdTable(db),
                    referencedColumn:
                        $$CareLogsTableReferences._plantIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CareLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CareLogsTable,
    CareLogRow,
    $$CareLogsTableFilterComposer,
    $$CareLogsTableOrderingComposer,
    $$CareLogsTableAnnotationComposer,
    $$CareLogsTableCreateCompanionBuilder,
    $$CareLogsTableUpdateCompanionBuilder,
    (CareLogRow, $$CareLogsTableReferences),
    CareLogRow,
    PrefetchHooks Function({bool plantId})>;
typedef $$CareSchedulesTableCreateCompanionBuilder = CareSchedulesCompanion
    Function({
  required String id,
  required String plantId,
  required String careType,
  required int intervalDays,
  required DateTime nextDueDate,
  Value<bool> isEnabled,
  Value<int> rowid,
});
typedef $$CareSchedulesTableUpdateCompanionBuilder = CareSchedulesCompanion
    Function({
  Value<String> id,
  Value<String> plantId,
  Value<String> careType,
  Value<int> intervalDays,
  Value<DateTime> nextDueDate,
  Value<bool> isEnabled,
  Value<int> rowid,
});

final class $$CareSchedulesTableReferences extends BaseReferences<_$AppDatabase,
    $CareSchedulesTable, CareScheduleRow> {
  $$CareSchedulesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlantsTable _plantIdTable(_$AppDatabase db) => db.plants.createAlias(
      $_aliasNameGenerator(db.careSchedules.plantId, db.plants.id));

  $$PlantsTableProcessedTableManager get plantId {
    final $_column = $_itemColumn<String>('plant_id')!;

    final manager = $$PlantsTableTableManager($_db, $_db.plants)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CareSchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get careType => $composableBuilder(
      column: $table.careType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  $$PlantsTableFilterComposer get plantId {
    final $$PlantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableFilterComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareSchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get careType => $composableBuilder(
      column: $table.careType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  $$PlantsTableOrderingComposer get plantId {
    final $$PlantsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableOrderingComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareSchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareSchedulesTable> {
  $$CareSchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get careType =>
      $composableBuilder(column: $table.careType, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDueDate => $composableBuilder(
      column: $table.nextDueDate, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$PlantsTableAnnotationComposer get plantId {
    final $$PlantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableAnnotationComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CareSchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CareSchedulesTable,
    CareScheduleRow,
    $$CareSchedulesTableFilterComposer,
    $$CareSchedulesTableOrderingComposer,
    $$CareSchedulesTableAnnotationComposer,
    $$CareSchedulesTableCreateCompanionBuilder,
    $$CareSchedulesTableUpdateCompanionBuilder,
    (CareScheduleRow, $$CareSchedulesTableReferences),
    CareScheduleRow,
    PrefetchHooks Function({bool plantId})> {
  $$CareSchedulesTableTableManager(_$AppDatabase db, $CareSchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareSchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareSchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareSchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> plantId = const Value.absent(),
            Value<String> careType = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<DateTime> nextDueDate = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CareSchedulesCompanion(
            id: id,
            plantId: plantId,
            careType: careType,
            intervalDays: intervalDays,
            nextDueDate: nextDueDate,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String plantId,
            required String careType,
            required int intervalDays,
            required DateTime nextDueDate,
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CareSchedulesCompanion.insert(
            id: id,
            plantId: plantId,
            careType: careType,
            intervalDays: intervalDays,
            nextDueDate: nextDueDate,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CareSchedulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({plantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (plantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.plantId,
                    referencedTable:
                        $$CareSchedulesTableReferences._plantIdTable(db),
                    referencedColumn:
                        $$CareSchedulesTableReferences._plantIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CareSchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CareSchedulesTable,
    CareScheduleRow,
    $$CareSchedulesTableFilterComposer,
    $$CareSchedulesTableOrderingComposer,
    $$CareSchedulesTableAnnotationComposer,
    $$CareSchedulesTableCreateCompanionBuilder,
    $$CareSchedulesTableUpdateCompanionBuilder,
    (CareScheduleRow, $$CareSchedulesTableReferences),
    CareScheduleRow,
    PrefetchHooks Function({bool plantId})>;
typedef $$PlantPhotosTableCreateCompanionBuilder = PlantPhotosCompanion
    Function({
  required String id,
  required String plantId,
  required String filePath,
  Value<String?> caption,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PlantPhotosTableUpdateCompanionBuilder = PlantPhotosCompanion
    Function({
  Value<String> id,
  Value<String> plantId,
  Value<String> filePath,
  Value<String?> caption,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PlantPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PlantPhotosTable, PlantPhotoRow> {
  $$PlantPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlantsTable _plantIdTable(_$AppDatabase db) => db.plants
      .createAlias($_aliasNameGenerator(db.plantPhotos.plantId, db.plants.id));

  $$PlantsTableProcessedTableManager get plantId {
    final $_column = $_itemColumn<String>('plant_id')!;

    final manager = $$PlantsTableTableManager($_db, $_db.plants)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_plantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlantPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PlantPhotosTable> {
  $$PlantPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caption => $composableBuilder(
      column: $table.caption, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PlantsTableFilterComposer get plantId {
    final $$PlantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableFilterComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlantPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PlantPhotosTable> {
  $$PlantPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caption => $composableBuilder(
      column: $table.caption, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PlantsTableOrderingComposer get plantId {
    final $$PlantsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableOrderingComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlantPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlantPhotosTable> {
  $$PlantPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlantsTableAnnotationComposer get plantId {
    final $$PlantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.plantId,
        referencedTable: $db.plants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlantsTableAnnotationComposer(
              $db: $db,
              $table: $db.plants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlantPhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlantPhotosTable,
    PlantPhotoRow,
    $$PlantPhotosTableFilterComposer,
    $$PlantPhotosTableOrderingComposer,
    $$PlantPhotosTableAnnotationComposer,
    $$PlantPhotosTableCreateCompanionBuilder,
    $$PlantPhotosTableUpdateCompanionBuilder,
    (PlantPhotoRow, $$PlantPhotosTableReferences),
    PlantPhotoRow,
    PrefetchHooks Function({bool plantId})> {
  $$PlantPhotosTableTableManager(_$AppDatabase db, $PlantPhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlantPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlantPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlantPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> plantId = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String?> caption = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlantPhotosCompanion(
            id: id,
            plantId: plantId,
            filePath: filePath,
            caption: caption,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String plantId,
            required String filePath,
            Value<String?> caption = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlantPhotosCompanion.insert(
            id: id,
            plantId: plantId,
            filePath: filePath,
            caption: caption,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlantPhotosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({plantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (plantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.plantId,
                    referencedTable:
                        $$PlantPhotosTableReferences._plantIdTable(db),
                    referencedColumn:
                        $$PlantPhotosTableReferences._plantIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlantPhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlantPhotosTable,
    PlantPhotoRow,
    $$PlantPhotosTableFilterComposer,
    $$PlantPhotosTableOrderingComposer,
    $$PlantPhotosTableAnnotationComposer,
    $$PlantPhotosTableCreateCompanionBuilder,
    $$PlantPhotosTableUpdateCompanionBuilder,
    (PlantPhotoRow, $$PlantPhotosTableReferences),
    PlantPhotoRow,
    PrefetchHooks Function({bool plantId})>;
typedef $$UserSettingsTableTableCreateCompanionBuilder
    = UserSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> notificationEnabled,
  Value<int> waterReminderHour,
  Value<int> waterReminderMinute,
  Value<bool> fertilizerReminderEnabled,
  Value<bool> isDarkMode,
});
typedef $$UserSettingsTableTableUpdateCompanionBuilder
    = UserSettingsTableCompanion Function({
  Value<int> id,
  Value<bool> notificationEnabled,
  Value<int> waterReminderHour,
  Value<int> waterReminderMinute,
  Value<bool> fertilizerReminderEnabled,
  Value<bool> isDarkMode,
});

class $$UserSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get waterReminderHour => $composableBuilder(
      column: $table.waterReminderHour,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get waterReminderMinute => $composableBuilder(
      column: $table.waterReminderMinute,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get fertilizerReminderEnabled => $composableBuilder(
      column: $table.fertilizerReminderEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => ColumnFilters(column));
}

class $$UserSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get waterReminderHour => $composableBuilder(
      column: $table.waterReminderHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get waterReminderMinute => $composableBuilder(
      column: $table.waterReminderMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get fertilizerReminderEnabled => $composableBuilder(
      column: $table.fertilizerReminderEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => ColumnOrderings(column));
}

class $$UserSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTableTable> {
  $$UserSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationEnabled => $composableBuilder(
      column: $table.notificationEnabled, builder: (column) => column);

  GeneratedColumn<int> get waterReminderHour => $composableBuilder(
      column: $table.waterReminderHour, builder: (column) => column);

  GeneratedColumn<int> get waterReminderMinute => $composableBuilder(
      column: $table.waterReminderMinute, builder: (column) => column);

  GeneratedColumn<bool> get fertilizerReminderEnabled => $composableBuilder(
      column: $table.fertilizerReminderEnabled, builder: (column) => column);

  GeneratedColumn<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => column);
}

class $$UserSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSettingsTableTable,
    UserSettingsRow,
    $$UserSettingsTableTableFilterComposer,
    $$UserSettingsTableTableOrderingComposer,
    $$UserSettingsTableTableAnnotationComposer,
    $$UserSettingsTableTableCreateCompanionBuilder,
    $$UserSettingsTableTableUpdateCompanionBuilder,
    (
      UserSettingsRow,
      BaseReferences<_$AppDatabase, $UserSettingsTableTable, UserSettingsRow>
    ),
    UserSettingsRow,
    PrefetchHooks Function()> {
  $$UserSettingsTableTableTableManager(
      _$AppDatabase db, $UserSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationEnabled = const Value.absent(),
            Value<int> waterReminderHour = const Value.absent(),
            Value<int> waterReminderMinute = const Value.absent(),
            Value<bool> fertilizerReminderEnabled = const Value.absent(),
            Value<bool> isDarkMode = const Value.absent(),
          }) =>
              UserSettingsTableCompanion(
            id: id,
            notificationEnabled: notificationEnabled,
            waterReminderHour: waterReminderHour,
            waterReminderMinute: waterReminderMinute,
            fertilizerReminderEnabled: fertilizerReminderEnabled,
            isDarkMode: isDarkMode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationEnabled = const Value.absent(),
            Value<int> waterReminderHour = const Value.absent(),
            Value<int> waterReminderMinute = const Value.absent(),
            Value<bool> fertilizerReminderEnabled = const Value.absent(),
            Value<bool> isDarkMode = const Value.absent(),
          }) =>
              UserSettingsTableCompanion.insert(
            id: id,
            notificationEnabled: notificationEnabled,
            waterReminderHour: waterReminderHour,
            waterReminderMinute: waterReminderMinute,
            fertilizerReminderEnabled: fertilizerReminderEnabled,
            isDarkMode: isDarkMode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSettingsTableTable,
    UserSettingsRow,
    $$UserSettingsTableTableFilterComposer,
    $$UserSettingsTableTableOrderingComposer,
    $$UserSettingsTableTableAnnotationComposer,
    $$UserSettingsTableTableCreateCompanionBuilder,
    $$UserSettingsTableTableUpdateCompanionBuilder,
    (
      UserSettingsRow,
      BaseReferences<_$AppDatabase, $UserSettingsTableTable, UserSettingsRow>
    ),
    UserSettingsRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlantsTableTableManager get plants =>
      $$PlantsTableTableManager(_db, _db.plants);
  $$CareLogsTableTableManager get careLogs =>
      $$CareLogsTableTableManager(_db, _db.careLogs);
  $$CareSchedulesTableTableManager get careSchedules =>
      $$CareSchedulesTableTableManager(_db, _db.careSchedules);
  $$PlantPhotosTableTableManager get plantPhotos =>
      $$PlantPhotosTableTableManager(_db, _db.plantPhotos);
  $$UserSettingsTableTableTableManager get userSettingsTable =>
      $$UserSettingsTableTableTableManager(_db, _db.userSettingsTable);
}

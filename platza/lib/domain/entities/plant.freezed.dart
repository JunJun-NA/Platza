// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Plant {
  String get id;
  String get nickname;
  String get speciesId;
  PlantLocation get location;
  PlantStatus get status;
  GrowthStage get growthStage;
  DateTime? get lastWatered;
  DateTime? get lastFertilized;
  DateTime? get lastRepotted;
  DateTime get createdAt;
  int get streakDays;

  /// Create a copy of Plant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlantCopyWith<Plant> get copyWith =>
      _$PlantCopyWithImpl<Plant>(this as Plant, _$identity);

  /// Serializes this Plant to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Plant &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.growthStage, growthStage) ||
                other.growthStage == growthStage) &&
            (identical(other.lastWatered, lastWatered) ||
                other.lastWatered == lastWatered) &&
            (identical(other.lastFertilized, lastFertilized) ||
                other.lastFertilized == lastFertilized) &&
            (identical(other.lastRepotted, lastRepotted) ||
                other.lastRepotted == lastRepotted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
  String toString() {
    return 'Plant(id: $id, nickname: $nickname, speciesId: $speciesId, location: $location, status: $status, growthStage: $growthStage, lastWatered: $lastWatered, lastFertilized: $lastFertilized, lastRepotted: $lastRepotted, createdAt: $createdAt, streakDays: $streakDays)';
  }
}

/// @nodoc
abstract mixin class $PlantCopyWith<$Res> {
  factory $PlantCopyWith(Plant value, $Res Function(Plant) _then) =
      _$PlantCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String nickname,
      String speciesId,
      PlantLocation location,
      PlantStatus status,
      GrowthStage growthStage,
      DateTime? lastWatered,
      DateTime? lastFertilized,
      DateTime? lastRepotted,
      DateTime createdAt,
      int streakDays});
}

/// @nodoc
class _$PlantCopyWithImpl<$Res> implements $PlantCopyWith<$Res> {
  _$PlantCopyWithImpl(this._self, this._then);

  final Plant _self;
  final $Res Function(Plant) _then;

  /// Create a copy of Plant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? speciesId = null,
    Object? location = null,
    Object? status = null,
    Object? growthStage = null,
    Object? lastWatered = freezed,
    Object? lastFertilized = freezed,
    Object? lastRepotted = freezed,
    Object? createdAt = null,
    Object? streakDays = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      speciesId: null == speciesId
          ? _self.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as PlantLocation,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlantStatus,
      growthStage: null == growthStage
          ? _self.growthStage
          : growthStage // ignore: cast_nullable_to_non_nullable
              as GrowthStage,
      lastWatered: freezed == lastWatered
          ? _self.lastWatered
          : lastWatered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastFertilized: freezed == lastFertilized
          ? _self.lastFertilized
          : lastFertilized // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRepotted: freezed == lastRepotted
          ? _self.lastRepotted
          : lastRepotted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Plant].
extension PlantPatterns on Plant {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Plant value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Plant() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Plant value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Plant():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Plant value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Plant() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String nickname,
            String speciesId,
            PlantLocation location,
            PlantStatus status,
            GrowthStage growthStage,
            DateTime? lastWatered,
            DateTime? lastFertilized,
            DateTime? lastRepotted,
            DateTime createdAt,
            int streakDays)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Plant() when $default != null:
        return $default(
            _that.id,
            _that.nickname,
            _that.speciesId,
            _that.location,
            _that.status,
            _that.growthStage,
            _that.lastWatered,
            _that.lastFertilized,
            _that.lastRepotted,
            _that.createdAt,
            _that.streakDays);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String nickname,
            String speciesId,
            PlantLocation location,
            PlantStatus status,
            GrowthStage growthStage,
            DateTime? lastWatered,
            DateTime? lastFertilized,
            DateTime? lastRepotted,
            DateTime createdAt,
            int streakDays)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Plant():
        return $default(
            _that.id,
            _that.nickname,
            _that.speciesId,
            _that.location,
            _that.status,
            _that.growthStage,
            _that.lastWatered,
            _that.lastFertilized,
            _that.lastRepotted,
            _that.createdAt,
            _that.streakDays);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String nickname,
            String speciesId,
            PlantLocation location,
            PlantStatus status,
            GrowthStage growthStage,
            DateTime? lastWatered,
            DateTime? lastFertilized,
            DateTime? lastRepotted,
            DateTime createdAt,
            int streakDays)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Plant() when $default != null:
        return $default(
            _that.id,
            _that.nickname,
            _that.speciesId,
            _that.location,
            _that.status,
            _that.growthStage,
            _that.lastWatered,
            _that.lastFertilized,
            _that.lastRepotted,
            _that.createdAt,
            _that.streakDays);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Plant extends Plant {
  const _Plant(
      {required this.id,
      required this.nickname,
      required this.speciesId,
      required this.location,
      this.status = PlantStatus.happy,
      this.growthStage = GrowthStage.seedling,
      this.lastWatered,
      this.lastFertilized,
      this.lastRepotted,
      required this.createdAt,
      this.streakDays = 0})
      : super._();
  factory _Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);

  @override
  final String id;
  @override
  final String nickname;
  @override
  final String speciesId;
  @override
  final PlantLocation location;
  @override
  @JsonKey()
  final PlantStatus status;
  @override
  @JsonKey()
  final GrowthStage growthStage;
  @override
  final DateTime? lastWatered;
  @override
  final DateTime? lastFertilized;
  @override
  final DateTime? lastRepotted;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int streakDays;

  /// Create a copy of Plant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlantCopyWith<_Plant> get copyWith =>
      __$PlantCopyWithImpl<_Plant>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlantToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Plant &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.speciesId, speciesId) ||
                other.speciesId == speciesId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.growthStage, growthStage) ||
                other.growthStage == growthStage) &&
            (identical(other.lastWatered, lastWatered) ||
                other.lastWatered == lastWatered) &&
            (identical(other.lastFertilized, lastFertilized) ||
                other.lastFertilized == lastFertilized) &&
            (identical(other.lastRepotted, lastRepotted) ||
                other.lastRepotted == lastRepotted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
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
  String toString() {
    return 'Plant(id: $id, nickname: $nickname, speciesId: $speciesId, location: $location, status: $status, growthStage: $growthStage, lastWatered: $lastWatered, lastFertilized: $lastFertilized, lastRepotted: $lastRepotted, createdAt: $createdAt, streakDays: $streakDays)';
  }
}

/// @nodoc
abstract mixin class _$PlantCopyWith<$Res> implements $PlantCopyWith<$Res> {
  factory _$PlantCopyWith(_Plant value, $Res Function(_Plant) _then) =
      __$PlantCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String nickname,
      String speciesId,
      PlantLocation location,
      PlantStatus status,
      GrowthStage growthStage,
      DateTime? lastWatered,
      DateTime? lastFertilized,
      DateTime? lastRepotted,
      DateTime createdAt,
      int streakDays});
}

/// @nodoc
class __$PlantCopyWithImpl<$Res> implements _$PlantCopyWith<$Res> {
  __$PlantCopyWithImpl(this._self, this._then);

  final _Plant _self;
  final $Res Function(_Plant) _then;

  /// Create a copy of Plant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? speciesId = null,
    Object? location = null,
    Object? status = null,
    Object? growthStage = null,
    Object? lastWatered = freezed,
    Object? lastFertilized = freezed,
    Object? lastRepotted = freezed,
    Object? createdAt = null,
    Object? streakDays = null,
  }) {
    return _then(_Plant(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      speciesId: null == speciesId
          ? _self.speciesId
          : speciesId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as PlantLocation,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlantStatus,
      growthStage: null == growthStage
          ? _self.growthStage
          : growthStage // ignore: cast_nullable_to_non_nullable
              as GrowthStage,
      lastWatered: freezed == lastWatered
          ? _self.lastWatered
          : lastWatered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastFertilized: freezed == lastFertilized
          ? _self.lastFertilized
          : lastFertilized // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastRepotted: freezed == lastRepotted
          ? _self.lastRepotted
          : lastRepotted // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      streakDays: null == streakDays
          ? _self.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on

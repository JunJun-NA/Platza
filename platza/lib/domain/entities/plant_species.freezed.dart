// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_species.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantSpecies {
  String get id;
  String get name;
  PlantCategory get category;
  int get waterFrequencyDays;
  int get fertilizerFrequencyDays;
  int get repotFrequencyDays;
  SunlightNeed get sunlightNeed;
  String get winterCare;
  String get summerCare;
  String get description;
  String get assetPrefix;

  /// Create a copy of PlantSpecies
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlantSpeciesCopyWith<PlantSpecies> get copyWith =>
      _$PlantSpeciesCopyWithImpl<PlantSpecies>(
          this as PlantSpecies, _$identity);

  /// Serializes this PlantSpecies to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlantSpecies &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.waterFrequencyDays, waterFrequencyDays) ||
                other.waterFrequencyDays == waterFrequencyDays) &&
            (identical(
                    other.fertilizerFrequencyDays, fertilizerFrequencyDays) ||
                other.fertilizerFrequencyDays == fertilizerFrequencyDays) &&
            (identical(other.repotFrequencyDays, repotFrequencyDays) ||
                other.repotFrequencyDays == repotFrequencyDays) &&
            (identical(other.sunlightNeed, sunlightNeed) ||
                other.sunlightNeed == sunlightNeed) &&
            (identical(other.winterCare, winterCare) ||
                other.winterCare == winterCare) &&
            (identical(other.summerCare, summerCare) ||
                other.summerCare == summerCare) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.assetPrefix, assetPrefix) ||
                other.assetPrefix == assetPrefix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      waterFrequencyDays,
      fertilizerFrequencyDays,
      repotFrequencyDays,
      sunlightNeed,
      winterCare,
      summerCare,
      description,
      assetPrefix);

  @override
  String toString() {
    return 'PlantSpecies(id: $id, name: $name, category: $category, waterFrequencyDays: $waterFrequencyDays, fertilizerFrequencyDays: $fertilizerFrequencyDays, repotFrequencyDays: $repotFrequencyDays, sunlightNeed: $sunlightNeed, winterCare: $winterCare, summerCare: $summerCare, description: $description, assetPrefix: $assetPrefix)';
  }
}

/// @nodoc
abstract mixin class $PlantSpeciesCopyWith<$Res> {
  factory $PlantSpeciesCopyWith(
          PlantSpecies value, $Res Function(PlantSpecies) _then) =
      _$PlantSpeciesCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      PlantCategory category,
      int waterFrequencyDays,
      int fertilizerFrequencyDays,
      int repotFrequencyDays,
      SunlightNeed sunlightNeed,
      String winterCare,
      String summerCare,
      String description,
      String assetPrefix});
}

/// @nodoc
class _$PlantSpeciesCopyWithImpl<$Res> implements $PlantSpeciesCopyWith<$Res> {
  _$PlantSpeciesCopyWithImpl(this._self, this._then);

  final PlantSpecies _self;
  final $Res Function(PlantSpecies) _then;

  /// Create a copy of PlantSpecies
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? waterFrequencyDays = null,
    Object? fertilizerFrequencyDays = null,
    Object? repotFrequencyDays = null,
    Object? sunlightNeed = null,
    Object? winterCare = null,
    Object? summerCare = null,
    Object? description = null,
    Object? assetPrefix = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as PlantCategory,
      waterFrequencyDays: null == waterFrequencyDays
          ? _self.waterFrequencyDays
          : waterFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      fertilizerFrequencyDays: null == fertilizerFrequencyDays
          ? _self.fertilizerFrequencyDays
          : fertilizerFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      repotFrequencyDays: null == repotFrequencyDays
          ? _self.repotFrequencyDays
          : repotFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      sunlightNeed: null == sunlightNeed
          ? _self.sunlightNeed
          : sunlightNeed // ignore: cast_nullable_to_non_nullable
              as SunlightNeed,
      winterCare: null == winterCare
          ? _self.winterCare
          : winterCare // ignore: cast_nullable_to_non_nullable
              as String,
      summerCare: null == summerCare
          ? _self.summerCare
          : summerCare // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      assetPrefix: null == assetPrefix
          ? _self.assetPrefix
          : assetPrefix // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlantSpecies].
extension PlantSpeciesPatterns on PlantSpecies {
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
    TResult Function(_PlantSpecies value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies() when $default != null:
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
    TResult Function(_PlantSpecies value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies():
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
    TResult? Function(_PlantSpecies value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies() when $default != null:
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
            String name,
            PlantCategory category,
            int waterFrequencyDays,
            int fertilizerFrequencyDays,
            int repotFrequencyDays,
            SunlightNeed sunlightNeed,
            String winterCare,
            String summerCare,
            String description,
            String assetPrefix)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.category,
            _that.waterFrequencyDays,
            _that.fertilizerFrequencyDays,
            _that.repotFrequencyDays,
            _that.sunlightNeed,
            _that.winterCare,
            _that.summerCare,
            _that.description,
            _that.assetPrefix);
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
            String name,
            PlantCategory category,
            int waterFrequencyDays,
            int fertilizerFrequencyDays,
            int repotFrequencyDays,
            SunlightNeed sunlightNeed,
            String winterCare,
            String summerCare,
            String description,
            String assetPrefix)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies():
        return $default(
            _that.id,
            _that.name,
            _that.category,
            _that.waterFrequencyDays,
            _that.fertilizerFrequencyDays,
            _that.repotFrequencyDays,
            _that.sunlightNeed,
            _that.winterCare,
            _that.summerCare,
            _that.description,
            _that.assetPrefix);
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
            String name,
            PlantCategory category,
            int waterFrequencyDays,
            int fertilizerFrequencyDays,
            int repotFrequencyDays,
            SunlightNeed sunlightNeed,
            String winterCare,
            String summerCare,
            String description,
            String assetPrefix)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantSpecies() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.category,
            _that.waterFrequencyDays,
            _that.fertilizerFrequencyDays,
            _that.repotFrequencyDays,
            _that.sunlightNeed,
            _that.winterCare,
            _that.summerCare,
            _that.description,
            _that.assetPrefix);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlantSpecies implements PlantSpecies {
  const _PlantSpecies(
      {required this.id,
      required this.name,
      required this.category,
      required this.waterFrequencyDays,
      required this.fertilizerFrequencyDays,
      required this.repotFrequencyDays,
      required this.sunlightNeed,
      required this.winterCare,
      required this.summerCare,
      required this.description,
      required this.assetPrefix});
  factory _PlantSpecies.fromJson(Map<String, dynamic> json) =>
      _$PlantSpeciesFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final PlantCategory category;
  @override
  final int waterFrequencyDays;
  @override
  final int fertilizerFrequencyDays;
  @override
  final int repotFrequencyDays;
  @override
  final SunlightNeed sunlightNeed;
  @override
  final String winterCare;
  @override
  final String summerCare;
  @override
  final String description;
  @override
  final String assetPrefix;

  /// Create a copy of PlantSpecies
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlantSpeciesCopyWith<_PlantSpecies> get copyWith =>
      __$PlantSpeciesCopyWithImpl<_PlantSpecies>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlantSpeciesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlantSpecies &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.waterFrequencyDays, waterFrequencyDays) ||
                other.waterFrequencyDays == waterFrequencyDays) &&
            (identical(
                    other.fertilizerFrequencyDays, fertilizerFrequencyDays) ||
                other.fertilizerFrequencyDays == fertilizerFrequencyDays) &&
            (identical(other.repotFrequencyDays, repotFrequencyDays) ||
                other.repotFrequencyDays == repotFrequencyDays) &&
            (identical(other.sunlightNeed, sunlightNeed) ||
                other.sunlightNeed == sunlightNeed) &&
            (identical(other.winterCare, winterCare) ||
                other.winterCare == winterCare) &&
            (identical(other.summerCare, summerCare) ||
                other.summerCare == summerCare) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.assetPrefix, assetPrefix) ||
                other.assetPrefix == assetPrefix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      waterFrequencyDays,
      fertilizerFrequencyDays,
      repotFrequencyDays,
      sunlightNeed,
      winterCare,
      summerCare,
      description,
      assetPrefix);

  @override
  String toString() {
    return 'PlantSpecies(id: $id, name: $name, category: $category, waterFrequencyDays: $waterFrequencyDays, fertilizerFrequencyDays: $fertilizerFrequencyDays, repotFrequencyDays: $repotFrequencyDays, sunlightNeed: $sunlightNeed, winterCare: $winterCare, summerCare: $summerCare, description: $description, assetPrefix: $assetPrefix)';
  }
}

/// @nodoc
abstract mixin class _$PlantSpeciesCopyWith<$Res>
    implements $PlantSpeciesCopyWith<$Res> {
  factory _$PlantSpeciesCopyWith(
          _PlantSpecies value, $Res Function(_PlantSpecies) _then) =
      __$PlantSpeciesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      PlantCategory category,
      int waterFrequencyDays,
      int fertilizerFrequencyDays,
      int repotFrequencyDays,
      SunlightNeed sunlightNeed,
      String winterCare,
      String summerCare,
      String description,
      String assetPrefix});
}

/// @nodoc
class __$PlantSpeciesCopyWithImpl<$Res>
    implements _$PlantSpeciesCopyWith<$Res> {
  __$PlantSpeciesCopyWithImpl(this._self, this._then);

  final _PlantSpecies _self;
  final $Res Function(_PlantSpecies) _then;

  /// Create a copy of PlantSpecies
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? waterFrequencyDays = null,
    Object? fertilizerFrequencyDays = null,
    Object? repotFrequencyDays = null,
    Object? sunlightNeed = null,
    Object? winterCare = null,
    Object? summerCare = null,
    Object? description = null,
    Object? assetPrefix = null,
  }) {
    return _then(_PlantSpecies(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as PlantCategory,
      waterFrequencyDays: null == waterFrequencyDays
          ? _self.waterFrequencyDays
          : waterFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      fertilizerFrequencyDays: null == fertilizerFrequencyDays
          ? _self.fertilizerFrequencyDays
          : fertilizerFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      repotFrequencyDays: null == repotFrequencyDays
          ? _self.repotFrequencyDays
          : repotFrequencyDays // ignore: cast_nullable_to_non_nullable
              as int,
      sunlightNeed: null == sunlightNeed
          ? _self.sunlightNeed
          : sunlightNeed // ignore: cast_nullable_to_non_nullable
              as SunlightNeed,
      winterCare: null == winterCare
          ? _self.winterCare
          : winterCare // ignore: cast_nullable_to_non_nullable
              as String,
      summerCare: null == summerCare
          ? _self.summerCare
          : summerCare // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      assetPrefix: null == assetPrefix
          ? _self.assetPrefix
          : assetPrefix // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlantPhoto {
  String get id;
  String get plantId;
  String get filePath;
  String? get caption;
  DateTime get createdAt;

  /// Create a copy of PlantPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlantPhotoCopyWith<PlantPhoto> get copyWith =>
      _$PlantPhotoCopyWithImpl<PlantPhoto>(this as PlantPhoto, _$identity);

  /// Serializes this PlantPhoto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlantPhoto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, plantId, filePath, caption, createdAt);

  @override
  String toString() {
    return 'PlantPhoto(id: $id, plantId: $plantId, filePath: $filePath, caption: $caption, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PlantPhotoCopyWith<$Res> {
  factory $PlantPhotoCopyWith(
          PlantPhoto value, $Res Function(PlantPhoto) _then) =
      _$PlantPhotoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String plantId,
      String filePath,
      String? caption,
      DateTime createdAt});
}

/// @nodoc
class _$PlantPhotoCopyWithImpl<$Res> implements $PlantPhotoCopyWith<$Res> {
  _$PlantPhotoCopyWithImpl(this._self, this._then);

  final PlantPhoto _self;
  final $Res Function(PlantPhoto) _then;

  /// Create a copy of PlantPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? filePath = null,
    Object? caption = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      plantId: null == plantId
          ? _self.plantId
          : plantId // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlantPhoto].
extension PlantPhotoPatterns on PlantPhoto {
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
    TResult Function(_PlantPhoto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto() when $default != null:
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
    TResult Function(_PlantPhoto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto():
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
    TResult? Function(_PlantPhoto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto() when $default != null:
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
    TResult Function(String id, String plantId, String filePath,
            String? caption, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto() when $default != null:
        return $default(_that.id, _that.plantId, _that.filePath, _that.caption,
            _that.createdAt);
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
    TResult Function(String id, String plantId, String filePath,
            String? caption, DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto():
        return $default(_that.id, _that.plantId, _that.filePath, _that.caption,
            _that.createdAt);
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
    TResult? Function(String id, String plantId, String filePath,
            String? caption, DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlantPhoto() when $default != null:
        return $default(_that.id, _that.plantId, _that.filePath, _that.caption,
            _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _PlantPhoto implements PlantPhoto {
  const _PlantPhoto(
      {required this.id,
      required this.plantId,
      required this.filePath,
      this.caption,
      required this.createdAt});
  factory _PlantPhoto.fromJson(Map<String, dynamic> json) =>
      _$PlantPhotoFromJson(json);

  @override
  final String id;
  @override
  final String plantId;
  @override
  final String filePath;
  @override
  final String? caption;
  @override
  final DateTime createdAt;

  /// Create a copy of PlantPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlantPhotoCopyWith<_PlantPhoto> get copyWith =>
      __$PlantPhotoCopyWithImpl<_PlantPhoto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PlantPhotoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlantPhoto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, plantId, filePath, caption, createdAt);

  @override
  String toString() {
    return 'PlantPhoto(id: $id, plantId: $plantId, filePath: $filePath, caption: $caption, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PlantPhotoCopyWith<$Res>
    implements $PlantPhotoCopyWith<$Res> {
  factory _$PlantPhotoCopyWith(
          _PlantPhoto value, $Res Function(_PlantPhoto) _then) =
      __$PlantPhotoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String plantId,
      String filePath,
      String? caption,
      DateTime createdAt});
}

/// @nodoc
class __$PlantPhotoCopyWithImpl<$Res> implements _$PlantPhotoCopyWith<$Res> {
  __$PlantPhotoCopyWithImpl(this._self, this._then);

  final _PlantPhoto _self;
  final $Res Function(_PlantPhoto) _then;

  /// Create a copy of PlantPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? filePath = null,
    Object? caption = freezed,
    Object? createdAt = null,
  }) {
    return _then(_PlantPhoto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      plantId: null == plantId
          ? _self.plantId
          : plantId // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on

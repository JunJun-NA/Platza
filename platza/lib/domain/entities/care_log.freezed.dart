// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CareLog {
  String get id;
  String get plantId;
  CareType get careType;
  DateTime get performedAt;
  String? get note;

  /// Create a copy of CareLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CareLogCopyWith<CareLog> get copyWith =>
      _$CareLogCopyWithImpl<CareLog>(this as CareLog, _$identity);

  /// Serializes this CareLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CareLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.careType, careType) ||
                other.careType == careType) &&
            (identical(other.performedAt, performedAt) ||
                other.performedAt == performedAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, plantId, careType, performedAt, note);

  @override
  String toString() {
    return 'CareLog(id: $id, plantId: $plantId, careType: $careType, performedAt: $performedAt, note: $note)';
  }
}

/// @nodoc
abstract mixin class $CareLogCopyWith<$Res> {
  factory $CareLogCopyWith(CareLog value, $Res Function(CareLog) _then) =
      _$CareLogCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String plantId,
      CareType careType,
      DateTime performedAt,
      String? note});
}

/// @nodoc
class _$CareLogCopyWithImpl<$Res> implements $CareLogCopyWith<$Res> {
  _$CareLogCopyWithImpl(this._self, this._then);

  final CareLog _self;
  final $Res Function(CareLog) _then;

  /// Create a copy of CareLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? careType = null,
    Object? performedAt = null,
    Object? note = freezed,
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
      careType: null == careType
          ? _self.careType
          : careType // ignore: cast_nullable_to_non_nullable
              as CareType,
      performedAt: null == performedAt
          ? _self.performedAt
          : performedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CareLog].
extension CareLogPatterns on CareLog {
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
    TResult Function(_CareLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CareLog() when $default != null:
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
    TResult Function(_CareLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareLog():
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
    TResult? Function(_CareLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareLog() when $default != null:
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
    TResult Function(String id, String plantId, CareType careType,
            DateTime performedAt, String? note)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CareLog() when $default != null:
        return $default(_that.id, _that.plantId, _that.careType,
            _that.performedAt, _that.note);
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
    TResult Function(String id, String plantId, CareType careType,
            DateTime performedAt, String? note)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareLog():
        return $default(_that.id, _that.plantId, _that.careType,
            _that.performedAt, _that.note);
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
    TResult? Function(String id, String plantId, CareType careType,
            DateTime performedAt, String? note)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareLog() when $default != null:
        return $default(_that.id, _that.plantId, _that.careType,
            _that.performedAt, _that.note);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CareLog implements CareLog {
  const _CareLog(
      {required this.id,
      required this.plantId,
      required this.careType,
      required this.performedAt,
      this.note});
  factory _CareLog.fromJson(Map<String, dynamic> json) =>
      _$CareLogFromJson(json);

  @override
  final String id;
  @override
  final String plantId;
  @override
  final CareType careType;
  @override
  final DateTime performedAt;
  @override
  final String? note;

  /// Create a copy of CareLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CareLogCopyWith<_CareLog> get copyWith =>
      __$CareLogCopyWithImpl<_CareLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CareLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CareLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.careType, careType) ||
                other.careType == careType) &&
            (identical(other.performedAt, performedAt) ||
                other.performedAt == performedAt) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, plantId, careType, performedAt, note);

  @override
  String toString() {
    return 'CareLog(id: $id, plantId: $plantId, careType: $careType, performedAt: $performedAt, note: $note)';
  }
}

/// @nodoc
abstract mixin class _$CareLogCopyWith<$Res> implements $CareLogCopyWith<$Res> {
  factory _$CareLogCopyWith(_CareLog value, $Res Function(_CareLog) _then) =
      __$CareLogCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String plantId,
      CareType careType,
      DateTime performedAt,
      String? note});
}

/// @nodoc
class __$CareLogCopyWithImpl<$Res> implements _$CareLogCopyWith<$Res> {
  __$CareLogCopyWithImpl(this._self, this._then);

  final _CareLog _self;
  final $Res Function(_CareLog) _then;

  /// Create a copy of CareLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? careType = null,
    Object? performedAt = null,
    Object? note = freezed,
  }) {
    return _then(_CareLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      plantId: null == plantId
          ? _self.plantId
          : plantId // ignore: cast_nullable_to_non_nullable
              as String,
      careType: null == careType
          ? _self.careType
          : careType // ignore: cast_nullable_to_non_nullable
              as CareType,
      performedAt: null == performedAt
          ? _self.performedAt
          : performedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

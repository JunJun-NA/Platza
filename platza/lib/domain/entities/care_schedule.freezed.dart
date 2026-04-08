// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CareSchedule {
  String get id;
  String get plantId;
  CareType get careType;
  int get intervalDays;
  DateTime get nextDueDate;
  bool get isEnabled;

  /// Create a copy of CareSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CareScheduleCopyWith<CareSchedule> get copyWith =>
      _$CareScheduleCopyWithImpl<CareSchedule>(
          this as CareSchedule, _$identity);

  /// Serializes this CareSchedule to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CareSchedule &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.careType, careType) ||
                other.careType == careType) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, plantId, careType, intervalDays, nextDueDate, isEnabled);

  @override
  String toString() {
    return 'CareSchedule(id: $id, plantId: $plantId, careType: $careType, intervalDays: $intervalDays, nextDueDate: $nextDueDate, isEnabled: $isEnabled)';
  }
}

/// @nodoc
abstract mixin class $CareScheduleCopyWith<$Res> {
  factory $CareScheduleCopyWith(
          CareSchedule value, $Res Function(CareSchedule) _then) =
      _$CareScheduleCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String plantId,
      CareType careType,
      int intervalDays,
      DateTime nextDueDate,
      bool isEnabled});
}

/// @nodoc
class _$CareScheduleCopyWithImpl<$Res> implements $CareScheduleCopyWith<$Res> {
  _$CareScheduleCopyWithImpl(this._self, this._then);

  final CareSchedule _self;
  final $Res Function(CareSchedule) _then;

  /// Create a copy of CareSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? careType = null,
    Object? intervalDays = null,
    Object? nextDueDate = null,
    Object? isEnabled = null,
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
      intervalDays: null == intervalDays
          ? _self.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      nextDueDate: null == nextDueDate
          ? _self.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CareSchedule].
extension CareSchedulePatterns on CareSchedule {
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
    TResult Function(_CareSchedule value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CareSchedule() when $default != null:
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
    TResult Function(_CareSchedule value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareSchedule():
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
    TResult? Function(_CareSchedule value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareSchedule() when $default != null:
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
            int intervalDays, DateTime nextDueDate, bool isEnabled)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CareSchedule() when $default != null:
        return $default(_that.id, _that.plantId, _that.careType,
            _that.intervalDays, _that.nextDueDate, _that.isEnabled);
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
            int intervalDays, DateTime nextDueDate, bool isEnabled)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareSchedule():
        return $default(_that.id, _that.plantId, _that.careType,
            _that.intervalDays, _that.nextDueDate, _that.isEnabled);
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
            int intervalDays, DateTime nextDueDate, bool isEnabled)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CareSchedule() when $default != null:
        return $default(_that.id, _that.plantId, _that.careType,
            _that.intervalDays, _that.nextDueDate, _that.isEnabled);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CareSchedule implements CareSchedule {
  const _CareSchedule(
      {required this.id,
      required this.plantId,
      required this.careType,
      required this.intervalDays,
      required this.nextDueDate,
      this.isEnabled = true});
  factory _CareSchedule.fromJson(Map<String, dynamic> json) =>
      _$CareScheduleFromJson(json);

  @override
  final String id;
  @override
  final String plantId;
  @override
  final CareType careType;
  @override
  final int intervalDays;
  @override
  final DateTime nextDueDate;
  @override
  @JsonKey()
  final bool isEnabled;

  /// Create a copy of CareSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CareScheduleCopyWith<_CareSchedule> get copyWith =>
      __$CareScheduleCopyWithImpl<_CareSchedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CareScheduleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CareSchedule &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plantId, plantId) || other.plantId == plantId) &&
            (identical(other.careType, careType) ||
                other.careType == careType) &&
            (identical(other.intervalDays, intervalDays) ||
                other.intervalDays == intervalDays) &&
            (identical(other.nextDueDate, nextDueDate) ||
                other.nextDueDate == nextDueDate) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, plantId, careType, intervalDays, nextDueDate, isEnabled);

  @override
  String toString() {
    return 'CareSchedule(id: $id, plantId: $plantId, careType: $careType, intervalDays: $intervalDays, nextDueDate: $nextDueDate, isEnabled: $isEnabled)';
  }
}

/// @nodoc
abstract mixin class _$CareScheduleCopyWith<$Res>
    implements $CareScheduleCopyWith<$Res> {
  factory _$CareScheduleCopyWith(
          _CareSchedule value, $Res Function(_CareSchedule) _then) =
      __$CareScheduleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String plantId,
      CareType careType,
      int intervalDays,
      DateTime nextDueDate,
      bool isEnabled});
}

/// @nodoc
class __$CareScheduleCopyWithImpl<$Res>
    implements _$CareScheduleCopyWith<$Res> {
  __$CareScheduleCopyWithImpl(this._self, this._then);

  final _CareSchedule _self;
  final $Res Function(_CareSchedule) _then;

  /// Create a copy of CareSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? plantId = null,
    Object? careType = null,
    Object? intervalDays = null,
    Object? nextDueDate = null,
    Object? isEnabled = null,
  }) {
    return _then(_CareSchedule(
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
      intervalDays: null == intervalDays
          ? _self.intervalDays
          : intervalDays // ignore: cast_nullable_to_non_nullable
              as int,
      nextDueDate: null == nextDueDate
          ? _self.nextDueDate
          : nextDueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isEnabled: null == isEnabled
          ? _self.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

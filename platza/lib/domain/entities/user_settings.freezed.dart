// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSettings {
  bool get notificationEnabled;
  int get waterReminderHour;
  int get waterReminderMinute;
  bool get fertilizerReminderEnabled;
  bool get isDarkMode;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      _$UserSettingsCopyWithImpl<UserSettings>(
          this as UserSettings, _$identity);

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserSettings &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.waterReminderHour, waterReminderHour) ||
                other.waterReminderHour == waterReminderHour) &&
            (identical(other.waterReminderMinute, waterReminderMinute) ||
                other.waterReminderMinute == waterReminderMinute) &&
            (identical(other.fertilizerReminderEnabled,
                    fertilizerReminderEnabled) ||
                other.fertilizerReminderEnabled == fertilizerReminderEnabled) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationEnabled,
      waterReminderHour,
      waterReminderMinute,
      fertilizerReminderEnabled,
      isDarkMode);

  @override
  String toString() {
    return 'UserSettings(notificationEnabled: $notificationEnabled, waterReminderHour: $waterReminderHour, waterReminderMinute: $waterReminderMinute, fertilizerReminderEnabled: $fertilizerReminderEnabled, isDarkMode: $isDarkMode)';
  }
}

/// @nodoc
abstract mixin class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) _then) =
      _$UserSettingsCopyWithImpl;
  @useResult
  $Res call(
      {bool notificationEnabled,
      int waterReminderHour,
      int waterReminderMinute,
      bool fertilizerReminderEnabled,
      bool isDarkMode});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res> implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._self, this._then);

  final UserSettings _self;
  final $Res Function(UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationEnabled = null,
    Object? waterReminderHour = null,
    Object? waterReminderMinute = null,
    Object? fertilizerReminderEnabled = null,
    Object? isDarkMode = null,
  }) {
    return _then(_self.copyWith(
      notificationEnabled: null == notificationEnabled
          ? _self.notificationEnabled
          : notificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      waterReminderHour: null == waterReminderHour
          ? _self.waterReminderHour
          : waterReminderHour // ignore: cast_nullable_to_non_nullable
              as int,
      waterReminderMinute: null == waterReminderMinute
          ? _self.waterReminderMinute
          : waterReminderMinute // ignore: cast_nullable_to_non_nullable
              as int,
      fertilizerReminderEnabled: null == fertilizerReminderEnabled
          ? _self.fertilizerReminderEnabled
          : fertilizerReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _self.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserSettings].
extension UserSettingsPatterns on UserSettings {
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
    TResult Function(_UserSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
    TResult Function(_UserSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
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
    TResult? Function(_UserSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
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
            bool notificationEnabled,
            int waterReminderHour,
            int waterReminderMinute,
            bool fertilizerReminderEnabled,
            bool isDarkMode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(
            _that.notificationEnabled,
            _that.waterReminderHour,
            _that.waterReminderMinute,
            _that.fertilizerReminderEnabled,
            _that.isDarkMode);
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
            bool notificationEnabled,
            int waterReminderHour,
            int waterReminderMinute,
            bool fertilizerReminderEnabled,
            bool isDarkMode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings():
        return $default(
            _that.notificationEnabled,
            _that.waterReminderHour,
            _that.waterReminderMinute,
            _that.fertilizerReminderEnabled,
            _that.isDarkMode);
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
            bool notificationEnabled,
            int waterReminderHour,
            int waterReminderMinute,
            bool fertilizerReminderEnabled,
            bool isDarkMode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSettings() when $default != null:
        return $default(
            _that.notificationEnabled,
            _that.waterReminderHour,
            _that.waterReminderMinute,
            _that.fertilizerReminderEnabled,
            _that.isDarkMode);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserSettings implements UserSettings {
  const _UserSettings(
      {this.notificationEnabled = true,
      this.waterReminderHour = 8,
      this.waterReminderMinute = 0,
      this.fertilizerReminderEnabled = true,
      this.isDarkMode = false});
  factory _UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  @override
  @JsonKey()
  final bool notificationEnabled;
  @override
  @JsonKey()
  final int waterReminderHour;
  @override
  @JsonKey()
  final int waterReminderMinute;
  @override
  @JsonKey()
  final bool fertilizerReminderEnabled;
  @override
  @JsonKey()
  final bool isDarkMode;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSettingsCopyWith<_UserSettings> get copyWith =>
      __$UserSettingsCopyWithImpl<_UserSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserSettings &&
            (identical(other.notificationEnabled, notificationEnabled) ||
                other.notificationEnabled == notificationEnabled) &&
            (identical(other.waterReminderHour, waterReminderHour) ||
                other.waterReminderHour == waterReminderHour) &&
            (identical(other.waterReminderMinute, waterReminderMinute) ||
                other.waterReminderMinute == waterReminderMinute) &&
            (identical(other.fertilizerReminderEnabled,
                    fertilizerReminderEnabled) ||
                other.fertilizerReminderEnabled == fertilizerReminderEnabled) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationEnabled,
      waterReminderHour,
      waterReminderMinute,
      fertilizerReminderEnabled,
      isDarkMode);

  @override
  String toString() {
    return 'UserSettings(notificationEnabled: $notificationEnabled, waterReminderHour: $waterReminderHour, waterReminderMinute: $waterReminderMinute, fertilizerReminderEnabled: $fertilizerReminderEnabled, isDarkMode: $isDarkMode)';
  }
}

/// @nodoc
abstract mixin class _$UserSettingsCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$UserSettingsCopyWith(
          _UserSettings value, $Res Function(_UserSettings) _then) =
      __$UserSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool notificationEnabled,
      int waterReminderHour,
      int waterReminderMinute,
      bool fertilizerReminderEnabled,
      bool isDarkMode});
}

/// @nodoc
class __$UserSettingsCopyWithImpl<$Res>
    implements _$UserSettingsCopyWith<$Res> {
  __$UserSettingsCopyWithImpl(this._self, this._then);

  final _UserSettings _self;
  final $Res Function(_UserSettings) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notificationEnabled = null,
    Object? waterReminderHour = null,
    Object? waterReminderMinute = null,
    Object? fertilizerReminderEnabled = null,
    Object? isDarkMode = null,
  }) {
    return _then(_UserSettings(
      notificationEnabled: null == notificationEnabled
          ? _self.notificationEnabled
          : notificationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      waterReminderHour: null == waterReminderHour
          ? _self.waterReminderHour
          : waterReminderHour // ignore: cast_nullable_to_non_nullable
              as int,
      waterReminderMinute: null == waterReminderMinute
          ? _self.waterReminderMinute
          : waterReminderMinute // ignore: cast_nullable_to_non_nullable
              as int,
      fertilizerReminderEnabled: null == fertilizerReminderEnabled
          ? _self.fertilizerReminderEnabled
          : fertilizerReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isDarkMode: null == isDarkMode
          ? _self.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

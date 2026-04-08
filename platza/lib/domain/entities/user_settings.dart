import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

/// ユーザー設定
@freezed
abstract class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(true) bool notificationEnabled,
    @Default(8) int waterReminderHour,
    @Default(0) int waterReminderMinute,
    @Default(true) bool fertilizerReminderEnabled,
    @Default(false) bool isDarkMode,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}

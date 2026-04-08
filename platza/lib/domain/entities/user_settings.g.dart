// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) =>
    _UserSettings(
      notificationEnabled: json['notificationEnabled'] as bool? ?? true,
      waterReminderHour: (json['waterReminderHour'] as num?)?.toInt() ?? 8,
      waterReminderMinute: (json['waterReminderMinute'] as num?)?.toInt() ?? 0,
      fertilizerReminderEnabled:
          json['fertilizerReminderEnabled'] as bool? ?? true,
      isDarkMode: json['isDarkMode'] as bool? ?? false,
    );

Map<String, dynamic> _$UserSettingsToJson(_UserSettings instance) =>
    <String, dynamic>{
      'notificationEnabled': instance.notificationEnabled,
      'waterReminderHour': instance.waterReminderHour,
      'waterReminderMinute': instance.waterReminderMinute,
      'fertilizerReminderEnabled': instance.fertilizerReminderEnabled,
      'isDarkMode': instance.isDarkMode,
    };

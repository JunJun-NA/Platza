// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CareSchedule _$CareScheduleFromJson(Map<String, dynamic> json) =>
    _CareSchedule(
      id: json['id'] as String,
      plantId: json['plantId'] as String,
      careType: $enumDecode(_$CareTypeEnumMap, json['careType']),
      intervalDays: (json['intervalDays'] as num).toInt(),
      nextDueDate: DateTime.parse(json['nextDueDate'] as String),
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$CareScheduleToJson(_CareSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plantId': instance.plantId,
      'careType': _$CareTypeEnumMap[instance.careType]!,
      'intervalDays': instance.intervalDays,
      'nextDueDate': instance.nextDueDate.toIso8601String(),
      'isEnabled': instance.isEnabled,
    };

const _$CareTypeEnumMap = {
  CareType.water: 'water',
  CareType.fertilize: 'fertilize',
  CareType.repot: 'repot',
  CareType.sunlight: 'sunlight',
};

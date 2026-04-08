// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CareLog _$CareLogFromJson(Map<String, dynamic> json) => _CareLog(
      id: json['id'] as String,
      plantId: json['plantId'] as String,
      careType: $enumDecode(_$CareTypeEnumMap, json['careType']),
      performedAt: DateTime.parse(json['performedAt'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CareLogToJson(_CareLog instance) => <String, dynamic>{
      'id': instance.id,
      'plantId': instance.plantId,
      'careType': _$CareTypeEnumMap[instance.careType]!,
      'performedAt': instance.performedAt.toIso8601String(),
      'note': instance.note,
    };

const _$CareTypeEnumMap = {
  CareType.water: 'water',
  CareType.fertilize: 'fertilize',
  CareType.repot: 'repot',
  CareType.sunlight: 'sunlight',
};

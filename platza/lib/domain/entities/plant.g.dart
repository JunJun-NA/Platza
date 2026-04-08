// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Plant _$PlantFromJson(Map<String, dynamic> json) => _Plant(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      speciesId: json['speciesId'] as String,
      location: $enumDecode(_$PlantLocationEnumMap, json['location']),
      status: $enumDecodeNullable(_$PlantStatusEnumMap, json['status']) ??
          PlantStatus.happy,
      growthStage:
          $enumDecodeNullable(_$GrowthStageEnumMap, json['growthStage']) ??
              GrowthStage.seedling,
      lastWatered: json['lastWatered'] == null
          ? null
          : DateTime.parse(json['lastWatered'] as String),
      lastFertilized: json['lastFertilized'] == null
          ? null
          : DateTime.parse(json['lastFertilized'] as String),
      lastRepotted: json['lastRepotted'] == null
          ? null
          : DateTime.parse(json['lastRepotted'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      streakDays: (json['streakDays'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PlantToJson(_Plant instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'speciesId': instance.speciesId,
      'location': _$PlantLocationEnumMap[instance.location]!,
      'status': _$PlantStatusEnumMap[instance.status]!,
      'growthStage': _$GrowthStageEnumMap[instance.growthStage]!,
      'lastWatered': instance.lastWatered?.toIso8601String(),
      'lastFertilized': instance.lastFertilized?.toIso8601String(),
      'lastRepotted': instance.lastRepotted?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'streakDays': instance.streakDays,
    };

const _$PlantLocationEnumMap = {
  PlantLocation.indoor: 'indoor',
  PlantLocation.outdoor: 'outdoor',
  PlantLocation.window: 'window',
};

const _$PlantStatusEnumMap = {
  PlantStatus.happy: 'happy',
  PlantStatus.thirsty: 'thirsty',
  PlantStatus.wilting: 'wilting',
  PlantStatus.blooming: 'blooming',
};

const _$GrowthStageEnumMap = {
  GrowthStage.seedling: 'seedling',
  GrowthStage.growing: 'growing',
  GrowthStage.mature: 'mature',
  GrowthStage.flowering: 'flowering',
};

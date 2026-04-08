// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantSpecies _$PlantSpeciesFromJson(Map<String, dynamic> json) =>
    _PlantSpecies(
      id: json['id'] as String,
      name: json['name'] as String,
      category: $enumDecode(_$PlantCategoryEnumMap, json['category']),
      waterFrequencyDays: (json['waterFrequencyDays'] as num).toInt(),
      fertilizerFrequencyDays: (json['fertilizerFrequencyDays'] as num).toInt(),
      sunlightNeed: $enumDecode(_$SunlightNeedEnumMap, json['sunlightNeed']),
      winterCare: json['winterCare'] as String,
      summerCare: json['summerCare'] as String,
      description: json['description'] as String,
      assetPrefix: json['assetPrefix'] as String,
    );

Map<String, dynamic> _$PlantSpeciesToJson(_PlantSpecies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$PlantCategoryEnumMap[instance.category]!,
      'waterFrequencyDays': instance.waterFrequencyDays,
      'fertilizerFrequencyDays': instance.fertilizerFrequencyDays,
      'sunlightNeed': _$SunlightNeedEnumMap[instance.sunlightNeed]!,
      'winterCare': instance.winterCare,
      'summerCare': instance.summerCare,
      'description': instance.description,
      'assetPrefix': instance.assetPrefix,
    };

const _$PlantCategoryEnumMap = {
  PlantCategory.succulent: 'succulent',
  PlantCategory.cactus: 'cactus',
};

const _$SunlightNeedEnumMap = {
  SunlightNeed.low: 'low',
  SunlightNeed.medium: 'medium',
  SunlightNeed.high: 'high',
};

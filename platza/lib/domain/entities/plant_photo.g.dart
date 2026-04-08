// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlantPhoto _$PlantPhotoFromJson(Map<String, dynamic> json) => _PlantPhoto(
      id: json['id'] as String,
      plantId: json['plantId'] as String,
      filePath: json['filePath'] as String,
      caption: json['caption'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlantPhotoToJson(_PlantPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plantId': instance.plantId,
      'filePath': instance.filePath,
      'caption': instance.caption,
      'createdAt': instance.createdAt.toIso8601String(),
    };

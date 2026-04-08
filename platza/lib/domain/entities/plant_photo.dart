import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_photo.freezed.dart';
part 'plant_photo.g.dart';

/// 植物の写真記録データ
@freezed
abstract class PlantPhoto with _$PlantPhoto {
  const factory PlantPhoto({
    required String id,
    required String plantId,
    required String filePath,
    String? caption,
    required DateTime createdAt,
  }) = _PlantPhoto;

  factory PlantPhoto.fromJson(Map<String, dynamic> json) =>
      _$PlantPhotoFromJson(json);
}

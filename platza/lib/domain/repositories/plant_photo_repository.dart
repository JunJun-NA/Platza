import 'package:platza/domain/entities/plant_photo.dart';

/// 植物写真リポジトリのインターフェース
abstract class PlantPhotoRepository {
  Future<List<PlantPhoto>> getPhotosForPlant(String plantId);
  Future<void> addPhoto(PlantPhoto photo);
  Future<void> deletePhoto(String id);
  Stream<List<PlantPhoto>> watchPhotosForPlant(String plantId);
}

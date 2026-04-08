import 'package:platza/domain/entities/plant.dart';

/// 植物リポジトリのインターフェース
abstract class PlantRepository {
  Future<List<Plant>> getAllPlants();
  Future<Plant?> getPlantById(String id);
  Future<void> addPlant(Plant plant);
  Future<void> updatePlant(Plant plant);
  Future<void> deletePlant(String id);
  Stream<List<Plant>> watchAllPlants();
}

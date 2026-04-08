import 'package:drift/drift.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/repositories/plant_repository.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/database/enum_converters.dart';

class DriftPlantRepository implements PlantRepository {
  DriftPlantRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<Plant>> getAllPlants() async {
    final rows = await _db.select(_db.plants).get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<Plant?> getPlantById(String id) async {
    final row = await (_db.select(_db.plants)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  @override
  Future<void> addPlant(Plant plant) async {
    await _db.into(_db.plants).insert(_toCompanion(plant));
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    await (_db.update(_db.plants)..where((t) => t.id.equals(plant.id)))
        .write(_toCompanion(plant));
  }

  @override
  Future<void> deletePlant(String id) async {
    await (_db.delete(_db.plants)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<Plant>> watchAllPlants() {
    return _db.select(_db.plants).watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  Plant _toDomain(PlantRow row) {
    return Plant(
      id: row.id,
      nickname: row.nickname,
      speciesId: row.speciesId,
      location: plantLocationFromString(row.location),
      status: plantStatusFromString(row.status),
      growthStage: growthStageFromString(row.growthStage),
      lastWatered: row.lastWatered,
      lastFertilized: row.lastFertilized,
      lastRepotted: row.lastRepotted,
      createdAt: row.createdAt,
      streakDays: row.streakDays,
    );
  }

  PlantsCompanion _toCompanion(Plant plant) {
    return PlantsCompanion(
      id: Value(plant.id),
      nickname: Value(plant.nickname),
      speciesId: Value(plant.speciesId),
      location: Value(plantLocationToString(plant.location)),
      status: Value(plantStatusToString(plant.status)),
      growthStage: Value(growthStageToString(plant.growthStage)),
      lastWatered: Value(plant.lastWatered),
      lastFertilized: Value(plant.lastFertilized),
      lastRepotted: Value(plant.lastRepotted),
      createdAt: Value(plant.createdAt),
      streakDays: Value(plant.streakDays),
    );
  }
}

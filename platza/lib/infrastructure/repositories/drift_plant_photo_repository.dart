import 'package:drift/drift.dart';
import 'package:platza/domain/entities/plant_photo.dart';
import 'package:platza/domain/repositories/plant_photo_repository.dart';
import 'package:platza/infrastructure/database/app_database.dart';

class DriftPlantPhotoRepository implements PlantPhotoRepository {
  DriftPlantPhotoRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<PlantPhoto>> getPhotosForPlant(String plantId) async {
    final rows = await (_db.select(_db.plantPhotos)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> addPhoto(PlantPhoto photo) async {
    await _db.into(_db.plantPhotos).insert(_toCompanion(photo));
  }

  @override
  Future<void> deletePhoto(String id) async {
    await (_db.delete(_db.plantPhotos)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<PlantPhoto>> watchPhotosForPlant(String plantId) {
    return (_db.select(_db.plantPhotos)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  PlantPhoto _toDomain(PlantPhotoRow row) {
    return PlantPhoto(
      id: row.id,
      plantId: row.plantId,
      filePath: row.filePath,
      caption: row.caption,
      createdAt: row.createdAt,
    );
  }

  PlantPhotosCompanion _toCompanion(PlantPhoto photo) {
    return PlantPhotosCompanion(
      id: Value(photo.id),
      plantId: Value(photo.plantId),
      filePath: Value(photo.filePath),
      caption: Value(photo.caption),
      createdAt: Value(photo.createdAt),
    );
  }
}

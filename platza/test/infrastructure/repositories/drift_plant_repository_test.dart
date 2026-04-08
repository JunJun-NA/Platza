import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_plant_repository.dart';

void main() {
  late AppDatabase db;
  late DriftPlantRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftPlantRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  Plant _createPlant({
    String id = 'plant-1',
    String nickname = 'テスト植物',
    String speciesId = 'echeveria',
    PlantLocation location = PlantLocation.indoor,
  }) {
    return Plant(
      id: id,
      nickname: nickname,
      speciesId: speciesId,
      location: location,
      createdAt: DateTime(2024, 1, 1),
    );
  }

  group('DriftPlantRepository', () {
    test('addPlant and getPlantById', () async {
      final plant = _createPlant();
      await repository.addPlant(plant);

      final retrieved = await repository.getPlantById('plant-1');
      expect(retrieved, isNotNull);
      expect(retrieved!.id, 'plant-1');
      expect(retrieved.nickname, 'テスト植物');
      expect(retrieved.speciesId, 'echeveria');
      expect(retrieved.location, PlantLocation.indoor);
      expect(retrieved.status, PlantStatus.happy);
      expect(retrieved.growthStage, GrowthStage.seedling);
      expect(retrieved.streakDays, 0);
    });

    test('getPlantById returns null for non-existent id', () async {
      final result = await repository.getPlantById('nonexistent');
      expect(result, isNull);
    });

    test('getAllPlants returns empty list initially', () async {
      final plants = await repository.getAllPlants();
      expect(plants, isEmpty);
    });

    test('getAllPlants returns all added plants', () async {
      await repository.addPlant(_createPlant(id: 'plant-1'));
      await repository.addPlant(
        _createPlant(id: 'plant-2', nickname: '植物2'),
      );
      await repository.addPlant(
        _createPlant(id: 'plant-3', nickname: '植物3'),
      );

      final plants = await repository.getAllPlants();
      expect(plants.length, 3);
    });

    test('updatePlant modifies existing plant', () async {
      final plant = _createPlant();
      await repository.addPlant(plant);

      final updated = plant.copyWith(
        nickname: '更新された植物',
        status: PlantStatus.blooming,
        growthStage: GrowthStage.mature,
        streakDays: 10,
      );
      await repository.updatePlant(updated);

      final retrieved = await repository.getPlantById('plant-1');
      expect(retrieved!.nickname, '更新された植物');
      expect(retrieved.status, PlantStatus.blooming);
      expect(retrieved.growthStage, GrowthStage.mature);
      expect(retrieved.streakDays, 10);
    });

    test('deletePlant removes plant', () async {
      await repository.addPlant(_createPlant());
      await repository.deletePlant('plant-1');

      final result = await repository.getPlantById('plant-1');
      expect(result, isNull);
    });

    test('deletePlant does not affect other plants', () async {
      await repository.addPlant(_createPlant(id: 'plant-1'));
      await repository.addPlant(_createPlant(id: 'plant-2'));
      await repository.deletePlant('plant-1');

      final plants = await repository.getAllPlants();
      expect(plants.length, 1);
      expect(plants.first.id, 'plant-2');
    });

    test('watchAllPlants emits updates', () async {
      final stream = repository.watchAllPlants();

      // Initial empty state
      final first = await stream.first;
      expect(first, isEmpty);

      // Add a plant and check next emission
      await repository.addPlant(_createPlant());
      final updated = await stream.first;
      expect(updated.length, 1);
      expect(updated.first.id, 'plant-1');
    });

    test('stores and retrieves nullable DateTime fields', () async {
      final now = DateTime(2024, 6, 15, 10, 30);
      final plant = Plant(
        id: 'plant-dates',
        nickname: 'Date植物',
        speciesId: 'sedum',
        location: PlantLocation.window,
        createdAt: now,
        lastWatered: now,
        lastFertilized: now,
        lastRepotted: now,
      );
      await repository.addPlant(plant);

      final retrieved = await repository.getPlantById('plant-dates');
      expect(retrieved!.lastWatered, now);
      expect(retrieved.lastFertilized, now);
      expect(retrieved.lastRepotted, now);
    });
  });
}

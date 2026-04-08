import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/entities/plant_photo.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_plant_photo_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_repository.dart';

void main() {
  late AppDatabase db;
  late DriftPlantPhotoRepository photoRepository;
  late DriftPlantRepository plantRepository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    photoRepository = DriftPlantPhotoRepository(db);
    plantRepository = DriftPlantRepository(db);

    // Insert a plant for foreign key constraints
    await plantRepository.addPlant(Plant(
      id: 'plant-1',
      nickname: 'テスト植物',
      speciesId: 'echeveria',
      location: PlantLocation.indoor,
      createdAt: DateTime(2024, 1, 1),
    ));
  });

  tearDown(() async {
    await db.close();
  });

  group('DriftPlantPhotoRepository', () {
    test('addPhoto and getPhotosForPlant', () async {
      final photo = PlantPhoto(
        id: 'photo-1',
        plantId: 'plant-1',
        filePath: '/photos/test.jpg',
        createdAt: DateTime(2024, 6, 15, 10, 0),
      );
      await photoRepository.addPhoto(photo);

      final photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.length, 1);
      expect(photos.first.id, 'photo-1');
      expect(photos.first.filePath, '/photos/test.jpg');
    });

    test('getPhotosForPlant returns empty for unknown plant', () async {
      final photos = await photoRepository.getPhotosForPlant('nonexistent');
      expect(photos, isEmpty);
    });

    test('getPhotosForPlant returns photos ordered by createdAt descending',
        () async {
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-old',
        plantId: 'plant-1',
        filePath: '/photos/old.jpg',
        createdAt: DateTime(2024, 6, 1),
      ));
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-new',
        plantId: 'plant-1',
        filePath: '/photos/new.jpg',
        createdAt: DateTime(2024, 6, 15),
      ));
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-mid',
        plantId: 'plant-1',
        filePath: '/photos/mid.jpg',
        createdAt: DateTime(2024, 6, 10),
      ));

      final photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.length, 3);
      expect(photos[0].id, 'photo-new');
      expect(photos[1].id, 'photo-mid');
      expect(photos[2].id, 'photo-old');
    });

    test('addPhoto stores caption', () async {
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-caption',
        plantId: 'plant-1',
        filePath: '/photos/caption.jpg',
        caption: '花が咲いた！',
        createdAt: DateTime(2024, 6, 15),
      ));

      final photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.first.caption, '花が咲いた！');
    });

    test('addPhoto stores null caption', () async {
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-no-caption',
        plantId: 'plant-1',
        filePath: '/photos/no-caption.jpg',
        createdAt: DateTime(2024, 6, 15),
      ));

      final photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.first.caption, isNull);
    });

    test('deletePhoto removes the photo', () async {
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-delete',
        plantId: 'plant-1',
        filePath: '/photos/delete.jpg',
        createdAt: DateTime(2024, 6, 15),
      ));

      var photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.length, 1);

      await photoRepository.deletePhoto('photo-delete');

      photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos, isEmpty);
    });

    test('deletePhoto does not affect other photos', () async {
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-keep',
        plantId: 'plant-1',
        filePath: '/photos/keep.jpg',
        createdAt: DateTime(2024, 6, 15),
      ));
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-remove',
        plantId: 'plant-1',
        filePath: '/photos/remove.jpg',
        createdAt: DateTime(2024, 6, 16),
      ));

      await photoRepository.deletePhoto('photo-remove');

      final photos = await photoRepository.getPhotosForPlant('plant-1');
      expect(photos.length, 1);
      expect(photos.first.id, 'photo-keep');
    });

    test('watchPhotosForPlant emits updates', () async {
      final stream = photoRepository.watchPhotosForPlant('plant-1');

      // First emission: empty
      final firstEmission = await stream.first;
      expect(firstEmission, isEmpty);

      // Add a photo
      await photoRepository.addPhoto(PlantPhoto(
        id: 'photo-watch',
        plantId: 'plant-1',
        filePath: '/photos/watch.jpg',
        createdAt: DateTime(2024, 6, 15),
      ));

      // Next emission should contain the photo
      final secondEmission =
          await photoRepository.watchPhotosForPlant('plant-1').first;
      expect(secondEmission.length, 1);
      expect(secondEmission.first.id, 'photo-watch');
    });
  });
}

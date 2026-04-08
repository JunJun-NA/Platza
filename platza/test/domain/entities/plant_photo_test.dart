import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant_photo.dart';

void main() {
  group('PlantPhoto Entity', () {
    test('creates with required fields', () {
      final now = DateTime(2024, 6, 15, 10, 30);
      final photo = PlantPhoto(
        id: 'photo-1',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: now,
      );

      expect(photo.id, 'photo-1');
      expect(photo.plantId, 'plant-1');
      expect(photo.filePath, '/path/to/photo.jpg');
      expect(photo.caption, isNull);
      expect(photo.createdAt, now);
    });

    test('creates with all fields including caption', () {
      final now = DateTime(2024, 6, 15, 10, 30);
      final photo = PlantPhoto(
        id: 'photo-2',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        caption: '初めての花が咲いた！',
        createdAt: now,
      );

      expect(photo.id, 'photo-2');
      expect(photo.caption, '初めての花が咲いた！');
    });

    test('caption defaults to null', () {
      final photo = PlantPhoto(
        id: 'photo-3',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: DateTime.now(),
      );

      expect(photo.caption, isNull);
    });

    test('copyWith changes caption only', () {
      final photo = PlantPhoto(
        id: 'photo-4',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: DateTime(2024, 6, 15),
      );

      final updated = photo.copyWith(caption: '新しいキャプション');

      expect(updated.caption, '新しいキャプション');
      expect(updated.id, photo.id);
      expect(updated.plantId, photo.plantId);
      expect(updated.filePath, photo.filePath);
      expect(updated.createdAt, photo.createdAt);
    });

    test('equality works for identical data', () {
      final now = DateTime(2024, 6, 15);
      final photo1 = PlantPhoto(
        id: 'photo-5',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: now,
      );
      final photo2 = PlantPhoto(
        id: 'photo-5',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: now,
      );

      expect(photo1, equals(photo2));
    });

    test('inequality for different data', () {
      final now = DateTime(2024, 6, 15);
      final photo1 = PlantPhoto(
        id: 'photo-a',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: now,
      );
      final photo2 = PlantPhoto(
        id: 'photo-b',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        createdAt: now,
      );

      expect(photo1, isNot(equals(photo2)));
    });

    test('fromJson and toJson roundtrip', () {
      final now = DateTime(2024, 6, 15, 10, 30);
      final photo = PlantPhoto(
        id: 'photo-json',
        plantId: 'plant-1',
        filePath: '/path/to/photo.jpg',
        caption: 'テスト',
        createdAt: now,
      );

      final json = photo.toJson();
      final restored = PlantPhoto.fromJson(json);

      expect(restored, equals(photo));
    });
  });
}

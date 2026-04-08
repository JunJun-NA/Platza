import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('Plant Entity', () {
    group('default values', () {
      test('status defaults to happy', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.status, PlantStatus.happy);
      });

      test('growthStage defaults to seedling', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.growthStage, GrowthStage.seedling);
      });

      test('streakDays defaults to 0', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.streakDays, 0);
      });

      test('lastWatered defaults to null', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.lastWatered, isNull);
      });

      test('lastFertilized defaults to null', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.lastFertilized, isNull);
      });

      test('lastRepotted defaults to null', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        expect(plant.lastRepotted, isNull);
      });
    });

    group('needsWatering', () {
      test('returns true when never watered', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now(),
        );

        expect(plant.needsWatering(10), isTrue);
      });

      test('returns false when recently watered', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now(),
          lastWatered: DateTime.now(),
        );

        expect(plant.needsWatering(10), isFalse);
      });

      test('returns true when overdue', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          lastWatered: DateTime.now().subtract(const Duration(days: 15)),
        );

        expect(plant.needsWatering(10), isTrue);
      });

      test('returns true when exactly at frequency boundary', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          lastWatered: DateTime.now().subtract(const Duration(days: 10)),
        );

        expect(plant.needsWatering(10), isTrue);
      });

      test('returns false when one day before frequency', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
          lastWatered: DateTime.now().subtract(const Duration(days: 9)),
        );

        expect(plant.needsWatering(10), isFalse);
      });
    });

    group('needsFertilizing', () {
      test('returns true when never fertilized', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now(),
        );

        expect(plant.needsFertilizing(30), isTrue);
      });

      test('returns false when recently fertilized', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now(),
          lastFertilized: DateTime.now(),
        );

        expect(plant.needsFertilizing(30), isFalse);
      });

      test('returns true when overdue', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
          lastFertilized: DateTime.now().subtract(const Duration(days: 45)),
        );

        expect(plant.needsFertilizing(30), isTrue);
      });

      test('returns true when exactly at frequency boundary', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
          lastFertilized: DateTime.now().subtract(const Duration(days: 30)),
        );

        expect(plant.needsFertilizing(30), isTrue);
      });

      test('returns false when one day before frequency', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
          lastFertilized: DateTime.now().subtract(const Duration(days: 29)),
        );

        expect(plant.needsFertilizing(30), isFalse);
      });
    });

    group('copyWith for edit', () {
      test('copyWith changes nickname only', () {
        final plant = Plant(
          id: 'test-1',
          nickname: '元の名前',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        final updated = plant.copyWith(nickname: '新しい名前');

        expect(updated.nickname, '新しい名前');
        expect(updated.id, plant.id);
        expect(updated.speciesId, plant.speciesId);
        expect(updated.location, plant.location);
        expect(updated.createdAt, plant.createdAt);
      });

      test('copyWith changes location only', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        final updated = plant.copyWith(location: PlantLocation.outdoor);

        expect(updated.location, PlantLocation.outdoor);
        expect(updated.nickname, plant.nickname);
        expect(updated.speciesId, plant.speciesId);
      });

      test('copyWith changes nickname and location together', () {
        final plant = Plant(
          id: 'test-1',
          nickname: '元の名前',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        final updated = plant.copyWith(
          nickname: '新しい名前',
          location: PlantLocation.window,
        );

        expect(updated.nickname, '新しい名前');
        expect(updated.location, PlantLocation.window);
        // species and other fields unchanged
        expect(updated.speciesId, 'echeveria');
        expect(updated.id, 'test-1');
        expect(updated.status, PlantStatus.happy);
      });

      test('copyWith does not change speciesId', () {
        final plant = Plant(
          id: 'test-1',
          nickname: 'テスト植物',
          speciesId: 'echeveria',
          location: PlantLocation.indoor,
          createdAt: DateTime(2024, 1, 1),
        );

        final updated = plant.copyWith(nickname: '別の名前');

        expect(updated.speciesId, 'echeveria');
      });
    });

    group('creation with all fields', () {
      test('creates plant with all fields specified', () {
        final now = DateTime(2024, 6, 1);
        final plant = Plant(
          id: 'plant-full',
          nickname: 'フル植物',
          speciesId: 'aloe',
          location: PlantLocation.outdoor,
          status: PlantStatus.blooming,
          growthStage: GrowthStage.flowering,
          lastWatered: now,
          lastFertilized: now,
          lastRepotted: now,
          createdAt: now,
          streakDays: 42,
        );

        expect(plant.id, 'plant-full');
        expect(plant.nickname, 'フル植物');
        expect(plant.speciesId, 'aloe');
        expect(plant.location, PlantLocation.outdoor);
        expect(plant.status, PlantStatus.blooming);
        expect(plant.growthStage, GrowthStage.flowering);
        expect(plant.lastWatered, now);
        expect(plant.lastFertilized, now);
        expect(plant.lastRepotted, now);
        expect(plant.createdAt, now);
        expect(plant.streakDays, 42);
      });
    });
  });
}

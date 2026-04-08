import 'package:flutter_test/flutter_test.dart';
import 'package:platza/application/services/care_schedule_utils.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('calculateNextDueDate', () {
    final createdAt = DateTime(2024, 1, 1);

    late Plant plantNeverCared;
    late Plant plantWithCareHistory;

    setUp(() {
      plantNeverCared = Plant(
        id: 'plant-1',
        nickname: 'テスト植物',
        speciesId: 'echeveria',
        location: PlantLocation.indoor,
        createdAt: createdAt,
      );

      plantWithCareHistory = Plant(
        id: 'plant-1',
        nickname: 'テスト植物',
        speciesId: 'echeveria',
        location: PlantLocation.indoor,
        createdAt: createdAt,
        lastWatered: DateTime(2024, 3, 10),
        lastFertilized: DateTime(2024, 2, 15),
        lastRepotted: DateTime(2024, 1, 20),
      );
    });

    test('water: uses lastWatered + interval when lastWatered exists', () {
      final result = calculateNextDueDate(
        careType: CareType.water,
        plant: plantWithCareHistory,
        intervalDays: 7,
      );
      // 2024-03-10 + 7 days = 2024-03-17
      expect(result, DateTime(2024, 3, 17));
    });

    test('water: uses createdAt + interval when never watered', () {
      final result = calculateNextDueDate(
        careType: CareType.water,
        plant: plantNeverCared,
        intervalDays: 10,
      );
      // 2024-01-01 + 10 days = 2024-01-11
      expect(result, DateTime(2024, 1, 11));
    });

    test('fertilize: uses lastFertilized + interval when lastFertilized exists',
        () {
      final result = calculateNextDueDate(
        careType: CareType.fertilize,
        plant: plantWithCareHistory,
        intervalDays: 30,
      );
      // 2024-02-15 + 30 days = 2024-03-16
      expect(result, DateTime(2024, 3, 16));
    });

    test('fertilize: uses createdAt + interval when never fertilized', () {
      final result = calculateNextDueDate(
        careType: CareType.fertilize,
        plant: plantNeverCared,
        intervalDays: 45,
      );
      // 2024-01-01 + 45 days = 2024-02-15
      expect(result, DateTime(2024, 2, 15));
    });

    test('repot: uses lastRepotted + interval when lastRepotted exists', () {
      final result = calculateNextDueDate(
        careType: CareType.repot,
        plant: plantWithCareHistory,
        intervalDays: 180,
      );
      // 2024-01-20 + 180 days = 2024-07-18
      expect(result, DateTime(2024, 7, 18));
    });

    test('sunlight: always uses createdAt since no lastCareDate', () {
      final result = calculateNextDueDate(
        careType: CareType.sunlight,
        plant: plantWithCareHistory,
        intervalDays: 14,
      );
      // 2024-01-01 + 14 days = 2024-01-15
      expect(result, DateTime(2024, 1, 15));
    });

    test('interval of 1 day adds exactly 1 day', () {
      final result = calculateNextDueDate(
        careType: CareType.water,
        plant: plantWithCareHistory,
        intervalDays: 1,
      );
      // 2024-03-10 + 1 day = 2024-03-11
      expect(result, DateTime(2024, 3, 11));
    });

    test('large interval works correctly', () {
      final result = calculateNextDueDate(
        careType: CareType.water,
        plant: plantWithCareHistory,
        intervalDays: 60,
      );
      // 2024-03-10 + 60 days = 2024-05-09
      expect(result, DateTime(2024, 5, 9));
    });
  });

  group('CareSchedule interval update preserves other fields', () {
    test('updating intervalDays via copyWith preserves all other fields', () {
      final original = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: DateTime(2024, 7, 1),
        isEnabled: true,
      );

      final updated = original.copyWith(
        intervalDays: 5,
        nextDueDate: DateTime(2024, 6, 25),
      );

      expect(updated.id, original.id);
      expect(updated.plantId, original.plantId);
      expect(updated.careType, original.careType);
      expect(updated.isEnabled, original.isEnabled);
      expect(updated.intervalDays, 5);
      expect(updated.nextDueDate, DateTime(2024, 6, 25));
    });

    test('updating intervalDays does not change isEnabled', () {
      final original = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        intervalDays: 30,
        nextDueDate: DateTime(2024, 8, 1),
        isEnabled: false,
      );

      final updated = original.copyWith(intervalDays: 14);

      expect(updated.isEnabled, isFalse);
      expect(updated.intervalDays, 14);
      expect(updated.id, original.id);
      expect(updated.plantId, original.plantId);
      expect(updated.careType, original.careType);
      expect(updated.nextDueDate, original.nextDueDate);
    });

    test('updating only nextDueDate preserves intervalDays', () {
      final original = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 7,
        nextDueDate: DateTime(2024, 7, 1),
      );

      final updated = original.copyWith(
        nextDueDate: DateTime(2024, 7, 8),
      );

      expect(updated.intervalDays, 7);
      expect(updated.nextDueDate, DateTime(2024, 7, 8));
    });
  });
}

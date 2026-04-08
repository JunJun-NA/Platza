import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/care_schedule.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('CareSchedule Entity', () {
    test('creates with all required fields', () {
      final dueDate = DateTime(2024, 7, 1);
      final schedule = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: dueDate,
      );

      expect(schedule.id, 'schedule-1');
      expect(schedule.plantId, 'plant-1');
      expect(schedule.careType, CareType.water);
      expect(schedule.intervalDays, 10);
      expect(schedule.nextDueDate, dueDate);
    });

    test('isEnabled defaults to true', () {
      final schedule = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        intervalDays: 30,
        nextDueDate: DateTime(2024, 7, 1),
      );

      expect(schedule.isEnabled, isTrue);
    });

    test('can be created with isEnabled=false', () {
      final schedule = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.repot,
        intervalDays: 180,
        nextDueDate: DateTime(2024, 12, 1),
        isEnabled: false,
      );

      expect(schedule.isEnabled, isFalse);
    });

    test('supports all CareType values', () {
      for (final type in CareType.values) {
        final schedule = CareSchedule(
          id: 'schedule-${type.name}',
          plantId: 'plant-1',
          careType: type,
          intervalDays: 7,
          nextDueDate: DateTime(2024, 7, 1),
        );

        expect(schedule.careType, type);
      }
    });
  });
}

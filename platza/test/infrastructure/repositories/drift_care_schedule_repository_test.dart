import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/care_schedule.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_care_schedule_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_repository.dart';

void main() {
  late AppDatabase db;
  late DriftCareScheduleRepository scheduleRepository;
  late DriftPlantRepository plantRepository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    scheduleRepository = DriftCareScheduleRepository(db);
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

  group('DriftCareScheduleRepository', () {
    test('addSchedule and getSchedulesForPlant', () async {
      final schedule = CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: DateTime(2024, 7, 1),
      );
      await scheduleRepository.addSchedule(schedule);

      final schedules =
          await scheduleRepository.getSchedulesForPlant('plant-1');
      expect(schedules.length, 1);
      expect(schedules.first.id, 'schedule-1');
      expect(schedules.first.careType, CareType.water);
      expect(schedules.first.intervalDays, 10);
      expect(schedules.first.isEnabled, isTrue);
    });

    test('getSchedulesForPlant returns empty for unknown plant', () async {
      final schedules =
          await scheduleRepository.getSchedulesForPlant('nonexistent');
      expect(schedules, isEmpty);
    });

    test('getDueSchedules returns only due and enabled schedules', () async {
      final pastDue = DateTime.now().subtract(const Duration(days: 1));
      final futureDue = DateTime.now().add(const Duration(days: 10));

      // Due and enabled
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'due-enabled',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: pastDue,
        isEnabled: true,
      ));

      // Due but disabled
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'due-disabled',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        intervalDays: 30,
        nextDueDate: pastDue,
        isEnabled: false,
      ));

      // Not due yet
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'not-due',
        plantId: 'plant-1',
        careType: CareType.repot,
        intervalDays: 180,
        nextDueDate: futureDue,
        isEnabled: true,
      ));

      final dueSchedules = await scheduleRepository.getDueSchedules();
      expect(dueSchedules.length, 1);
      expect(dueSchedules.first.id, 'due-enabled');
    });

    test('getDueSchedules includes schedules due today', () async {
      final now = DateTime.now();

      await scheduleRepository.addSchedule(CareSchedule(
        id: 'due-today',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: now,
        isEnabled: true,
      ));

      final dueSchedules = await scheduleRepository.getDueSchedules();
      expect(dueSchedules.length, 1);
    });

    test('updateSchedule modifies existing schedule', () async {
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: DateTime(2024, 7, 1),
      ));

      final newDueDate = DateTime(2024, 7, 11);
      await scheduleRepository.updateSchedule(CareSchedule(
        id: 'schedule-1',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: newDueDate,
        isEnabled: false,
      ));

      final schedules =
          await scheduleRepository.getSchedulesForPlant('plant-1');
      expect(schedules.length, 1);
      expect(schedules.first.nextDueDate, newDueDate);
      expect(schedules.first.isEnabled, isFalse);
    });

    test('multiple schedules for same plant', () async {
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'schedule-water',
        plantId: 'plant-1',
        careType: CareType.water,
        intervalDays: 10,
        nextDueDate: DateTime(2024, 7, 1),
      ));
      await scheduleRepository.addSchedule(CareSchedule(
        id: 'schedule-fertilize',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        intervalDays: 30,
        nextDueDate: DateTime(2024, 7, 15),
      ));

      final schedules =
          await scheduleRepository.getSchedulesForPlant('plant-1');
      expect(schedules.length, 2);
    });
  });
}

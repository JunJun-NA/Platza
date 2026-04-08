import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_care_log_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_repository.dart';

void main() {
  late AppDatabase db;
  late DriftCareLogRepository logRepository;
  late DriftPlantRepository plantRepository;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    logRepository = DriftCareLogRepository(db);
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

  group('DriftCareLogRepository', () {
    test('addLog and getLogsForPlant', () async {
      final log = CareLog(
        id: 'log-1',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 15, 10, 0),
      );
      await logRepository.addLog(log);

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.id, 'log-1');
      expect(logs.first.careType, CareType.water);
    });

    test('getLogsForPlant returns empty for unknown plant', () async {
      final logs = await logRepository.getLogsForPlant('nonexistent');
      expect(logs, isEmpty);
    });

    test('getLogsForPlant returns logs ordered by performedAt descending',
        () async {
      await logRepository.addLog(CareLog(
        id: 'log-old',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 1),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-new',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 15),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-mid',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2024, 6, 10),
      ));

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.length, 3);
      expect(logs[0].id, 'log-new');
      expect(logs[1].id, 'log-mid');
      expect(logs[2].id, 'log-old');
    });

    test('getLogsByDateRange returns logs within range', () async {
      await logRepository.addLog(CareLog(
        id: 'log-before',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 5, 1),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-in-range',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 15),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-after',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 7, 15),
      ));

      final logs = await logRepository.getLogsByDateRange(
        DateTime(2024, 6, 1),
        DateTime(2024, 6, 30),
      );
      expect(logs.length, 1);
      expect(logs.first.id, 'log-in-range');
    });

    test('getLogsByDateRange includes boundary dates', () async {
      final start = DateTime(2024, 6, 1);
      final end = DateTime(2024, 6, 30);

      await logRepository.addLog(CareLog(
        id: 'log-start',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: start,
      ));
      await logRepository.addLog(CareLog(
        id: 'log-end',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: end,
      ));

      final logs = await logRepository.getLogsByDateRange(start, end);
      expect(logs.length, 2);
    });

    test('getLogsByType filters by plant and care type', () async {
      await logRepository.addLog(CareLog(
        id: 'log-water',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 1),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-fertilize',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2024, 6, 5),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-water-2',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 10),
      ));

      final waterLogs =
          await logRepository.getLogsByType('plant-1', CareType.water);
      expect(waterLogs.length, 2);
      for (final log in waterLogs) {
        expect(log.careType, CareType.water);
      }

      final fertilizeLogs =
          await logRepository.getLogsByType('plant-1', CareType.fertilize);
      expect(fertilizeLogs.length, 1);
      expect(fertilizeLogs.first.id, 'log-fertilize');
    });

    test('updateLog modifies existing log', () async {
      final log = CareLog(
        id: 'log-update',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 15, 10, 0),
        note: '元のメモ',
      );
      await logRepository.addLog(log);

      final updatedLog = log.copyWith(
        performedAt: DateTime(2024, 6, 14, 9, 0),
        note: '修正後のメモ',
      );
      await logRepository.updateLog(updatedLog);

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.performedAt, DateTime(2024, 6, 14, 9, 0));
      expect(logs.first.note, '修正後のメモ');
      expect(logs.first.careType, CareType.water);
    });

    test('updateLog can set note to null', () async {
      final log = CareLog(
        id: 'log-null-note',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2024, 6, 15),
        note: '削除するメモ',
      );
      await logRepository.addLog(log);

      await logRepository.updateLog(log.copyWith(note: null));

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.first.note, isNull);
    });

    test('deleteLog removes log and others remain', () async {
      await logRepository.addLog(CareLog(
        id: 'log-keep',
        plantId: 'plant-1',
        careType: CareType.water,
        performedAt: DateTime(2024, 6, 1),
      ));
      await logRepository.addLog(CareLog(
        id: 'log-delete',
        plantId: 'plant-1',
        careType: CareType.fertilize,
        performedAt: DateTime(2024, 6, 5),
      ));

      await logRepository.deleteLog('log-delete');

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.length, 1);
      expect(logs.first.id, 'log-keep');
    });

    test('addLog stores note', () async {
      await logRepository.addLog(CareLog(
        id: 'log-with-note',
        plantId: 'plant-1',
        careType: CareType.repot,
        performedAt: DateTime(2024, 6, 15),
        note: '大きめの鉢に植え替え',
      ));

      final logs = await logRepository.getLogsForPlant('plant-1');
      expect(logs.first.note, '大きめの鉢に植え替え');
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:platza/application/services/statistics_utils.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('calculateWeeklyCareCount', () {
    test('counts logs within the current week (Mon-Sun)', () {
      final now = DateTime.now();
      final monday = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: now.weekday - 1));

      final logs = [
        _makeLog(performedAt: monday),
        _makeLog(performedAt: monday.add(const Duration(hours: 12))),
        _makeLog(performedAt: monday.add(const Duration(days: 3))),
        // Outside this week
        _makeLog(performedAt: monday.subtract(const Duration(days: 1))),
        _makeLog(performedAt: monday.add(const Duration(days: 7))),
      ];

      expect(StatisticsUtils.calculateWeeklyCareCount(logs), 3);
    });

    test('returns 0 for empty list', () {
      expect(StatisticsUtils.calculateWeeklyCareCount([]), 0);
    });

    test('returns 0 when no logs are in this week', () {
      final logs = [
        _makeLog(performedAt: DateTime(2020, 1, 1)),
        _makeLog(performedAt: DateTime(2020, 6, 15)),
      ];
      expect(StatisticsUtils.calculateWeeklyCareCount(logs), 0);
    });
  });

  group('calculateMonthlyCareCount', () {
    test('counts logs within the current month', () {
      final now = DateTime.now();
      final firstOfMonth = DateTime(now.year, now.month);

      final logs = [
        _makeLog(performedAt: firstOfMonth),
        _makeLog(performedAt: firstOfMonth.add(const Duration(days: 5))),
        // Outside this month
        _makeLog(
            performedAt: firstOfMonth.subtract(const Duration(days: 1))),
      ];

      expect(StatisticsUtils.calculateMonthlyCareCount(logs), 2);
    });

    test('returns 0 for empty list', () {
      expect(StatisticsUtils.calculateMonthlyCareCount([]), 0);
    });

    test('returns 0 when no logs are in this month', () {
      final logs = [
        _makeLog(performedAt: DateTime(2020, 1, 1)),
      ];
      expect(StatisticsUtils.calculateMonthlyCareCount(logs), 0);
    });
  });

  group('calculateCareTypeBreakdown', () {
    test('correctly counts each care type', () {
      final logs = [
        _makeLog(careType: CareType.water),
        _makeLog(careType: CareType.water),
        _makeLog(careType: CareType.water),
        _makeLog(careType: CareType.fertilize),
        _makeLog(careType: CareType.repot),
        _makeLog(careType: CareType.sunlight),
        _makeLog(careType: CareType.sunlight),
      ];

      final result = StatisticsUtils.calculateCareTypeBreakdown(logs);

      expect(result[CareType.water], 3);
      expect(result[CareType.fertilize], 1);
      expect(result[CareType.repot], 1);
      expect(result[CareType.sunlight], 2);
    });

    test('returns all zeros for empty list', () {
      final result = StatisticsUtils.calculateCareTypeBreakdown([]);

      for (final type in CareType.values) {
        expect(result[type], 0);
      }
    });

    test('includes all CareType keys even if no logs for that type', () {
      final logs = [
        _makeLog(careType: CareType.water),
      ];

      final result = StatisticsUtils.calculateCareTypeBreakdown(logs);

      expect(result.keys.length, CareType.values.length);
      expect(result[CareType.water], 1);
      expect(result[CareType.fertilize], 0);
      expect(result[CareType.repot], 0);
      expect(result[CareType.sunlight], 0);
    });

    test('single item', () {
      final logs = [
        _makeLog(careType: CareType.repot),
      ];

      final result = StatisticsUtils.calculateCareTypeBreakdown(logs);
      expect(result[CareType.repot], 1);
    });
  });

  group('calculateDailyActivity', () {
    test('returns correct daily counts for last 7 days', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final logs = [
        _makeLog(performedAt: today),
        _makeLog(performedAt: today),
        _makeLog(performedAt: today.subtract(const Duration(days: 1))),
        _makeLog(performedAt: today.subtract(const Duration(days: 3))),
        _makeLog(performedAt: today.subtract(const Duration(days: 3))),
        _makeLog(performedAt: today.subtract(const Duration(days: 3))),
        // Outside 7 days
        _makeLog(performedAt: today.subtract(const Duration(days: 7))),
      ];

      final result = StatisticsUtils.calculateDailyActivity(logs, 7);

      expect(result.length, 7);
      // index 0 = 6 days ago, ..., index 6 = today
      expect(result[6], 2); // today
      expect(result[5], 1); // 1 day ago
      expect(result[4], 0); // 2 days ago
      expect(result[3], 3); // 3 days ago
      expect(result[2], 0); // 4 days ago
      expect(result[1], 0); // 5 days ago
      expect(result[0], 0); // 6 days ago
    });

    test('returns all zeros for empty list', () {
      final result = StatisticsUtils.calculateDailyActivity([], 7);

      expect(result.length, 7);
      expect(result.every((c) => c == 0), isTrue);
    });

    test('handles single log today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final logs = [_makeLog(performedAt: today)];

      final result = StatisticsUtils.calculateDailyActivity(logs, 7);
      expect(result[6], 1);
      expect(result.sublist(0, 6).every((c) => c == 0), isTrue);
    });

    test('handles custom number of days', () {
      final result = StatisticsUtils.calculateDailyActivity([], 14);
      expect(result.length, 14);
    });

    test('logs with time component are mapped to correct day', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final logs = [
        _makeLog(
            performedAt: today.add(const Duration(hours: 23, minutes: 59))),
      ];

      final result = StatisticsUtils.calculateDailyActivity(logs, 7);
      expect(result[6], 1);
    });
  });

  group('calculateBestStreak', () {
    test('returns max streakDays across plants', () {
      final plants = [
        _makePlant(streakDays: 5),
        _makePlant(streakDays: 12),
        _makePlant(streakDays: 3),
      ];

      expect(StatisticsUtils.calculateBestStreak(plants), 12);
    });

    test('returns 0 for empty list', () {
      expect(StatisticsUtils.calculateBestStreak([]), 0);
    });

    test('returns correct value for single plant', () {
      final plants = [_makePlant(streakDays: 7)];
      expect(StatisticsUtils.calculateBestStreak(plants), 7);
    });

    test('returns 0 when all streaks are 0', () {
      final plants = [
        _makePlant(streakDays: 0),
        _makePlant(streakDays: 0),
      ];
      expect(StatisticsUtils.calculateBestStreak(plants), 0);
    });
  });
}

/// テスト用CareLogを生成するヘルパー
CareLog _makeLog({
  CareType careType = CareType.water,
  DateTime? performedAt,
  String plantId = 'plant-1',
}) {
  return CareLog(
    id: 'log-${DateTime.now().microsecondsSinceEpoch}',
    plantId: plantId,
    careType: careType,
    performedAt: performedAt ?? DateTime.now(),
  );
}

/// テスト用Plantを生成するヘルパー
Plant _makePlant({int streakDays = 0}) {
  return Plant(
    id: 'plant-${DateTime.now().microsecondsSinceEpoch}',
    nickname: 'テスト植物',
    speciesId: 'echeveria',
    location: PlantLocation.indoor,
    createdAt: DateTime(2024, 1, 1),
    streakDays: streakDays,
  );
}

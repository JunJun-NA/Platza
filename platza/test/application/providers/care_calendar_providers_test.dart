import 'package:flutter_test/flutter_test.dart';
import 'package:platza/application/providers/care_calendar_providers.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('buildCareCalendarData', () {
    test('ログと予定を日付ごとに集約する', () {
      final log1 = CareLog(
        id: 'l1',
        plantId: 'p1',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 10, 9, 0),
      );
      final log2 = CareLog(
        id: 'l2',
        plantId: 'p1',
        careType: CareType.fertilize,
        performedAt: DateTime(2026, 4, 10, 18, 0),
      );
      final schedule = CareSchedule(
        id: 's1',
        plantId: 'p1',
        careType: CareType.water,
        intervalDays: 7,
        nextDueDate: DateTime(2026, 4, 17),
      );

      final data = buildCareCalendarData(
        logs: [log1, log2],
        schedules: [schedule],
      );

      final apr10 = data.eventsForDay(DateTime(2026, 4, 10));
      expect(apr10, hasLength(2));
      expect(apr10.every((e) => e.isPerformed), isTrue);

      final apr17 = data.eventsForDay(DateTime(2026, 4, 17));
      expect(apr17, hasLength(1));
      expect(apr17.first.isPerformed, isFalse);
      expect(apr17.first.careType, CareType.water);
    });

    test('空のリストなら空のデータを返す', () {
      final data = buildCareCalendarData(logs: [], schedules: []);
      expect(data.isEmpty, isTrue);
      expect(data.eventsForDay(DateTime(2026, 4, 10)), isEmpty);
    });

    test('時刻が違っても同じ日のログは同じキーに入る', () {
      final log1 = CareLog(
        id: 'l1',
        plantId: 'p1',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 10, 0, 1),
      );
      final log2 = CareLog(
        id: 'l2',
        plantId: 'p1',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 10, 23, 59),
      );

      final data = buildCareCalendarData(logs: [log1, log2], schedules: []);

      expect(data.eventsForDay(DateTime(2026, 4, 10, 12, 0)), hasLength(2));
    });

    test('無効化されたスケジュールは除外する', () {
      final schedule = CareSchedule(
        id: 's1',
        plantId: 'p1',
        careType: CareType.fertilize,
        intervalDays: 30,
        nextDueDate: DateTime(2026, 5, 1),
        isEnabled: false,
      );

      final data = buildCareCalendarData(logs: [], schedules: [schedule]);

      expect(data.eventsForDay(DateTime(2026, 5, 1)), isEmpty);
    });

    test('該当日のないクエリに対しては空配列を返す', () {
      final log = CareLog(
        id: 'l1',
        plantId: 'p1',
        careType: CareType.water,
        performedAt: DateTime(2026, 4, 10),
      );

      final data = buildCareCalendarData(logs: [log], schedules: []);

      expect(data.eventsForDay(DateTime(2026, 4, 11)), isEmpty);
      expect(data.eventsForDay(DateTime(2026, 3, 10)), isEmpty);
    });
  });
}

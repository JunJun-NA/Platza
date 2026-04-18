import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/care_log_providers.dart';
import 'package:platza/application/providers/care_schedule_providers.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

/// カレンダー上で 1 日に紐づくイベント
class CareCalendarEvent {
  const CareCalendarEvent({
    required this.careType,
    required this.isPerformed,
    this.log,
    this.schedule,
  });

  /// 実施済みのログから作る
  factory CareCalendarEvent.performed(CareLog log) => CareCalendarEvent(
        careType: log.careType,
        isPerformed: true,
        log: log,
      );

  /// 予定日のスケジュールから作る
  factory CareCalendarEvent.scheduled(CareSchedule schedule) =>
      CareCalendarEvent(
        careType: schedule.careType,
        isPerformed: false,
        schedule: schedule,
      );

  final CareType careType;
  final bool isPerformed;
  final CareLog? log;
  final CareSchedule? schedule;
}

/// 植物ごとにカレンダー用イベントを日付キーで集約したデータ
class CareCalendarData {
  const CareCalendarData(this._eventsByDate);

  final Map<DateTime, List<CareCalendarEvent>> _eventsByDate;

  /// 指定日のイベントを返す（該当なしは空配列）
  List<CareCalendarEvent> eventsForDay(DateTime day) {
    return _eventsByDate[_normalize(day)] ?? const [];
  }

  /// table_calendar の eventLoader 用
  List<CareCalendarEvent> call(DateTime day) => eventsForDay(day);

  bool get isEmpty => _eventsByDate.isEmpty;
}

/// 0:00 に正規化
DateTime _normalize(DateTime date) =>
    DateTime(date.year, date.month, date.day);

/// 植物単位のカレンダーイベント集約Provider
final careCalendarDataProvider =
    Provider.family<AsyncValue<CareCalendarData>, String>((ref, plantId) {
  final logsAsync = ref.watch(careLogsForPlantProvider(plantId));
  final schedulesAsync = ref.watch(careSchedulesForPlantProvider(plantId));

  if (logsAsync.isLoading || schedulesAsync.isLoading) {
    return const AsyncValue.loading();
  }

  final error = logsAsync.error ?? schedulesAsync.error;
  if (error != null) {
    final stack = logsAsync.stackTrace ?? schedulesAsync.stackTrace ??
        StackTrace.current;
    return AsyncValue.error(error, stack);
  }

  final logs = logsAsync.value ?? const <CareLog>[];
  final schedules = schedulesAsync.value ?? const <CareSchedule>[];

  return AsyncValue.data(buildCareCalendarData(logs: logs, schedules: schedules));
});

/// 集約ロジック本体（テストしやすいよう純粋関数として公開）
CareCalendarData buildCareCalendarData({
  required List<CareLog> logs,
  required List<CareSchedule> schedules,
}) {
  final map = <DateTime, List<CareCalendarEvent>>{};

  for (final log in logs) {
    final key = _normalize(log.performedAt);
    map.putIfAbsent(key, () => []).add(CareCalendarEvent.performed(log));
  }

  for (final schedule in schedules) {
    if (!schedule.isEnabled) continue;
    final key = _normalize(schedule.nextDueDate);
    map.putIfAbsent(key, () => []).add(CareCalendarEvent.scheduled(schedule));
  }

  return CareCalendarData(map);
}

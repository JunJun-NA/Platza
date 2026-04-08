import 'package:platza/domain/entities/care_schedule.dart';

/// お世話スケジュールリポジトリのインターフェース
abstract class CareScheduleRepository {
  Future<List<CareSchedule>> getSchedulesForPlant(String plantId);
  Future<List<CareSchedule>> getDueSchedules();
  Future<void> addSchedule(CareSchedule schedule);
  Future<void> updateSchedule(CareSchedule schedule);
  Future<void> deleteSchedule(String id);
}

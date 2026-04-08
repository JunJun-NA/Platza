import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/enums/enums.dart';

/// お世話ログリポジトリのインターフェース
abstract class CareLogRepository {
  Future<List<CareLog>> getLogsForPlant(String plantId);
  Future<List<CareLog>> getLogsByDateRange(DateTime start, DateTime end);
  Future<List<CareLog>> getLogsByType(String plantId, CareType careType);
  Future<void> addLog(CareLog log);
  Future<void> updateLog(CareLog log);
  Future<void> deleteLog(String id);
  Stream<List<CareLog>> watchLogsForPlant(String plantId);
}

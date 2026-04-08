import 'package:drift/drift.dart';
import 'package:platza/domain/entities/care_log.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/domain/repositories/care_log_repository.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/database/enum_converters.dart';

class DriftCareLogRepository implements CareLogRepository {
  DriftCareLogRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<CareLog>> getLogsForPlant(String plantId) async {
    final rows = await (_db.select(_db.careLogs)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.desc(t.performedAt)]))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<List<CareLog>> getLogsByDateRange(
      DateTime start, DateTime end) async {
    final rows = await (_db.select(_db.careLogs)
          ..where((t) =>
              t.performedAt.isBiggerOrEqualValue(start) &
              t.performedAt.isSmallerOrEqualValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.performedAt)]))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<List<CareLog>> getLogsByType(
      String plantId, CareType careType) async {
    final rows = await (_db.select(_db.careLogs)
          ..where((t) =>
              t.plantId.equals(plantId) &
              t.careType.equals(careTypeToString(careType)))
          ..orderBy([(t) => OrderingTerm.desc(t.performedAt)]))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> addLog(CareLog log) async {
    await _db.into(_db.careLogs).insert(_toCompanion(log));
  }

  @override
  Future<void> deleteLog(String id) async {
    await (_db.delete(_db.careLogs)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<CareLog>> watchLogsForPlant(String plantId) {
    return (_db.select(_db.careLogs)
          ..where((t) => t.plantId.equals(plantId))
          ..orderBy([(t) => OrderingTerm.desc(t.performedAt)]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  CareLog _toDomain(CareLogRow row) {
    return CareLog(
      id: row.id,
      plantId: row.plantId,
      careType: careTypeFromString(row.careType),
      performedAt: row.performedAt,
      note: row.note,
    );
  }

  CareLogsCompanion _toCompanion(CareLog log) {
    return CareLogsCompanion(
      id: Value(log.id),
      plantId: Value(log.plantId),
      careType: Value(careTypeToString(log.careType)),
      performedAt: Value(log.performedAt),
      note: Value(log.note),
    );
  }
}

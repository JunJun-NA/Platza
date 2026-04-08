import 'package:drift/drift.dart';
import 'package:platza/domain/entities/care_schedule.dart';
import 'package:platza/domain/repositories/care_schedule_repository.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/database/enum_converters.dart';

class DriftCareScheduleRepository implements CareScheduleRepository {
  DriftCareScheduleRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<CareSchedule>> getSchedulesForPlant(String plantId) async {
    final rows = await (_db.select(_db.careSchedules)
          ..where((t) => t.plantId.equals(plantId)))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<List<CareSchedule>> getDueSchedules() async {
    final now = DateTime.now();
    final rows = await (_db.select(_db.careSchedules)
          ..where(
              (t) => t.isEnabled & t.nextDueDate.isSmallerOrEqualValue(now)))
        .get();
    return rows.map(_toDomain).toList();
  }

  @override
  Future<void> addSchedule(CareSchedule schedule) async {
    await _db.into(_db.careSchedules).insert(_toCompanion(schedule));
  }

  @override
  Future<void> updateSchedule(CareSchedule schedule) async {
    await (_db.update(_db.careSchedules)
          ..where((t) => t.id.equals(schedule.id)))
        .write(_toCompanion(schedule));
  }

  @override
  Future<void> deleteSchedule(String id) async {
    await (_db.delete(_db.careSchedules)..where((t) => t.id.equals(id))).go();
  }

  CareSchedule _toDomain(CareScheduleRow row) {
    return CareSchedule(
      id: row.id,
      plantId: row.plantId,
      careType: careTypeFromString(row.careType),
      intervalDays: row.intervalDays,
      nextDueDate: row.nextDueDate,
      isEnabled: row.isEnabled,
    );
  }

  CareSchedulesCompanion _toCompanion(CareSchedule schedule) {
    return CareSchedulesCompanion(
      id: Value(schedule.id),
      plantId: Value(schedule.plantId),
      careType: Value(careTypeToString(schedule.careType)),
      intervalDays: Value(schedule.intervalDays),
      nextDueDate: Value(schedule.nextDueDate),
      isEnabled: Value(schedule.isEnabled),
    );
  }
}

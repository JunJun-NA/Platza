import 'package:drift/drift.dart';
import 'package:platza/domain/entities/user_settings.dart';
import 'package:platza/domain/repositories/user_settings_repository.dart';
import 'package:platza/infrastructure/database/app_database.dart';

class DriftUserSettingsRepository implements UserSettingsRepository {
  DriftUserSettingsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<UserSettings> getSettings() async {
    final row = await (_db.select(_db.userSettingsTable)
          ..where((t) => t.id.equals(1)))
        .getSingle();
    return _toDomain(row);
  }

  @override
  Future<void> updateSettings(UserSettings settings) async {
    await (_db.update(_db.userSettingsTable)..where((t) => t.id.equals(1)))
        .write(UserSettingsTableCompanion(
      notificationEnabled: Value(settings.notificationEnabled),
      waterReminderHour: Value(settings.waterReminderHour),
      waterReminderMinute: Value(settings.waterReminderMinute),
      fertilizerReminderEnabled: Value(settings.fertilizerReminderEnabled),
      isDarkMode: Value(settings.isDarkMode),
    ));
  }

  @override
  Stream<UserSettings> watchSettings() {
    return (_db.select(_db.userSettingsTable)
          ..where((t) => t.id.equals(1)))
        .watchSingle()
        .map(_toDomain);
  }

  UserSettings _toDomain(UserSettingsRow row) {
    return UserSettings(
      notificationEnabled: row.notificationEnabled,
      waterReminderHour: row.waterReminderHour,
      waterReminderMinute: row.waterReminderMinute,
      fertilizerReminderEnabled: row.fertilizerReminderEnabled,
      isDarkMode: row.isDarkMode,
    );
  }
}

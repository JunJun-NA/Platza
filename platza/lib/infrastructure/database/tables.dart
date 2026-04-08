import 'package:drift/drift.dart';

/// 植物テーブル
@DataClassName('PlantRow')
class Plants extends Table {
  TextColumn get id => text()();
  TextColumn get nickname => text()();
  TextColumn get speciesId => text()();
  TextColumn get location => text()();
  TextColumn get status => text().withDefault(const Constant('happy'))();
  TextColumn get growthStage =>
      text().withDefault(const Constant('seedling'))();
  DateTimeColumn get lastWatered => dateTime().nullable()();
  DateTimeColumn get lastFertilized => dateTime().nullable()();
  DateTimeColumn get lastRepotted => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get streakDays => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// お世話ログテーブル
@DataClassName('CareLogRow')
class CareLogs extends Table {
  TextColumn get id => text()();
  TextColumn get plantId =>
      text().references(Plants, #id, onDelete: KeyAction.cascade)();
  TextColumn get careType => text()();
  DateTimeColumn get performedAt => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// お世話スケジュールテーブル
@DataClassName('CareScheduleRow')
class CareSchedules extends Table {
  TextColumn get id => text()();
  TextColumn get plantId =>
      text().references(Plants, #id, onDelete: KeyAction.cascade)();
  TextColumn get careType => text()();
  IntColumn get intervalDays => integer()();
  DateTimeColumn get nextDueDate => dateTime()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// 植物写真テーブル
@DataClassName('PlantPhotoRow')
class PlantPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get plantId =>
      text().references(Plants, #id, onDelete: KeyAction.cascade)();
  TextColumn get filePath => text()();
  TextColumn get caption => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// ユーザー設定テーブル（1行のみ）
@DataClassName('UserSettingsRow')
class UserSettingsTable extends Table {
  IntColumn get id =>
      integer().withDefault(const Constant(1))();
  BoolColumn get notificationEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get waterReminderHour =>
      integer().withDefault(const Constant(8))();
  IntColumn get waterReminderMinute =>
      integer().withDefault(const Constant(0))();
  BoolColumn get fertilizerReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get isDarkMode =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

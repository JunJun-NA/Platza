import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:platza/infrastructure/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Plants, CareLogs, CareSchedules, PlantPhotos, UserSettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // デフォルトのユーザー設定を挿入
          await into(userSettingsTable).insert(
            UserSettingsTableCompanion.insert(),
          );
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(plantPhotos);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'platza.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

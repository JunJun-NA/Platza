import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/domain/repositories/repositories.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_care_log_repository.dart';
import 'package:platza/infrastructure/repositories/drift_care_schedule_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_photo_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_repository.dart';
import 'package:platza/infrastructure/repositories/drift_user_settings_repository.dart';

/// データベースインスタンスのProvider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// 植物リポジトリのProvider
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  return DriftPlantRepository(ref.watch(databaseProvider));
});

/// お世話ログリポジトリのProvider
final careLogRepositoryProvider = Provider<CareLogRepository>((ref) {
  return DriftCareLogRepository(ref.watch(databaseProvider));
});

/// お世話スケジュールリポジトリのProvider
final careScheduleRepositoryProvider =
    Provider<CareScheduleRepository>((ref) {
  return DriftCareScheduleRepository(ref.watch(databaseProvider));
});

/// 植物写真リポジトリのProvider
final plantPhotoRepositoryProvider = Provider<PlantPhotoRepository>((ref) {
  return DriftPlantPhotoRepository(ref.watch(databaseProvider));
});

/// ユーザー設定リポジトリのProvider
final userSettingsRepositoryProvider =
    Provider<UserSettingsRepository>((ref) {
  return DriftUserSettingsRepository(ref.watch(databaseProvider));
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/auth_providers.dart';
import 'package:platza/application/providers/firebase_providers.dart';
import 'package:platza/domain/repositories/repositories.dart';
import 'package:platza/infrastructure/database/app_database.dart';
import 'package:platza/infrastructure/repositories/drift_care_schedule_repository.dart';
import 'package:platza/infrastructure/repositories/drift_plant_photo_repository.dart';
import 'package:platza/infrastructure/repositories/drift_user_settings_repository.dart';
import 'package:platza/infrastructure/repositories/firestore_care_log_repository.dart';
import 'package:platza/infrastructure/repositories/firestore_plant_repository.dart';

/// データベースインスタンスのProvider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// 植物リポジトリのProvider。
///
/// 認証済みユーザーの `users/{uid}/plants` subcollection を読み書きする
/// Firestore 実装を返す。サインイン前は [StateError] を投げる
/// （アプリは起動時に匿名認証で uid を確保するため、通常は到達しない）。
final plantRepositoryProvider = Provider<PlantRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final uid = ref.watch(currentAppUserProvider)?.uid;
  if (uid == null) {
    throw StateError(
      'plantRepositoryProvider was read before authentication completed.',
    );
  }
  return FirestorePlantRepository(firestore: firestore, uid: uid);
});

/// お世話ログリポジトリのProvider。
///
/// 認証済みユーザーの `users/{uid}/care_logs` subcollection を読み書きする
/// Firestore 実装を返す。サインイン前は [StateError] を投げる
/// （アプリは起動時に匿名認証で uid を確保するため、通常は到達しない）。
final careLogRepositoryProvider = Provider<CareLogRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final uid = ref.watch(currentAppUserProvider)?.uid;
  if (uid == null) {
    throw StateError(
      'careLogRepositoryProvider was read before authentication completed.',
    );
  }
  return FirestoreCareLogRepository(firestore: firestore, uid: uid);
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

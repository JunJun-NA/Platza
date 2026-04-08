import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/domain/entities/entities.dart';

/// ユーザー設定をリアルタイム監視するProvider
final userSettingsProvider = StreamProvider<UserSettings>((ref) {
  final repo = ref.watch(userSettingsRepositoryProvider);
  return repo.watchSettings();
});

/// ユーザー設定を更新するユーティリティ
Future<void> updateUserSettings(
  WidgetRef ref,
  UserSettings settings,
) async {
  final repo = ref.read(userSettingsRepositoryProvider);
  await repo.updateSettings(settings);
}

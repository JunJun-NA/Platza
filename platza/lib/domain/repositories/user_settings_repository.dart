import 'package:platza/domain/entities/user_settings.dart';

/// ユーザー設定リポジトリのインターフェース
abstract class UserSettingsRepository {
  Future<UserSettings> getSettings();
  Future<void> updateSettings(UserSettings settings);
  Stream<UserSettings> watchSettings();
}

/// ルート定義の定数
class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String plantDetail = '/plant/:id';
  static const String plantEdit = '/plant/:id/edit';
  static const String plantRegister = '/plant/register';
  static const String careLog = '/plant/:id/log';
  static const String statistics = '/statistics';
  static const String settings = '/settings';

  /// 植物詳細画面のパスを生成
  static String plantDetailPath(String id) => '/plant/$id';

  /// 植物編集画面のパスを生成
  static String plantEditPath(String id) => '/plant/$id/edit';

  /// お世話ログ画面のパスを生成
  static String careLogPath(String id) => '/plant/$id/log';
}

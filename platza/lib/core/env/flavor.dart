/// アプリの実行 flavor。
///
/// 起動エントリポイント (`main_dev.dart` / `main_prod.dart`) が
/// `bootstrap()` に渡すことで `AppEnv.flavor` に保持される。
enum Flavor {
  dev,
  prod;

  bool get isDev => this == Flavor.dev;
  bool get isProd => this == Flavor.prod;

  /// アプリ表示名。Android/iOS のネイティブ表示名と揃えること。
  String get appDisplayName {
    switch (this) {
      case Flavor.dev:
        return 'Platza dev';
      case Flavor.prod:
        return 'Platza';
    }
  }
}

/// アプリ全体から参照する flavor 状態。
///
/// `bootstrap()` 内で必ず `AppEnv.init()` を呼ぶこと。
/// 呼ばれる前に `flavor` を参照すると例外。
class AppEnv {
  AppEnv._();

  static Flavor? _flavor;

  static Flavor get flavor {
    final f = _flavor;
    if (f == null) {
      throw StateError(
        'AppEnv.flavor が未初期化です。bootstrap() より前に参照しないでください。',
      );
    }
    return f;
  }

  static void init(Flavor flavor) {
    _flavor = flavor;
  }

  static bool get isDev => flavor.isDev;
  static bool get isProd => flavor.isProd;
}

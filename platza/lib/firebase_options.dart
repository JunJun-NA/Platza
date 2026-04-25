// flavor に応じた Firebase 初期化オプションを返す。
//
// 実体は `firebase_options_dev.dart` / `firebase_options_prod.dart` に分離している。
// それぞれ Firebase Console からダウンロードした設定ファイル（plist / json）と
// 同じ値を持つ。
import 'package:firebase_core/firebase_core.dart';

import 'package:platza/core/env/flavor.dart';
import 'package:platza/firebase_options_dev.dart';
import 'package:platza/firebase_options_prod.dart';

FirebaseOptions firebaseOptionsForFlavor(Flavor flavor) {
  switch (flavor) {
    case Flavor.dev:
      return DevFirebaseOptions.currentPlatform;
    case Flavor.prod:
      return ProdFirebaseOptions.currentPlatform;
  }
}

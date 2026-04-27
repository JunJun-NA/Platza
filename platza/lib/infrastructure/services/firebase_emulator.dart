import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// debug × dev フレーバーで起動しているときに Emulator Suite に接続するかを判定する。
///
/// 当面は dev × debug の利用シーンを「ローカル開発（Mac 上のシミュレータ /
/// エミュレータ / Web / macOS）」前提として全プラットフォームで true を返す。
/// 実機 iOS で `localhost` を見ても Mac には届かないが、`flutter run -t main_dev.dart
/// --flavor=dev` を実機に向けて使う運用は想定していない。
///
/// 以前は iOS で `Platform.environment.containsKey('SIMULATOR_DEVICE_NAME')` を
/// 使っていたが、Flutter から見た `Platform.environment` は iOS シミュレータで
/// 空になることが多く、emulator に接続しないまま production endpoint に投げて
/// 詰まる事故があったため判定を撤去した。
bool shouldConnectToFirebaseEmulators() => true;

/// Firebase Emulator Suite に接続する。
///
/// debug ビルド時にのみ呼び出すこと。Android emulator からは `10.0.2.2`、
/// それ以外（iOS シミュレータ・macOS・web 等）からは `localhost` でアクセスする。
Future<void> connectToFirebaseEmulators() async {
  // iOS シミュレータでは `localhost` の名前解決が遅延・失敗することがあるため
  // 確実に解決できる `127.0.0.1` を使う。Android emulator はホスト Mac を
  // `10.0.2.2` で参照する。
  final host =
      defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : '127.0.0.1';

  FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);
}

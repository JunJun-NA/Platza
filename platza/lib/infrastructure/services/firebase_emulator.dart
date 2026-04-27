import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// debug × dev フレーバーで起動しているときに Emulator Suite に接続するかを判定する。
///
/// 想定:
/// - シミュレータ / Web / macOS 等のホスト Mac 上で動くもの: 接続する
/// - 物理デバイス（iOS 実機 / Android 実機）: 接続しない（実 platza-dev に向ける）
///
/// 物理デバイスから `127.0.0.1` を見ても Mac の Emulator には届かないため、
/// `device_info_plus` の `isPhysicalDevice` で判別して実機ではスキップする。
/// `Platform.environment` を使った旧実装はシミュレータでも空になることが多く
/// 信頼できなかったため [device_info_plus] を採用。
Future<bool> shouldConnectToFirebaseEmulators() async {
  if (kIsWeb) return true;

  final info = DeviceInfoPlugin();
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      final ios = await info.iosInfo;
      return !ios.isPhysicalDevice;
    case TargetPlatform.android:
      final android = await info.androidInfo;
      return !android.isPhysicalDevice;
    case TargetPlatform.macOS:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
    case TargetPlatform.fuchsia:
      return true;
  }
}

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

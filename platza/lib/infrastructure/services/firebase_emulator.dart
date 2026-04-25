import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// 実機からは Mac の `localhost` / `10.0.2.2` に届かないため、シミュレータ /
/// エミュレータ上で動いているときだけ Emulator Suite に接続する。実機の場合は
/// 実 Firebase プロジェクトに繋ぐ。
bool shouldConnectToFirebaseEmulators() {
  if (kIsWeb) return true;
  if (Platform.isIOS) {
    // iOS Simulator のみ環境変数 SIMULATOR_DEVICE_NAME が定義される
    return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');
  }
  if (Platform.isMacOS) return true;
  // Android: 実機 / エミュレータの判定が pure Dart では確実にできないため、
  // 当面は接続を試みる（実機で使う際は別途検出を追加する）
  return true;
}

/// Firebase Emulator Suite に接続する。
///
/// debug ビルド時にのみ呼び出すこと。Android emulator からは `10.0.2.2`、
/// それ以外（iOS シミュレータ・macOS・web 等）からは `localhost` でアクセスする。
Future<void> connectToFirebaseEmulators() async {
  final host =
      defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);
}

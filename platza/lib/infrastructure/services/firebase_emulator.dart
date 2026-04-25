import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

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

// Firebase 設定（platza-dev プロジェクト）
//
// このファイルは Firebase Console からダウンロードした
// GoogleService-Info.plist (iOS) / google-services.json (Android) と
// 同じ値を Dart コードに転記したもの。
// API キーは Firebase 仕様上クライアントに配布される公開情報であり機密ではない。
// セキュリティ境界は Firestore / Storage Rules で担保している。
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DevFirebaseOptions {
  const DevFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.android:
        return android;
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DevFirebaseOptions は iOS / Android のみサポートしています',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDs-5AiVHBp51E8hVzFbsdkt8lcLMly_sc',
    appId: '1:68486898567:ios:79bb734b3b14ba51092922',
    messagingSenderId: '68486898567',
    projectId: 'platza-dev',
    storageBucket: 'platza-dev.firebasestorage.app',
    iosBundleId: 'com.nakanojunya.platza.dev',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5GSCn9omiBpMwey0XL_snLPp4Ura54Es',
    appId: '1:68486898567:android:04a685dbce793c2a092922',
    messagingSenderId: '68486898567',
    projectId: 'platza-dev',
    storageBucket: 'platza-dev.firebasestorage.app',
  );
}

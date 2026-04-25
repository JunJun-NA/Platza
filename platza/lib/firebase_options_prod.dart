// Firebase 設定（platza-prod プロジェクト）
//
// このファイルは Firebase Console からダウンロードした
// GoogleService-Info.plist (iOS) / google-services.json (Android) と
// 同じ値を Dart コードに転記したもの。
// API キーは Firebase 仕様上クライアントに配布される公開情報であり機密ではない。
// セキュリティ境界は Firestore / Storage Rules で担保している。
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class ProdFirebaseOptions {
  const ProdFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.android:
        return android;
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'ProdFirebaseOptions は iOS / Android のみサポートしています',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjkpnoJoHxQJyRF3pkuR3SwZTJFmtkFec',
    appId: '1:605497061714:ios:6f902cb0d7b34da3564a8b',
    messagingSenderId: '605497061714',
    projectId: 'platza-prod',
    storageBucket: 'platza-prod.firebasestorage.app',
    iosBundleId: 'com.nakanojunya.platza',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArSyXHLDE4pZYEDICah_6-CowWq02JUu8',
    appId: '1:605497061714:android:9d40368956708f53564a8b',
    messagingSenderId: '605497061714',
    projectId: 'platza-prod',
    storageBucket: 'platza-prod.firebasestorage.app',
  );
}

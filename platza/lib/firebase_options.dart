// Firebase 初期設定（flavor 切替対応）
//
// `flutterfire configure --out=lib/firebase_options_dev.dart --project=platza-dev`
// などで dev/prod の実プロジェクト設定が生成されたら、本ファイルの
// `firebaseOptionsForFlavor` をそれら生成ファイルの `DefaultFirebaseOptions.currentPlatform`
// に差し替える。
//
// 現状はどちらの flavor も emulator 用 demo 設定を返す。
// `demo-` プレフィックスの projectId は Firebase Emulator Suite 公式の
// デモプロジェクトで、実環境には接続しない。
// https://firebase.google.com/docs/emulator-suite/connect_and_prototype#choose_a_firebase_project

import 'package:firebase_core/firebase_core.dart';

import 'package:platza/core/env/flavor.dart';

FirebaseOptions firebaseOptionsForFlavor(Flavor flavor) {
  switch (flavor) {
    case Flavor.dev:
      return _demoOptions;
    case Flavor.prod:
      return _demoOptions;
  }
}

const FirebaseOptions _demoOptions = FirebaseOptions(
  apiKey: 'demo-api-key',
  appId: '1:000000000000:web:0000000000000000000000',
  messagingSenderId: '000000000000',
  projectId: 'demo-platza',
  storageBucket: 'demo-platza.appspot.com',
);

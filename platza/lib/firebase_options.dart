// Firebase 初期設定ファイル（Emulator Suite 用のデモ設定）
//
// `demo-` プレフィックスのプロジェクト ID は Firebase Emulator Suite が
// 公式にサポートする「デモプロジェクト」で、実環境には一切接続しない。
// https://firebase.google.com/docs/emulator-suite/connect_and_prototype#choose_a_firebase_project
//
// 実プロジェクト接続は次ストーリ「開発環境 / 本番環境の整備」で
// `flutterfire configure` 実行時に flavor 別ファイル
// (`firebase_options_dev.dart` / `firebase_options_prod.dart`) に置き換える予定。
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'demo-platza',
    storageBucket: 'demo-platza.appspot.com',
  );
}

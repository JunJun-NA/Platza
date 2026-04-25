# 環境（Flavor）構成

dev / prod の 2 環境を Flutter flavor で切り替える。
本ドキュメントは「[開発環境 / 本番環境の整備](https://www.notion.so/34b4d8c8051681d1a40dfc30d1f25bdf)」ストーリの実装方針と運用手順をまとめる。

## Flavor 一覧

| Flavor | 用途 | Bundle ID (iOS) | applicationId (Android) | 表示名 | アイコン | Firebase プロジェクト |
|---|---|---|---|---|---|---|
| `dev` | 開発・検証 | `com.nakanojunya.platza.dev`（Phase 1B 以降） | `com.nakanojunya.platza.dev` | Platza dev | DEV バッジ付き | `platza-dev`（Phase 2 以降） |
| `prod` | 本番 | `com.nakanojunya.platza` | `com.nakanojunya.platza` | Platza | 通常 | `platza-prod`（Phase 2 以降） |

## 起動方法

```bash
# dev で起動
flutter run -t lib/main_dev.dart

# prod で起動
flutter run -t lib/main_prod.dart

# Android はさらに --flavor を付ける
flutter run -t lib/main_dev.dart --flavor=dev
flutter run -t lib/main_prod.dart --flavor=prod

# iOS の --flavor 対応は Phase 1B で実施（現状はエントリポイントのみで切替）
```

`flutter run`（エントリポイント未指定）は後方互換のため `main_dev.dart` を呼び出す。

## ビルド方法

### Android

```bash
# dev APK
flutter build apk --debug -t lib/main_dev.dart --flavor=dev

# prod APK / AAB
flutter build apk --release -t lib/main_prod.dart --flavor=prod
flutter build appbundle --release -t lib/main_prod.dart --flavor=prod
```

### iOS

```bash
# Phase 1A 現状: flavor 未対応
flutter build ipa --release -t lib/main_prod.dart

# Phase 1B 以降:
# flutter build ipa --release -t lib/main_prod.dart --flavor=prod
# flutter build ipa --release -t lib/main_dev.dart  --flavor=dev
```

## アーキテクチャ

| レイヤ | 責務 |
|---|---|
| `lib/main_dev.dart` / `lib/main_prod.dart` | flavor 別エントリポイント。`bootstrap()` を呼ぶだけ |
| `lib/main.dart` | 後方互換用。`flutter run` で起動された場合に `main_dev.dart` を呼ぶ |
| `lib/bootstrap.dart` | 共通の起動シーケンス（Firebase 初期化・通知サービス・runApp） |
| `lib/core/env/flavor.dart` | `Flavor` enum と `AppEnv.flavor` の保持 |
| `lib/firebase_options.dart` | `firebaseOptionsForFlavor(flavor)` で flavor に応じた `FirebaseOptions` を返す |

flavor は実行時に `AppEnv.flavor` 経由でどこからでも参照できる:

```dart
import 'package:platza/core/env/flavor.dart';

if (AppEnv.isDev) {
  // dev だけで動かす処理
}
```

## dev アイコン生成

dev 用アイコン（DEV バッジ付き）は `scripts/generate_dev_icons.py` で生成する。
prod アイコンを変更したら再実行すること。

```bash
python3 scripts/generate_dev_icons.py
```

入力: `platza/android/app/src/main/res/mipmap-*/ic_launcher.png`
       `platza/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-*.png`
出力: `platza/android/app/src/dev/res/mipmap-*/ic_launcher.png`
       `platza/ios/Runner/Assets.xcassets/AppIcon-dev.appiconset/Icon-App-*.png`

要件: Python 3 + Pillow (`pip3 install --user Pillow`)。

## 段階的な実装計画

### Phase 1A（このストーリで完了）

- [x] Flutter 側の flavor 構造（`Flavor` enum, `bootstrap()`, エントリポイント）
- [x] Android flavor（productFlavors, applicationIdSuffix, 表示名, dev アイコン）
- [x] iOS dev アイコン素材を `AppIcon-dev.appiconset` に配置（参照は Phase 1B で）
- [x] `firebase_options.dart` を flavor 切替の wrapper にリファクタ（demo 設定にフォールバック）
- [x] TestFlight CI に `-t lib/main_prod.dart` を追加
- [x] 本ドキュメント

### Phase 1B（次の PR、要 Apple Developer 作業）

junya 側の事前作業:
- [ ] Apple Developer Console で `com.nakanojunya.platza.dev` の Bundle ID 登録
- [ ] dev 用 Provisioning Profile を作成
- [ ] GitHub Secrets に dev 用の `BUILD_PROVISION_PROFILE_BASE64` 等を追加（必要なら別名で）

Claude 側の作業:
- [ ] iOS Xcode Configuration を 6 個に拡張（Debug/Release/Profile × dev/prod）
- [ ] iOS Scheme を `dev` / `prod` の 2 つに分離（既存の `Runner.xcscheme` を置き換え）
- [ ] 各 Configuration に `PRODUCT_BUNDLE_IDENTIFIER` / `ASSETCATALOG_COMPILER_APPICON_NAME` / `INFOPLIST_KEY_CFBundleDisplayName` を設定
- [ ] TestFlight CI を `--flavor=prod` 対応に変更
- [ ] dev 向け TestFlight ワークフロー（手動 dispatch のみ）を追加するかは要相談

### Phase 2（Firebase 実プロジェクト接続、要 Firebase Console 作業）

junya 側の事前作業:
- [ ] Firebase Console で `platza-dev` と `platza-prod` プロジェクトを作成（リージョン `asia-northeast1`）
- [ ] 各プロジェクトで iOS / Android アプリを登録（Bundle ID / applicationId は本ドキュメント上記の通り）
- [ ] FlutterFire CLI で `flutterfire configure --project=platza-dev --out=lib/firebase_options_dev.dart`
- [ ] 同じく `flutterfire configure --project=platza-prod --out=lib/firebase_options_prod.dart`
- [ ] 生成された `GoogleService-Info.plist` / `google-services.json` を flavor 別ディレクトリに配置

Claude 側の作業:
- [ ] `lib/firebase_options.dart` の `_demoOptions` を `firebase_options_dev.dart` / `firebase_options_prod.dart` の import に差し替え
- [ ] `connectToFirebaseEmulators()` の起動条件を `kDebugMode && AppEnv.isDev` に変更（prod は debug でも実環境）
- [ ] `firestore.rules` から `_health` ブロックを削除
- [ ] `.firebaserc` に dev / prod alias を設定
- [ ] README に `firebase emulators:start` の起動手順を追記

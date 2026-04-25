# 環境（Flavor）構成

dev / prod の 2 環境を Flutter flavor で切り替える。
本ドキュメントは「[開発環境 / 本番環境の整備](https://www.notion.so/34b4d8c8051681d1a40dfc30d1f25bdf)」ストーリの実装方針と運用手順をまとめる。

## Flavor 一覧

| Flavor | 用途 | Bundle ID (iOS) | applicationId (Android) | 表示名 | アイコン | Firebase プロジェクト |
|---|---|---|---|---|---|---|
| `dev` | 開発・検証 | `com.nakanojunya.platza.dev` | `com.nakanojunya.platza.dev` | Platza dev | DEV バッジ付き | `platza-dev` |
| `prod` | 本番 | `com.nakanojunya.platza` | `com.nakanojunya.platza` | Platza | 通常 | `platza-prod` |

## 起動方法

```bash
# dev で起動（iOS / Android 共通）
flutter run -t lib/main_dev.dart --flavor=dev

# prod で起動
flutter run -t lib/main_prod.dart --flavor=prod
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
flutter build ipa --release -t lib/main_prod.dart --flavor=prod
flutter build ipa --release -t lib/main_dev.dart  --flavor=dev
```

iOS の Build Configuration は `Debug-{dev,prod}` / `Release-{dev,prod}` /
`Profile-{dev,prod}` の 6 種類。Scheme は `dev` と `prod` の 2 つ。
Flutter の `--flavor` フラグで scheme と Configuration を切り替える。

| Configuration | Signing | 用途 |
|---|---|---|
| `Debug-prod` / `Debug-dev` | Automatic | `flutter run` |
| `Profile-prod` | Manual (Platza App Store) | プロファイル測定 |
| `Profile-dev` | Automatic | 同上（dev） |
| `Release-prod` | Manual (Platza App Store) | TestFlight / App Store |
| `Release-dev` | Automatic | 開発端末への dev 配布 |

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

### Phase 1A（完了）

- [x] Flutter 側の flavor 構造（`Flavor` enum, `bootstrap()`, エントリポイント）
- [x] Android flavor（productFlavors, applicationIdSuffix, 表示名, dev アイコン）
- [x] iOS dev アイコン素材を `AppIcon-dev.appiconset` に配置
- [x] `firebase_options.dart` を flavor 切替の wrapper にリファクタ（demo 設定にフォールバック）

### Phase 1B（完了）

junya 側の作業（実施済み）:
- [x] Apple Developer Console で `com.nakanojunya.platza.dev` の Bundle ID 登録
- [ ] dev 用 Provisioning Profile（必要になった時点で作成。現状 Automatic signing で運用）
- [ ] GitHub Secrets に dev 用シークレット（dev TestFlight が必要になった時点で追加）

Claude 側の作業:
- [x] iOS Xcode Configuration を 6 個に拡張（`scripts/setup_ios_flavors.rb`）
- [x] iOS Scheme を `dev` / `prod` の 2 つに分離
- [x] 各 Configuration に `PRODUCT_BUNDLE_IDENTIFIER` / `ASSETCATALOG_COMPILER_APPICON_NAME` / `INFOPLIST_KEY_CFBundleDisplayName` を設定
- [x] Flutter/Configuration 別 xcconfig を 6 個追加し pbxproj を張り直し（`scripts/wire_ios_xcconfigs.rb`）
- [x] TestFlight CI を `--flavor=prod` 対応に変更

### Phase 2（完了）

junya 側の作業（実施済み）:
- [x] Firebase Console で `platza-dev` と `platza-prod` プロジェクトを作成
- [x] 各プロジェクトで iOS / Android アプリを登録（Bundle ID / applicationId は本ドキュメント上記の通り）
- [x] `GoogleService-Info.plist` / `google-services.json` をダウンロード

Claude 側の作業:
- [x] `lib/firebase_options_dev.dart` / `lib/firebase_options_prod.dart` を生成
- [x] `lib/firebase_options.dart` を実プロジェクト options に切替
- [x] iOS plist を `platza/ios/Runner/Firebase/{dev,prod}/` に配置
- [x] Android google-services.json を `platza/android/app/src/{dev,prod}/` に配置
- [x] iOS Build Phase で flavor に応じて plist をコピーする Run Script を追加
- [x] Android `com.google.gms.google-services` プラグインを適用
- [x] `connectToFirebaseEmulators()` の起動条件を `kDebugMode && AppEnv.isDev` に変更
- [x] `firestore.rules` から `_health` ブロックを削除
- [x] `.firebaserc` に dev / prod alias を設定
- [x] gitignore 方針を更新（Firebase クライアント設定は API キーを含むがクライアント配布される公開情報なので commit する）

## ローカル開発: Emulator Suite

dev × debug ビルドのときだけ自動で emulator に接続する。
emulator を別ターミナルで起動しておく:

```bash
# 初回のみ
npm install -g firebase-tools

# emulator 起動
firebase emulators:start
```

prod プロジェクトに切り替える場合:
```bash
firebase use prod   # → platza-prod
firebase use dev    # → platza-dev に戻す
```

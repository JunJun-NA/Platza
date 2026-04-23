# iOS TestFlight 自動配信

`main` ブランチに push されると `.github/workflows/ios-testflight.yml` が起動し、iOS アプリをビルドして TestFlight に自動アップロードする。

## 全体フロー

```
main に push
  └─ macos-latest Runner
       ├─ Flutter / Ruby セットアップ
       ├─ .p12 を一時 Keychain にインポート
       ├─ .mobileprovision を ~/Library/MobileDevice/ に配置
       ├─ flutter build ipa --release --build-number=${GITHUB_RUN_NUMBER}
       │     └─ ExportOptions.plist で Manual signing / App Store 配布
       └─ bundle exec fastlane beta
             └─ App Store Connect API Key で認証 → pilot upload
```

処理完了後、App Store Connect 側で processing（数分〜十数分）が走り、完了すると TestFlight に配信可能な状態になる。

---

## GitHub Secrets 一覧（7 件）

> Team ID (`CBM628X293`) は秘密情報ではないため Secret ではなく `platza/ios/fastlane/Appfile` にハードコードしている。

| Secret Key | 内容 | 取得元 |
|---|---|---|
| `APP_STORE_CONNECT_API_KEY_ID` | App Store Connect API Key の Key ID | App Store Connect → Users and Access → Integrations → App Store Connect API |
| `APP_STORE_CONNECT_API_ISSUER_ID` | Issuer ID（同画面上部） | 同上 |
| `APP_STORE_CONNECT_API_KEY_CONTENT` | `.p8` ファイルの中身（改行含むプレーンテキスト、`-----BEGIN...` を含む全文） | API Key 発行時に DL する `AuthKey_XXXXXXXXXX.p8` の中身 |
| `BUILD_CERTIFICATE_BASE64` | Distribution 証明書 `.p12` を base64 エンコードした文字列 | Keychain Access → Apple Distribution → 右クリック → 書き出し |
| `P12_PASSWORD` | `.p12` エクスポート時に設定したパスワード | 上記 export 時に手動設定 |
| `BUILD_PROVISION_PROFILE_BASE64` | App Store 配布用 `.mobileprovision` を base64 化した文字列 | Developer Portal で `Platza App Store` という名前の profile を作成 → DL |
| `KEYCHAIN_PASSWORD` | CI Runner 上の一時 Keychain のパスワード | 任意の強いランダム文字列（1Password 等で生成） |

---

## 事前準備（初回のみ）

### 1. App Store Connect API Key の発行

1. [App Store Connect](https://appstoreconnect.apple.com/) → Users and Access → Integrations タブ → App Store Connect API
2. Keys サブタブ → `+` で新規発行
3. Name: `Platza CI` / Access: **App Manager**
4. 発行後 `AuthKey_XXXXXXXXXX.p8` を DL（**一度しか DL できない**）
5. Key ID / Issuer ID を控える

### 2. Distribution 証明書 `.p12` の export

1. Xcode で一度 Archive を通しておく（Apple Distribution 証明書が Keychain に登録される）
2. Keychain Access.app を開く → login Keychain
3. 「Apple Distribution: Junya Nakano (CBM628X293)」を右クリック → 「...を書き出す」
4. Personal Information Exchange (.p12) 形式で保存、パスワードを設定
5. このパスワードが `P12_PASSWORD`

### 3. App Store 配布用 provisioning profile の作成

1. [Developer Portal](https://developer.apple.com/account/resources/profiles/list) → Profiles → `+`
2. Distribution → **App Store Connect**
3. App ID: `com.nakanojunya.platza`
4. Certificate: 上で作成した Apple Distribution
5. **Profile Name: `Platza App Store`**（`ios/ExportOptions.plist` のキーと一致させる必要あり）
6. Generate → DL

### 4. GitHub Secrets に登録

base64 化して pbcopy：

```bash
# .p12
base64 -i /path/to/Distribution.p12 | pbcopy
# → BUILD_CERTIFICATE_BASE64 に貼付

# .mobileprovision
base64 -i /path/to/Platza_App_Store.mobileprovision | pbcopy
# → BUILD_PROVISION_PROFILE_BASE64 に貼付

# .p8 の中身（改行含む）
cat /path/to/AuthKey_XXXXXXXXXX.p8 | pbcopy
# → APP_STORE_CONNECT_API_KEY_CONTENT に貼付
```

GitHub → Repository Settings → Secrets and variables → Actions → New repository secret で 8 件登録。

---

## 初回動作確認

1. Actions タブ → **iOS TestFlight** ワークフロー → Run workflow で `main` を手動実行
2. 5〜10 分後、App Store Connect の TestFlight タブにビルドが表示される（processing ステータス）
3. processing 完了後、内部テスターに配信可能な状態になる

---

## ローカル再現（手動アップロード）

```bash
cd platza/ios
bundle install

export APP_STORE_CONNECT_API_KEY_ID="..."
export APP_STORE_CONNECT_API_ISSUER_ID="..."
export APP_STORE_CONNECT_API_KEY_CONTENT="$(cat /path/to/AuthKey_XXXXXXXXXX.p8)"

cd ..
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist
cd ios
bundle exec fastlane beta
```

---

## Secret の更新

- **`.p12` の有効期限が切れた**: Distribution 証明書を再発行 → 新しい `.p12` を export → `BUILD_CERTIFICATE_BASE64` と `P12_PASSWORD` を更新
- **`.mobileprovision` の有効期限が切れた**: Developer Portal で profile を再生成（名前は `Platza App Store` のまま） → DL → `BUILD_PROVISION_PROFILE_BASE64` を更新
- **API Key を revoke した場合**: 新しい Key を発行 → 3 つの API Key 関連 Secret を全て更新

---

## トラブルシューティング

### `objective_c.framework` の dSYM が欠落してアップロード失敗

`objective_c.framework` は `path_provider_foundation` が依存する Dart Native Assets で、Flutter は dSYM を生成しない。`Runner` ターゲットの Build Phases に **「Generate dSYMs for Native Assets」Run Script** を配置しており、archive 時に `dsymutil` で dSYM を生成する。この Run Script phase が消えるとアップロードが再度失敗するので注意。

### ビルド番号が重複して reject

`--build-number=${{ github.run_number }}` で採番しているため通常は発生しない。手動でビルド番号を巻き戻した場合のみ要注意。

### `No signing certificate` / `No provisioning profile found`

- Secrets の base64 が壊れている可能性（途中に改行や空白が混入）→ 再エンコードして登録し直す
- profile の Name が `Platza App Store` から変わっている → `ios/ExportOptions.plist` の値を合わせる

### Keychain のロック関連エラー

`security unlock-keychain` が失敗する場合、`KEYCHAIN_PASSWORD` が空または不一致の可能性。Secret を再設定する。

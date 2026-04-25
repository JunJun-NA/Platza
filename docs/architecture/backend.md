# バックエンド技術選定

## 決定事項

**採用: Firebase**

- Auth: Firebase Authentication（Apple / Google / メール）
- DB: Cloud Firestore
- Storage: Cloud Storage for Firebase
- 通知: Firebase Cloud Messaging (FCM)
- サーバ関数: Cloud Functions（必要になった時点で導入）
- リージョン: `asia-northeast1`（東京）

関連 Notion ストーリ: [バックエンド技術選定](https://www.notion.so/34b4d8c8051681f98ab0d9f92b3ac36d)

---

## 要件（選定の前提）

### 機能要件
- ユーザー認証（Apple / Google / メール）
- 複数端末でのデータ同期（植物・お世話ログ・写真）
- 写真のクラウド保存
- 植物種マスタの配信（将来的に更新配信）
- 通知・リマインダ（将来）
- バックアップ / 復元

### 非機能要件
- 個人開発 — ランニングコスト最小、運用負荷最小
- オフラインファースト — 既存 Drift(SQLite) を壊さない
- 日本リージョンで低レイテンシ
- iOS / Android 両対応を見据える
- 初期 ～100 名、目標 数百〜数千

---

## 比較した候補

Firebase と Supabase の 2 強に絞って比較（AWS / Amplify 等は個人開発の運用負荷で除外）。

| 観点 | Firebase | Supabase |
|---|---|---|
| Flutter SDK | FlutterFire（成熟） | supabase_flutter（十分） |
| 認証 | ◎ Apple/Google/メール設定のみ | ○ Apple は手数多め |
| **オフライン書き込み** | ◎ Firestore SDK が自動キュー & 再送 | △ 自前実装必要 |
| DB | Firestore（NoSQL） | Postgres |
| 既存 Drift との整合 | △ マッパー必要 | ◎ ほぼそのまま |
| 写真ストレージ | 5GB 無料 | 1GB 無料 |
| 通知 | ◎ FCM 標準 | △ サードパーティ併用 |
| **無料枠の永続性** | ◎ Spark 無期限 | △ 1 週間無アクセスで停止 |
| ロックイン | 強 | 弱（セルフホスト可） |
| SQL 直叩き | × | ◎ |

### Firebase を選んだ決定打

1. **オフライン書き込みが SDK 自動**
   Drift と並行稼働させる前提では、Firestore の自動キュー & 同期で同期層の実装量が激減する。Supabase は競合解決・再送バッファ・未送信キューを自前実装することになり「バックエンド構築」（見積 8）の範囲を超える可能性が高い。

2. **認証の実装量が最少**
   FlutterFire で Apple/Google/メールがほぼ設定のみ。「ログイン機能」（見積 5）が確実に収まる。

3. **無料枠が永続**
   Supabase Free tier は 1 週間無アクセスでプロジェクト自動停止。個人開発では dev 環境で頻繁にハマる。Firebase Spark は停止なし。

4. **通知まで一気通貫**
   FCM で Push 通知まで完結。将来の季節アドバイス通知などに追加コストなし。

### トレードオフ（受け入れるコスト）

- **Firestore と Drift でスキーマが別物**
  リポジトリ層に Firestore ↔ Drift のマッパーが必要。これは「同期層として作り込む」と割り切る。
- **GCP ロックイン**
  個人開発初期はスピード優先で許容。将来規模が大きくなった場合にポータビリティが論点になる。

---

## AI 機能との関係

将来の AI エージェント機能（植物判定・アドバイス生成・会話エージェント・図鑑 RAG 等）は、
**バックエンド選定とは独立したレイヤー**として扱う。

- LLM（Claude / OpenAI / Gemini）API は HTTPS 呼び出しなのでどの BaaS からも同じに呼べる
- 初期の AI 機能（判定・生成・会話）は **Firebase + 外部 LLM API 直呼び** で十分
- RAG が必要になった場合は **Vertex AI Vector Search / 外部ベクトル DB (Pinecone 等)** を追加
- ファインチューニングや大規模 RAG まで踏み込む段階では、AI 基盤だけ AWS / GCP を併用する選択肢を再検討する

「AI 機能のために BaaS を乗り換える」ではなく、「AI プロバイダを切り替える」ほうが実装コストは低い。

---

## 環境分離方針

- **dev / prod の 2 プロジェクト**を Firebase 上に作る（例: `platza-dev`, `platza-prod`）
- Flutter 側は **flavor + `firebase_options_{dev,prod}.dart`** で切替
- iOS: `GoogleService-Info.plist`、Android: `google-services.json` を flavor 別に配置
- ローカル開発は **Firebase Emulator Suite** を活用（Firestore / Auth / Storage / Functions をオフラインで動作）
- 両環境とも **Spark プラン（無料）** 内で運用可能

詳細は「開発環境 / 本番環境の整備」ストーリで実装。

---

## シークレット / コンフィグの扱い

| ファイル | 扱い | 備考 |
|---|---|---|
| `platza/lib/firebase_options.dart` | **コミット** | flavor 切替の wrapper |
| `platza/lib/firebase_options_dev.dart` | **コミット** | `platza-dev` の設定値 |
| `platza/lib/firebase_options_prod.dart` | **コミット** | `platza-prod` の設定値 |
| `platza/ios/Runner/Firebase/{dev,prod}/GoogleService-Info.plist` | **コミット** | flavor 別配置。Build Phase で Configuration に応じてコピー |
| `platza/android/app/src/{dev,prod}/google-services.json` | **コミット** | Android source set による自動切替 |
| `firestore.rules` / `storage.rules` | **コミット** | レビュー対象。`firebase deploy --only firestore:rules` で反映 |
| `firebase.json` / `.firebaserc` | **コミット** | `firebase use dev|prod` で切替 |
| App Store Connect API Key (`*.p8`) / 証明書 (`*.p12`) | **gitignore + GitHub Secrets** | iOS 署名関連。既存運用継続 |

**原則**: Firebase クライアント設定 (`firebase_options_*.dart` / plist / json) は
**API キーを含むがクライアントに配布される公開情報であり機密ではない**。
セキュリティ境界は Firestore / Storage Rules と App Check で担保する。
[Firebase 公式ドキュメント](https://firebase.google.com/docs/projects/api-keys) も
これらをリポジトリにコミットすることを許容している。

App Store Connect API Key や iOS 署名証明書のような **真の機密情報** は
gitignore + GitHub Secrets で管理する（既存の TestFlight CI 運用通り）。

---

## 次のストーリへの引き継ぎ

### バックエンド構築
- `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage` を `pubspec.yaml` に追加
- Firestore セキュリティルールは最初から厳格に（`request.auth.uid == resource.data.userId` 前提）
- スキーマ初期案:
  - `users/{uid}` — プロフィール
  - `users/{uid}/plants/{plantId}` — 植物
  - `users/{uid}/plants/{plantId}/careLogs/{logId}` — お世話ログ
  - `users/{uid}/plants/{plantId}/photos/{photoId}` — 写真メタ（実体は Storage）
  - `species/{speciesId}` — 植物種マスタ（読み取りのみ公開）
- Drift ↔ Firestore マッパーをリポジトリ層に配置

### ログイン機能の作成
- FlutterFire で Apple / Google / メールを実装
- Apple Sign-In は iOS 必須（App Store 審査要件）
- `authStateChangesProvider`(Riverpod) で監視 → ルーティングガード

### 開発環境 / 本番環境の整備
- Firebase プロジェクトを dev / prod で 2 つ作成
- flavor 設定、`GoogleService-Info.plist` / `google-services.json` の分離
- `.firebaserc` に alias 登録、`firebase use <alias>` で切替
- Emulator Suite を開発で常用する運用に揃える
- 既存の TestFlight GitHub Actions を dev / prod 別ビルドに拡張

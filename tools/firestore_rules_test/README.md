# Firestore Security Rules テスト

Platza の `firestore.rules` をエミュレータ上で検証するテスト。
`@firebase/rules-unit-testing` + Jest を使い、`firebase emulators:exec` 経由で Firestore Emulator を立ち上げてシナリオを実行する。

## 前提

- Node.js 20 以上
- Java 11 以上（Firebase Emulator が要求）

## セットアップ

```bash
cd tools/firestore_rules_test
npm install
```

## テスト実行

```bash
cd tools/firestore_rules_test
npm test
```

内部的には次のコマンドが走る:

```bash
firebase emulators:exec --only firestore --project demo-platza "jest --runInBand"
```

`demo-` プレフィックスのプロジェクト ID を指定しているため、エミュレータ専用モードで動作し、本番プロジェクトに影響を与えない。

## 検証している主なシナリオ

- `users/{uid}` ドキュメントとその subcollection（plants / care_logs / care_schedules / plant_photos / settings）
  - オーナーは R/W 可能
  - 他人・未認証は R/W 不可
- `species/{speciesId}` マスタ
  - 認証済みユーザーは読み取り可能
  - 認証済みでも書き込み不可（Cloud Functions / 管理者ツール経由のみ）
  - 未認証は読み取り不可
- 未定義パスは全拒否

詳細は [`tests/firestore.test.js`](tests/firestore.test.js) を参照。

## ルールを更新したら

1. リポジトリ root の `firestore.rules` を編集
2. `npm test` でローカル検証
3. PR レビュー後、`firebase deploy --only firestore:rules` で dev / prod に反映（[docs/firestore_schema.md](../../docs/firestore_schema.md#デプロイ手順) 参照）

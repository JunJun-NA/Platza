# Firestore データモデル

Platza の Cloud Firestore におけるデータモデル定義。
ローカル DB（Drift）からクラウド同期に切り替えるための土台として、コレクション構造・フィールド・型・アクセス制御を整理する。

- 対象プロジェクト: `platza-dev` / `platza-prod`
- セキュリティルール: [`firestore.rules`](../firestore.rules)
- ストレージルール: [`storage.rules`](../storage.rules)

## 基本方針

- **ユーザー所有データは `users/{uid}` 配下の subcollection に置く**
  - `users/{uid}` ドキュメント自体には最小限のプロフィールを保持
  - 配下の各 subcollection で植物・お世話履歴・設定などを管理
- **マスタデータは top-level に置き、認証済みユーザーは読み取りのみ可**
  - 例: `species/{speciesId}` （植物種）
- **書き込みはオーナー（自分の `uid` 配下）に限定する**（[`firestore.rules`](../firestore.rules) 参照）
- **ドキュメント ID** は基本的にエンティティの `id` フィールドと一致させる（クライアントで UUID を生成する想定）
- **タイムスタンプ** は Firestore の `Timestamp` 型を採用する。クライアント側は `DateTime` ↔ `Timestamp` の変換を Repository で行う
- **Enum** は Dart 側の `name`（例: `water`, `indoor`）を文字列として保存する

## パス階層

```
users/{uid}                                      # AppUser プロフィール
├── plants/{plantId}                             # 登録植物
├── care_logs/{careLogId}                        # お世話履歴
├── care_schedules/{scheduleId}                  # お世話スケジュール
├── plant_photos/{photoId}                       # 植物写真メタデータ（バイナリは Storage）
└── settings/{settingsDocId="app"}               # ユーザー設定（単一ドキュメント）

species/{speciesId}                              # 植物種マスタ（読み取り専用）
```

## コレクション定義

### `users/{uid}`

ユーザーごとのプロフィール。Firebase Authentication の `uid` をドキュメント ID として使う。
匿名認証ユーザーも同じパスを利用する。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `uid` | string | ✓ | Auth の uid と一致。冗長だがクエリしやすさのため保持 |
| `isAnonymous` | bool | ✓ | 匿名認証フラグ |
| `email` | string \| null | | メールリンク後のみ設定 |
| `displayName` | string \| null | | 任意設定 |
| `createdAt` | Timestamp | ✓ | 初回作成時刻（serverTimestamp 推奨） |
| `updatedAt` | Timestamp | ✓ | 更新時刻（serverTimestamp 推奨） |

対応する Domain エンティティ: [`AppUser`](../platza/lib/domain/entities/app_user.dart)

### `users/{uid}/plants/{plantId}`

ユーザーが登録した植物。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `id` | string | ✓ | ドキュメント ID と一致 |
| `nickname` | string | ✓ | ユーザーが付けた呼び名 |
| `speciesId` | string | ✓ | `species/{speciesId}` への参照 |
| `location` | string | ✓ | enum: `indoor` / `outdoor` / `window` |
| `status` | string | ✓ | enum: `happy` / `thirsty` / `wilting` / `blooming` |
| `growthStage` | string | ✓ | enum: `seedling` / `growing` / `mature` / `flowering` |
| `lastWatered` | Timestamp \| null | | 最終水やり日時 |
| `lastFertilized` | Timestamp \| null | | 最終施肥日時 |
| `lastRepotted` | Timestamp \| null | | 最終植え替え日時 |
| `createdAt` | Timestamp | ✓ | 登録日時 |
| `streakDays` | int | ✓ | お世話継続日数（デフォルト 0） |

対応する Domain エンティティ: [`Plant`](../platza/lib/domain/entities/plant.dart)

### `users/{uid}/care_logs/{careLogId}`

お世話の履歴。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `id` | string | ✓ | ドキュメント ID と一致 |
| `plantId` | string | ✓ | `users/{uid}/plants/{plantId}` への参照 |
| `careType` | string | ✓ | enum: `water` / `fertilize` / `repot` / `sunlight` |
| `performedAt` | Timestamp | ✓ | 実施日時 |
| `note` | string \| null | | メモ（任意） |

推奨インデックス:
- `plantId` ASC + `performedAt` DESC（特定植物の履歴を新しい順に取得）

対応する Domain エンティティ: [`CareLog`](../platza/lib/domain/entities/care_log.dart)

### `users/{uid}/care_schedules/{scheduleId}`

お世話スケジュール。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `id` | string | ✓ | ドキュメント ID と一致 |
| `plantId` | string | ✓ | `users/{uid}/plants/{plantId}` への参照 |
| `careType` | string | ✓ | enum: `water` / `fertilize` / `repot` / `sunlight` |
| `intervalDays` | int | ✓ | 周期（日数、>= 1） |
| `nextDueDate` | Timestamp | ✓ | 次回予定日時 |
| `isEnabled` | bool | ✓ | 有効/無効 |

推奨インデックス:
- `isEnabled` ASC + `nextDueDate` ASC（リマインダー対象を取得するため）

対応する Domain エンティティ: [`CareSchedule`](../platza/lib/domain/entities/care_schedule.dart)

### `users/{uid}/plant_photos/{photoId}`

植物の写真メタデータ。バイナリは Cloud Storage の `users/{uid}/plant_photos/{photoId}.jpg` に格納する想定。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `id` | string | ✓ | ドキュメント ID と一致 |
| `plantId` | string | ✓ | `users/{uid}/plants/{plantId}` への参照 |
| `storagePath` | string | ✓ | Cloud Storage 上のフルパス（例: `users/{uid}/plant_photos/{photoId}.jpg`）。<br>※ Domain 側 `PlantPhoto.filePath` から名称を変更（ローカル絶対パスではなく Storage パスを格納するため）。 |
| `caption` | string \| null | | キャプション（任意） |
| `createdAt` | Timestamp | ✓ | 撮影/登録日時 |

推奨インデックス:
- `plantId` ASC + `createdAt` DESC

対応する Domain エンティティ: [`PlantPhoto`](../platza/lib/domain/entities/plant_photo.dart)

### `users/{uid}/settings/app`

ユーザー設定。ドキュメント ID は固定で `app` を使う（ユーザーごとに 1 件のみ）。

| フィールド | 型 | 必須 | デフォルト | 備考 |
| --- | --- | --- | --- | --- |
| `notificationEnabled` | bool | ✓ | `true` | 通知 ON/OFF |
| `waterReminderHour` | int | ✓ | `8` | 水やりリマインダー時刻（0–23） |
| `waterReminderMinute` | int | ✓ | `0` | 水やりリマインダー分（0–59） |
| `fertilizerReminderEnabled` | bool | ✓ | `true` | 肥料リマインダーの有効/無効 |
| `isDarkMode` | bool | ✓ | `false` | ダークモード |
| `updatedAt` | Timestamp | ✓ | | 更新時刻（serverTimestamp 推奨） |

対応する Domain エンティティ: [`UserSettings`](../platza/lib/domain/entities/user_settings.dart)

### `species/{speciesId}`

植物種マスタ。**全認証ユーザーが読み取り可能 / 書き込み不可**。
管理用の書き込みは Firebase Console もしくは Cloud Functions で行う。

| フィールド | 型 | 必須 | 備考 |
| --- | --- | --- | --- |
| `id` | string | ✓ | ドキュメント ID と一致 |
| `name` | string | ✓ | 表示名 |
| `category` | string | ✓ | enum: `succulent` / `cactus` |
| `waterFrequencyDays` | int | ✓ | 推奨水やり間隔（日） |
| `fertilizerFrequencyDays` | int | ✓ | 推奨施肥間隔（日） |
| `repotFrequencyDays` | int | ✓ | 推奨植え替え間隔（日） |
| `sunlightNeed` | string | ✓ | enum: `low` / `medium` / `high` |
| `winterCare` | string | ✓ | 冬のお世話メモ |
| `summerCare` | string | ✓ | 夏のお世話メモ |
| `description` | string | ✓ | 説明文 |
| `assetPrefix` | string | ✓ | クライアント側ドット絵アセットの prefix |

対応する Domain エンティティ: [`PlantSpecies`](../platza/lib/domain/entities/plant_species.dart)

## アクセス制御サマリ

| パス | 認証なし | 認証あり（他人） | 認証あり（本人 = `request.auth.uid == uid`） |
| --- | --- | --- | --- |
| `users/{uid}/**` | 拒否 | 拒否 | R/W |
| `species/{speciesId}` | 拒否 | R | R |
| その他 | 拒否 | 拒否 | 拒否 |

詳細は [`firestore.rules`](../firestore.rules) を参照。

## 命名・型の運用ルール

- **コレクション名**: snake_case（例: `care_logs`, `plant_photos`）。
- **フィールド名**: lowerCamelCase（Dart 側のフィールド名と一致させる）。
- **Enum 値**: Dart 側の `name`（lowerCamelCase）。表示用ラベル（日本語）はクライアント側で `enum.label` から解決する。
- **Timestamp**: 書き込み時は可能な限り `FieldValue.serverTimestamp()` を使い、クロックずれを防ぐ。
  - ただし `performedAt` のようにユーザーが過去日時を指定できるフィールドはクライアント側 `DateTime` をそのまま `Timestamp` 化して保存する。
- **`createdAt` / `updatedAt`**: 監査用に各ドキュメントに保持することを推奨。`updatedAt` は更新時に必ず付与する。

## デプロイ手順

```bash
# プロジェクトを切り替えて
firebase use dev    # platza-dev
firebase deploy --only firestore:rules,storage

firebase use prod   # platza-prod
firebase deploy --only firestore:rules,storage
```

## ルールテスト

`@firebase/rules-unit-testing` を使ったテストを `tools/firestore_rules_test/` に配置している。

```bash
cd tools/firestore_rules_test
npm install
npm test
```

`npm test` は内部で `firebase emulators:exec` を呼び、Firestore Emulator を立ち上げてテストを実行する。

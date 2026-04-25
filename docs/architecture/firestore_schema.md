# Firestore スキーマ設計

「バックエンド構築」ストーリで決定した初期スキーマ。
Drift（ローカル SQLite）と並行稼働するクラウド側の構造を定義する。

関連 Notion ストーリ: [バックエンド構築](https://www.notion.so/34b4d8c80516819da742e631eaee3dfb)

## 設計方針

- **ユーザー所有データはすべて `users/{uid}` 配下のサブコレクション**
  セキュリティルールが「`uid` が一致する」だけで完結する。
- **写真の実体は Cloud Storage、Firestore にはメタデータのみ**
  Firestore のドキュメント上限 (1MB) を意識する必要がない。
- **植物種マスタは全ユーザー共通の `species/`**
  読み取りは公開、書き込みは管理者のみ。
- **Drift の主キー (uuid) をそのまま Firestore のドキュメント ID に使う**
  ローカルとクラウドで ID が一致するので同期層が単純になる。

## コレクション構造

```
users/{uid}
  ├─ プロフィール（displayName, photoURL, createdAt, updatedAt）
  │
  ├─ plants/{plantId}
  │    ├─ 植物本体（name, speciesId, plantedAt, ...）
  │    │
  │    ├─ careLogs/{logId}
  │    │    └─ お世話ログ（type, performedAt, note, ...）
  │    │
  │    ├─ careSchedules/{scheduleId}
  │    │    └─ お世話スケジュール（type, intervalDays, lastPerformedAt, ...）
  │    │
  │    └─ photos/{photoId}
  │         └─ 写真メタ（storagePath, takenAt, caption, ...）
  │
  └─ settings/preferences
       └─ ユーザー設定（テーマ、通知設定 など。単一ドキュメント）

species/{speciesId}
  └─ 植物種マスタ（name, family, careAdvice など。読み取りのみ公開）
```

## Storage 構造

```
users/{uid}/plants/{plantId}/photos/{photoId}.jpg
```

Firestore の `users/{uid}/plants/{plantId}/photos/{photoId}` ドキュメントに
保存される `storagePath` がこの実体パスを指す。

## Drift エンティティとの対応

| Drift テーブル | Firestore コレクション |
|---|---|
| `plants` | `users/{uid}/plants/{plantId}` |
| `care_logs` | `users/{uid}/plants/{plantId}/careLogs/{logId}` |
| `care_schedules` | `users/{uid}/plants/{plantId}/careSchedules/{scheduleId}` |
| `plant_photos` | `users/{uid}/plants/{plantId}/photos/{photoId}` |
| `user_settings` | `users/{uid}/settings/preferences` |

実際の Drift ↔ Firestore マッパー実装は、ログイン機能で `uid` が確定した
あとの後続ストーリで行う。本ストーリではスキーマと配置だけを決める。

## 命名規約

- ドキュメント / フィールドは `lowerCamelCase`
- タイムスタンプ系は `*At`（例: `createdAt`, `performedAt`）
- 真偽値は `is*` / `has*`（例: `isArchived`）
- 種別系は `*Type`（例: `careType`）

## セキュリティルール

`firestore.rules` に定義する。原則は次のとおり:

- `users/{uid}` 配下: 認証済みかつ `request.auth.uid == uid` の場合のみ読み書き可
- `species/`: 認証済みなら読み取り可、書き込みは不可（Cloud Functions 経由でのみ更新）
- それ以外: 全拒否

# Platza

多肉植物・サボテンをドット絵で育てる、たまごっち風お世話管理アプリ（Flutter）

## Tech Stack

- **Flutter** (Dart SDK >=3.0.0 <4.0.0)
- **状態管理**: Riverpod (flutter_riverpod + riverpod_annotation + riverpod_generator)
- **ローカルDB**: Drift (SQLite)
- **ルーティング**: go_router
- **ドット絵/アニメーション**: Flame
- **コード生成**: freezed, json_serializable, drift_dev, build_runner

## Architecture

クリーンアーキテクチャ構成:

```
platza/lib/
├── main.dart
├── app.dart
├── core/           # 定数、テーマ
├── domain/         # エンティティ、Enum、リポジトリインターフェース
├── infrastructure/ # DB実装、リポジトリ実装
├── application/    # Provider定義
└── presentation/   # 画面、ウィジェット
```

## Commands

```bash
# コード生成（freezed, drift, riverpod_generator など）
cd platza && dart run build_runner build --delete-conflicting-outputs

# 静的解析
cd platza && flutter analyze

# テスト
cd platza && flutter test

# 実行
cd platza && flutter run
```

## Rules

- Dart/Flutterの公式スタイルガイドに従う
- エンティティは freezed で定義する
- DB操作は Drift で実装し、domain層のリポジトリインターフェースを実装する形にする
- 状態管理は Riverpod を使い、可能な限り riverpod_generator（@riverpod アノテーション）を使う
- コード生成が必要な変更をした場合は `dart run build_runner build --delete-conflicting-outputs` を実行する
- 日本語でコミュニケーションする

## テスト・品質ルール

- **ストーリー完了前に必ずテストを追加・更新すること**
  - 新しいエンティティやロジックを追加した場合 → ユニットテストを追加
  - リポジトリを変更した場合 → インメモリDBテストを追加・更新
  - 既存テストが壊れた場合 → 修正してから完了にする
- `flutter test` が全件パスすること
- `flutter analyze` でエラー0件であること（info レベルも可能な限り解消する）
- テストファイルの配置は実装と同じディレクトリ構造に合わせる:
  - `test/domain/entities/` — エンティティテスト
  - `test/infrastructure/repositories/` — リポジトリテスト
  - `test/core/constants/` — 定数テスト

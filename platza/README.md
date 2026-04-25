# Platza

多肉植物・サボテンをドット絵で育てるお世話管理アプリ（Flutter）

## セットアップ

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Widgetbook（コンポーネントカタログ）

- ローカル起動:
  ```bash
  flutter run -t widgetbook/main.dart -d chrome
  ```
- 公開URL: https://junjun-na.github.io/Platza/
  - main ブランチへの push をトリガーに GitHub Actions で自動デプロイされる
- 設計思想: [docs/design_system.md](../docs/design_system.md)

## コマンド

| 用途 | コマンド |
|---|---|
| コード生成 | `dart run build_runner build --delete-conflicting-outputs` |
| 静的解析 | `flutter analyze` |
| テスト | `flutter test` |
| 実行 | `flutter run` |
| Widgetbook 起動 | `flutter run -t widgetbook/main.dart -d chrome` |

## プロジェクト構成

クリーンアーキテクチャ構成。詳細は [CLAUDE.md](../CLAUDE.md) を参照。

```
platza/lib/
├── main.dart
├── app.dart
├── core/           # 定数、テーマ
├── domain/         # エンティティ、Enum、リポジトリインターフェース
├── infrastructure/ # DB実装、リポジトリ実装
├── application/    # Provider定義
└── presentation/   # 画面、ウィジェット（atoms/molecules/organisms）
```

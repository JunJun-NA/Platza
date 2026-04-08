新しい機能を実装します。以下の手順で進めてください。

1. ユーザーの要件を確認する
2. 必要に応じて Notion の設計ドキュメントを参照する
3. 実装計画を立てる（Plan モードを使用）
4. クリーンアーキテクチャに従って実装する:
   - domain層: エンティティ（freezed）、リポジトリインターフェース
   - infrastructure層: DB テーブル（Drift）、リポジトリ実装
   - application層: Provider
   - presentation層: 画面、ウィジェット
5. コード生成を実行: `cd platza && dart run build_runner build --delete-conflicting-outputs`
6. 静的解析でエラーがないことを確認: `cd platza && flutter analyze`

$ARGUMENTS

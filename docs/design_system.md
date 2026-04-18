# Platza Design System

Platza のコンポーネントは **アトミックデザイン** に基づいて分類されている。
Widgetbook で各コンポーネントのユースケースを確認できる。

## 分類ルール

| レイヤー | 定義 | ディレクトリ |
|---|---|---|
| **Atoms** | 単独で意味を持つ最小UI要素。他コンポーネントに依存しない。 | `lib/presentation/widgets/atoms/` |
| **Molecules** | Atom を 2 つ以上組み合わせて機能単位を作る部品。 | `lib/presentation/widgets/molecules/` |
| **Organisms** | Molecules / Atoms を組み合わせた、独立した UI ブロック。画面固有のロジックや外部依存を持ってよい。 | `lib/presentation/widgets/organisms/` |
| **Templates / Pages** | 画面そのもの。`presentation/<feature>/` に配置。 | `lib/presentation/<feature>/` |

**判断軸**: 「このコンポーネントを壊したとき、影響する別のコンポーネントはあるか？」
- ない → Atom
- 1-2 個ある → Molecule
- 機能単位のブロック全体 → Organism

## 現在のコンポーネント一覧

### Atoms
- `StatusBadge` — 植物のステータス（元気/喉が渇いた 等）を dot / chip / icon の 3 バリアントで表示
- `PixelContainer` — ドット絵表示用コンテナ。small / medium / large / hero のサイズバリアント
- `SectionHeader` — セクション区切りのヘッダー
- `PixelArtWidget` — 種・ステータス・成長段階に応じたドット絵を描画

### Molecules
- `PlatzaCard` — 統一スタイルのカード（タップ可・不可、パディング調整）
- `CareActionButton` — 水やり / 肥料 / 日当たり / 植え替え用のアクションボタン
- `EmptyState` — 空状態表示（絵文字 + タイトル + サブタイトル + 任意のアクション）

### Organisms
- `ShellScaffold` — ボトムナビゲーション付きシェル（GoRouter 連携）
- `CareReactionOverlay` — お世話アクション後のパーティクルアニメーション
- `PhotoViewerDialog` — 写真フルスクリーンビューア

## デザイントークン

全てのコンポーネントはハードコードされた値ではなく、以下のトークンを参照する。

| 種別 | 定義 | 参照元 |
|---|---|---|
| Colors | `AppColors` / `AppPrimitiveColors` | Figma "Semantic Color" / "Primitive Color" |
| Typography | `AppTypography` | Figma Text Styles |
| Spacing | `AppSpacing` | Figma "Spacing" variables |
| Shadows | `AppShadows` | Figma Effect Styles |

Figma ↔ コードの対応は各トークンファイル冒頭のコメントに記載されている。

## 命名規約

- ウィジェット名は **単数形の名詞** を基本とする（`StatusBadge`, `CareActionButton`）
- バリアントは **enum + `variant` パラメータ** で表現する（例: `StatusBadgeVariant`）
- Widgetbook のユースケース名はユーザ視点で命名する（"Default", "With action", "Dot/Chip/Icon" 等）
- 画面固有のウィジェットは機能フォルダ内（例: `presentation/home/widgets/plant_card.dart`）に置き、共通 widgets に昇格させない

## Widgetbook 起動

```bash
cd platza
flutter run -t widgetbook/main.dart
```

Web で動作確認したい場合:
```bash
flutter run -t widgetbook/main.dart -d chrome
```

Widgetbook のユースケースは `widgetbook/use_cases/<layer>/` に配置し、
各ウィジェットに `@UseCase` アノテーションを付ける。追加時は必ず `build_runner` を回す:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 新規コンポーネント追加の流れ

1. 上記「判断軸」で atoms / molecules / organisms のどこに配置するか決める
2. `lib/presentation/widgets/<layer>/<component>.dart` を作成
3. `<layer>/<layer>.dart` barrel に export を追記
4. `widgetbook/use_cases/<layer>/<component>_use_case.dart` にユースケースを追加
5. `dart run build_runner build --delete-conflicting-outputs` で `main.directories.g.dart` を更新
6. ユニット or ゴールデンテストを追加
7. 本ドキュメントの「現在のコンポーネント一覧」に追記

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
- `CareTypeIconContainer` — お世話種別の絵文字を背景色付きで表示する小さなコンテナ
- `PercentageBar` — 比率バー（背景トラック + active 部分の 2 層）

### Molecules
- `PlatzaCard` — 統一スタイルのカード（タップ可・不可、パディング調整）
- `CareActionButton` — 水やり / 肥料 / 日当たり / 植え替え用のアクションボタン
- `EmptyState` — 空状態表示（絵文字 + タイトル + サブタイトル + 任意のアクション）
- `ScheduleStatusBadge` — お世話予定の残り日数を色分けバッジで表示（overdue/today/soon/later）
- `LinkNavigationCard` — icon + title/subtitle + chevron のナビゲーション用カード
- `SelectionTile` — 選択状態を持つ ListTile（選択時はブランド色で強調）
- `StatSummaryCard` — 統計の要約カード（emoji + 値 + ラベル）
- `DayBarChart` — 週間活動数をバーチャートで可視化
- `CareLogEntryRow` — お世話ログ 1 件の行表示（CareTypeIconContainer + ラベル + メモ + 時刻）
- `CareEventCard` — カレンダーのイベントカード（実施済み/予定のステータス付き）

### Organisms
- `ShellScaffold` — ボトムナビゲーション付きシェル（GoRouter 連携）
- `CareReactionOverlay` — お世話アクション後のパーティクルアニメーション
- `PhotoViewerDialog` — 写真フルスクリーンビューア

## デザイントークン

全てのコンポーネントはハードコードされた値ではなく、以下のトークンを参照する。

| 種別 | 定義 | 参照元 |
|---|---|---|
| Colors | `AppColors` / `AppPrimitiveColors` | Figma "Semantic Color" / "Primitive Color" |
| Typography | `AppTypography` | Figma `typography/*` Text Styles |
| Spacing | `AppSpacing` | Figma "Spacing" variables |
| Radius | `AppRadius` | Figma "Radius" variables |
| Shadows | `AppShadows` | Figma Effect Styles |

Figma ↔ コードの対応は各トークンファイル冒頭のコメントに記載されている。

### Typography（単一階層 10 スタイル）

役割ベースで粒度の揃った 10 スタイル。`AppTypography.*` が正準 API で、Material TextTheme には `app_theme.dart` の `_buildTextTheme` 経由でマップ。

| Figma Text Style | Flutter | サイズ / ウェイト | 主な用途 |
|---|---|---|---|
| `typography/display` | `AppTypography.display` | 36 / Bold / ls 4 | スプラッシュ、アプリ名 |
| `typography/title` | `AppTypography.title` | 20 / Bold | 画面タイトル、AppBar |
| `typography/subtitle` | `AppTypography.subtitle` | 16 / Semi Bold | カードタイトル |
| `typography/heading` | `AppTypography.heading` | 14 / Bold | セクション区切り |
| `typography/body` | `AppTypography.body` | 14 / Regular | 本文標準 |
| `typography/bodyLarge` | `AppTypography.bodyLarge` | 16 / Regular | 強調本文 |
| `typography/caption` | `AppTypography.caption` | 12 / Regular | サブタイトル、メタ |
| `typography/label` | `AppTypography.label` | 12 / Medium | ナビ、アクションラベル |
| `typography/button` | `AppTypography.button` | 14 / Medium | ボタン本体テキスト |
| `typography/badge` | `AppTypography.badge` | 11 / Semi Bold | ステータスチップ |

**M3 TextTheme マップ** (`_buildTextTheme` が自動構築): displayLarge ← display / titleLarge ← title / titleMedium ← subtitle / titleSmall ← heading / bodyLarge ← bodyLarge / bodyMedium ← body / bodySmall ← caption / labelLarge ← button / labelMedium ← label / labelSmall ← badge。Material Widget はこれで機能するが、**アプリコードは `AppTypography.*` を直接参照**する。

## Figma コンポーネントリファレンス

Flutter 側のウィジェットと 1:1 対応する叩き台コンポーネントを Figma 上に配置している。
Fill / Stroke / Text color は `Semantic Color` / `Primitive Color` Variables に、
padding / itemSpacing は `Spacing` Variables（FLOAT）に bind 済み。
Typography は `typography/*` Text Styles に bind（`AppTypography.*` と 1:1 対応）。

- ファイル: https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design
- Component ページ: https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=59-6

| レイヤー | コンポーネント | Figma ノード |
|---|---|---|
| Atoms | StatusBadge（variant × status = 12 variants） | [73-34](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=73-34) |
| Atoms | PixelContainer（small / medium / large / hero） | [74-10](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=74-10) |
| Atoms | SectionHeader（default / with-action） | [74-17](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=74-17) |
| Atoms | CareTypeIconContainer（careType × 4） | [130-10](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=130-10) |
| Atoms | PercentageBar | [136-2](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=136-2) |
| Molecules | PlatzaCard（default / tappable） | [75-9](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=75-9) |
| Molecules | CareActionButton（careType × state = 8 variants） | [76-34](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=76-34) |
| Molecules | EmptyState（default / with-action） | [75-22](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=75-22) |
| Molecules | ScheduleStatusBadge（overdue / today / soon / later） | [131-10](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=131-10) |
| Molecules | LinkNavigationCard（with-subtitle / title-only） | [132-13](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=132-13) |
| Molecules | StatSummaryCard | [136-5](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=136-5) |
| Molecules | DayBarChart | [136-9](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=136-9) |
| Molecules | SelectionTile（default / selected） | [136-47](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=136-47) |
| Molecules | CareLogEntryRow | [137-2](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=137-2) |
| Molecules | CareEventCard（performed / scheduled） | [137-22](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=137-22) |
| Organisms | ShellScaffold preview（NavigationBar 3 items） | [76-46](https://www.figma.com/design/B2Nmm9pVpMhRGrK0yj5OYt/UI-Design?node-id=76-46) |

`PixelArtWidget` / `CareReactionOverlay` / `PhotoViewerDialog` は Canvas / ダイアログ依存のため Figma 側のコンポーネント化はスコープ外。

### Component Properties（テキスト差し替え）

以下のコンポーネントは Figma Component Property（TEXT）を公開しており、インスタンス側でテキストを差し替えできる。プロパティ名は Flutter 側の widget パラメータ名と揃えている。

| コンポーネント | Property | 備考 |
|---|---|---|
| SectionHeader | `title`, `actionLabel` | actionLabel は with-action variant のみ |
| PlatzaCard | `title`, `subtitle`, `hintLabel` | hintLabel は tappable variant のみ |
| EmptyState | `emoji`, `title`, `subtitle`, `actionLabel` | actionLabel は with-action variant のみ |
| LinkNavigationCard | `title`, `subtitle` | subtitle は with-subtitle variant のみ |
| StatSummaryCard | `emoji`, `value`, `label` | Flutter の全 String パラメータに対応 |
| SelectionTile | `title`, `subtitle` | state（default/selected）variant とは独立 |
| CareLogEntryRow | `time`, `note` | note は空文字で非表示相当 |
| CareEventCard | `time`, `note` | time は performed variant のみ表示 |

### お世話アクション色（care/\*）

CareActionButton は `icon/care/{water,fertilize,sunlight,repot}`, `border/care/*`, `background/care/*Light` の Semantic Variables を参照する。Flutter 側は `AppColors.care{Water,Fertilize,Sunlight,Repot}` / `*Light` と対応。

**Semantic は必ず Primitive を alias する**（直接 RGB 値は禁止）。fertilize 用には `brown/*` パレット（Material Design Brown, 50〜900 + A100/A200/A400/A700）を Primitive Color に追加済み。`*/care/fertilize` は `brown/400`、`background/care/fertilizeLight` は `brown/50` の alias。

### Brand 系追加 Semantic

- `background/brand`（lightGreen/700 alias） → EmptyState のアクションボタン bg。Flutter は `AppColors.backgroundBrand`
- `border/brandSubtle`（lightGreen/100 alias） → PixelContainer の淡緑ボーダー。Flutter は `AppColors.borderBrandSubtle`

### Radius（角丸）

Figma `Radius` コレクションと `AppRadius` が 1:1 対応（値ベース命名）。

| Figma | Flutter (double) | BorderRadius.all |
|---|---|---|
| `Radius/2` | `AppRadius.r2` | `AppRadius.all2` |
| `Radius/4` | `AppRadius.r4` | `AppRadius.all4` |
| `Radius/6` | `AppRadius.r6` | `AppRadius.all6` |
| `Radius/8` | `AppRadius.r8` | `AppRadius.all8` |
| `Radius/12` | `AppRadius.r12` | `AppRadius.all12` |
| `Radius/16` | `AppRadius.r16` | `AppRadius.all16` |
| `Radius/20` | `AppRadius.r20` | `AppRadius.all20` |
| `Radius/999` | `AppRadius.full` | `AppRadius.allFull` |

旧 `AppSpacing.radiusXl` (24) は廃止し、新スケールの `r20` を採用（PixelContainer hero / SplashScreen ロゴコンテナで −4px の視覚差）。

## Claude 向けルール

Claude Code がデザイン作業（Figma 書き込み / コード側トークン追加）を行うときの必須ルール。

### 色の扱い

1. **Component の色は必ず Semantic Color を参照**する。Primitive や hex 直指定は禁止
2. **Semantic Color は必ず Primitive の `VARIABLE_ALIAS` にする**。直接 RGB を値にしない
3. 意味的に合う Semantic が存在しない場合 → **ユーザーに Semantic 追加を依頼**する。自分で primitive/hex にフォールバックしない
4. Primitive に該当色が存在しない場合 → **先に Primitive にパレットを追加**（既存の 50〜900 + A 系列スタイルに揃える）→ その後 Semantic で alias
5. Flutter `AppColors.*` は Figma Semantic と異名同義で揃える（例: `text/care/water` ↔ `AppColors.careWater`）。`AppColors` は `AppPrimitiveColors.*` への alias として定義する

### Spacing / Layout

- `padding` / `itemSpacing` は Figma `Spacing` Variables（FLOAT, scope=GAP）に bind する
- 数値直指定時は `AppSpacing` と一致する値のみ使用（4xs=2 / 3xs=4 / 2xs=6 / xs=8 / sm=12 / md=16 / lg=20 / xl=24 / 2xl=32 / 3xl=40 / 4xl=48）

### Component Property（Figma）

**必須**: 新規 Figma コンポーネント作成時は、**Flutter widget の `String` / `String?` パラメータを全て TEXT Component Property として公開する**。ハードコードのまま残すのは NG（デザイナーがインスタンスで差し替えできなくなる）。

- Property 名は **Flutter widget のパラメータ名とそのまま一致させる**（`title`, `subtitle`, `emoji`, `label`, `time`, `note`, `actionLabel`, `hintLabel` など）
- variant 固有の Property（例: tappable の `hintLabel`）は該当 variant のテキストノードのみにバインド
- 対象外: enum → label のように code 側で derive しているもの（例: `CareLogEntryRow` の `careType` → ラベルは enum から derive されるので Figma Property 化しない）
- コンポーネント作成直後に `componentPropertyDefinitions` を確認し、Flutter の String パラメータと一致しているかセルフチェックする

### Atomic Design 配置

- `atoms`: 単独で意味を持つ最小要素（他 widget に依存しない）
- `molecules`: atom を組み合わせた機能単位
- `organisms`: 画面固有ロジックや外部依存を持つ UI ブロック
- 判断軸は「壊したとき影響する別 component があるか」（なし→atom / 1-2個→molecule / ブロック全体→organism）

### Figma ↔ コード同期

- 新規 widget を追加 → `widgetbook/use_cases/<layer>/` にユースケース追加 → `dart run build_runner build --delete-conflicting-outputs`
- ゴールデンテストは色が変わったら再生成（`flutter test --update-goldens <path>`）
- Figma Component Property 追加は `addComponentProperty` で 1 プロパティずつ（複合操作は Figma 側でエラーになる場合あり、分割実行推奨）

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

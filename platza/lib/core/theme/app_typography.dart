import 'package:flutter/material.dart';

/// タイポグラフィ定義（Figma `typography/*` Text Styles と 1:1 対応）
///
/// 役割ベースの単一階層 10 スタイル。Material TextTheme の
/// M3 スロットには `app_theme.dart` の `_buildTextTheme` でマップしており、
/// アプリコードは本クラスを正準 API として参照する。
class AppTypography {
  AppTypography._();

  /// スプラッシュ、アプリ名などのブランド表示
  static const TextStyle display = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
  );

  /// 画面タイトル、AppBar タイトル
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// カードタイトル、ダイアログ見出し
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// セクション区切り（SectionHeader）
  static const TextStyle heading = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  /// 本文標準
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// 強調本文、詳細画面の本文
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  /// サブタイトル、タイムスタンプ、メタ情報
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  /// ナビバー、アクションラベル、タグ
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// ボタン本体テキスト
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// ステータスチップ、ミニタグ
  static const TextStyle badge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
}

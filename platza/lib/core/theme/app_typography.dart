import 'package:flutter/material.dart';

/// タイポグラフィ定義
///
/// PixelFont が利用可能な場合はピクセルフォントを適用。
/// フォールバックとして標準フォントを使用。
class AppTypography {
  AppTypography._();

  // PixelFont がアセットに追加されたら 'PixelFont' に変更
  static const String? _pixelFontFamily = null;

  // --- 見出し ---
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _pixelFontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _pixelFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _pixelFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  // --- タイトル ---
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // --- 本文 ---
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // --- ラベル ---
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  // --- アプリ固有 ---

  /// スプラッシュ画面のアプリ名
  static const TextStyle appTitle = TextStyle(
    fontFamily: _pixelFontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
    color: Colors.white,
  );

  /// ナビバーのラベル
  static const TextStyle navLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// ステータスバッジのテキスト
  static const TextStyle badge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  /// お世話アクションボタンのラベル
  static const TextStyle actionLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// セクションヘッダー
  static const TextStyle sectionHeader = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}

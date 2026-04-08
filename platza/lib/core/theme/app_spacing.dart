import 'package:flutter/material.dart';

/// スペーシングシステム（Figma Variables準拠）
///
/// Figma "Spacing" コレクションと 1:1 で対応。
class AppSpacing {
  AppSpacing._();

  // --- 基本スペーシング（Figma Spacing Variables） ---
  static const double xxxs = 2;  // Figma: 4xs
  static const double xxs = 4;   // Figma: 3xs
  static const double xs = 6;    // Figma: 2xs
  static const double sm = 8;    // Figma: xs
  static const double md = 12;   // Figma: sm
  static const double lg = 16;   // Figma: md
  static const double xl = 20;   // Figma: lg
  static const double xxl = 24;  // Figma: xl
  static const double xxxl = 32; // Figma: 2xl
  static const double xxxxl = 40; // Figma: 3xl
  static const double xxxxxl = 48; // Figma: 4xl

  // --- ボーダー半径 ---
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  static const BorderRadius borderRadiusSm =
      BorderRadius.all(Radius.circular(radiusSm));
  static const BorderRadius borderRadiusMd =
      BorderRadius.all(Radius.circular(radiusMd));
  static const BorderRadius borderRadiusLg =
      BorderRadius.all(Radius.circular(radiusLg));
  static const BorderRadius borderRadiusXl =
      BorderRadius.all(Radius.circular(radiusXl));

  // --- ピクセルアート表示エリア ---
  static const double pixelArtSmall = 64;
  static const double pixelArtMedium = 100;
  static const double pixelArtLarge = 200;
  static const double pixelArtHero = 260;

  // --- アクションボタン ---
  static const double actionButtonSize = 64;
  static const double iconSizeSm = 16;
  static const double iconSizeMd = 24;
  static const double iconSizeLg = 32;

  // --- 画面パディング ---
  static const EdgeInsets screenPadding =
      EdgeInsets.all(lg);
  static const EdgeInsets screenPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: lg);

  // --- カード内パディング ---
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingSm = EdgeInsets.all(sm);

  // --- グリッド ---
  static const int gridCrossAxisCount = 2;
  static const double gridCrossAxisSpacing = 12;
  static const double gridMainAxisSpacing = 12;
  static const double gridChildAspectRatio = 0.85;
}

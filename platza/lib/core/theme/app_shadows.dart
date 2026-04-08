import 'package:flutter/material.dart';

/// シャドウ・エレベーション定義
///
/// レトロゲーム風のフラットな見た目を基本としつつ、
/// カードなど浮遊感が必要な要素には控えめなシャドウを適用。
class AppShadows {
  AppShadows._();

  /// カードの標準シャドウ
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// ピクセルアート表示エリアのシャドウ（内側に落とし込む風）
  static List<BoxShadow> pixelArea = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 0,
      offset: const Offset(2, 2),
    ),
  ];

  /// FABなど浮遊要素のシャドウ
  static List<BoxShadow> elevated = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
}

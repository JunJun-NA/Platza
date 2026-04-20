import 'package:flutter/painting.dart';

/// 角丸定義（Figma `Radius` コレクションと 1:1 対応）
///
/// 基本値は Figma の Radius Variables（`2`/`4`/`6`/`8`/`12`/`16`/`20`/`999`）と同一。
/// `BorderRadius.all` のプリセットも `all{n}` として提供。
///
/// 値ベースの命名を採用（`r8`, `all12` 等）。`full` は 999 のピル型。
class AppRadius {
  AppRadius._();

  // --- 基本値（Figma Radius Variables）---
  static const double r2 = 2;
  static const double r4 = 4;
  static const double r6 = 6;
  static const double r8 = 8;
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;

  /// ピル / 完全円形（999）
  static const double full = 999;

  // --- BorderRadius.all プリセット ---
  static const BorderRadius all2 = BorderRadius.all(Radius.circular(r2));
  static const BorderRadius all4 = BorderRadius.all(Radius.circular(r4));
  static const BorderRadius all6 = BorderRadius.all(Radius.circular(r6));
  static const BorderRadius all8 = BorderRadius.all(Radius.circular(r8));
  static const BorderRadius all12 = BorderRadius.all(Radius.circular(r12));
  static const BorderRadius all16 = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius all20 = BorderRadius.all(Radius.circular(r20));
  static const BorderRadius allFull = BorderRadius.all(Radius.circular(full));
}

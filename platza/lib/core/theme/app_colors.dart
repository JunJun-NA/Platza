import 'package:flutter/material.dart';

import 'app_primitive_colors.dart';

/// Figma "Semantic Color" コレクションと 1:1 で対応するカラーシステム
///
/// Primitive Color を参照し、用途に応じたセマンティックな名前を付与。
/// 現在は Lite モードのみ。Dark モード追加時に拡張予定。
class AppColors {
  AppColors._();

  // =========================================
  // Text
  // =========================================
  static const Color textDefault = Color(0xFF171717);       // grey/950
  static const Color textSubtle = AppPrimitiveColors.grey800;
  static const Color textSubtlest = AppPrimitiveColors.grey700;
  static const Color textInverse = Color(0xFFFFFFFF);        // grey/0
  static const Color textDisabled = Color(0xFF757575);       // grey/A400
  static const Color textSelected = AppPrimitiveColors.green700;
  static const Color textBrand = AppPrimitiveColors.lightGreen700;
  static const Color textDanger = AppPrimitiveColors.red800;
  static const Color textWarning = AppPrimitiveColors.deepOrange800;
  static const Color textSuccess = AppPrimitiveColors.lightGreen800;
  static const Color textInformation = AppPrimitiveColors.blue800;
  static const Color textLinkDefault = AppPrimitiveColors.blue700;
  static const Color textLinkVisited = AppPrimitiveColors.purple800;

  // --- Text Accent ---
  static const Color textAccentRed = AppPrimitiveColors.red800;
  static const Color textAccentOrange = AppPrimitiveColors.orange800;
  static const Color textAccentYellow = AppPrimitiveColors.yellow700;
  static const Color textAccentLime = AppPrimitiveColors.lime800;
  static const Color textAccentGreen = AppPrimitiveColors.green800;
  static const Color textAccentTeal = AppPrimitiveColors.teal800;
  static const Color textAccentBlue = AppPrimitiveColors.blue800;
  static const Color textAccentPurple = AppPrimitiveColors.purple800;
  static const Color textAccentPink = AppPrimitiveColors.pink800;
  static const Color textAccentGray = AppPrimitiveColors.grey800;

  // =========================================
  // Icon
  // =========================================
  static const Color iconDefault = Color(0xFF171717);        // grey/950
  static const Color iconSubtle = AppPrimitiveColors.grey800;
  static const Color iconSubtlest = AppPrimitiveColors.grey700;
  static const Color iconInverse = Color(0xFFFFFFFF);        // grey/0
  static const Color iconDisabled = Color(0xFF757575);       // grey/A400
  static const Color iconSelected = AppPrimitiveColors.green700;
  static const Color iconBrand = AppPrimitiveColors.lightGreen700;
  static const Color iconDanger = AppPrimitiveColors.red800;
  static const Color iconWarning = AppPrimitiveColors.deepOrange800;
  static const Color iconSuccess = AppPrimitiveColors.lightGreen800;
  static const Color iconInformation = AppPrimitiveColors.blue800;
  static const Color iconLinkDefault = AppPrimitiveColors.blue700;
  static const Color iconLinkVisited = AppPrimitiveColors.purple800;

  // --- Icon Accent ---
  static const Color iconAccentRed = AppPrimitiveColors.red800;
  static const Color iconAccentOrange = AppPrimitiveColors.orange800;
  static const Color iconAccentYellow = AppPrimitiveColors.yellow700;
  static const Color iconAccentLime = AppPrimitiveColors.lime800;
  static const Color iconAccentGreen = AppPrimitiveColors.green800;
  static const Color iconAccentTeal = AppPrimitiveColors.teal800;
  static const Color iconAccentBlue = AppPrimitiveColors.blue800;
  static const Color iconAccentPurple = AppPrimitiveColors.purple800;
  static const Color iconAccentPink = AppPrimitiveColors.pink800;
  static const Color iconAccentGray = AppPrimitiveColors.grey800;

  // =========================================
  // Border
  // =========================================
  static const Color borderDefault = Color(0xFF757575);      // grey/A200
  static const Color borderBold = AppPrimitiveColors.grey600;
  static const Color borderInverse = Color(0xFFFFFFFF);      // grey/0
  static const Color borderFocused = AppPrimitiveColors.blue600;
  static const Color borderSelected = AppPrimitiveColors.blue800;
  static const Color borderInput = AppPrimitiveColors.lightGreen300;
  static const Color borderBrand = AppPrimitiveColors.lightGreen700;
  static const Color borderBrandSubtle = AppPrimitiveColors.lightGreen100;
  static const Color borderDanger = AppPrimitiveColors.red600;
  static const Color borderWarning = AppPrimitiveColors.deepOrange600;
  static const Color borderSuccess = AppPrimitiveColors.lightGreen600;
  static const Color borderInformation = AppPrimitiveColors.blue600;

  // --- Border Accent ---
  static const Color borderAccentRed = AppPrimitiveColors.red600;
  static const Color borderAccentOrange = AppPrimitiveColors.orange600;
  static const Color borderAccentYellow = AppPrimitiveColors.yellow600;
  static const Color borderAccentLime = AppPrimitiveColors.lime600;
  static const Color borderAccentGreen = AppPrimitiveColors.green600;
  static const Color borderAccentTeal = AppPrimitiveColors.teal600;
  static const Color borderAccentBlue = AppPrimitiveColors.blue600;
  static const Color borderAccentPurple = AppPrimitiveColors.purple600;
  static const Color borderAccentPink = AppPrimitiveColors.pink600;
  static const Color borderAccentGray = AppPrimitiveColors.grey600;

  // =========================================
  // Background
  // =========================================
  static const Color backgroundBase = AppPrimitiveColors.lightGreen50;
  static const Color backgroundBrand = AppPrimitiveColors.lightGreen700;

  // --- Surface ---
  static const Color surfacePrimary = Color(0xFFFFFFFF);     // grey/0
  static const Color surfacePrimaryHover = AppPrimitiveColors.grey50;
  static const Color surfacePrimaryPressed = AppPrimitiveColors.grey100;
  static const Color surfaceSecondary = AppPrimitiveColors.blueGrey50;
  static const Color surfaceSecondaryHover = AppPrimitiveColors.blueGrey100;
  static const Color surfaceSecondaryPressed = AppPrimitiveColors.blueGrey200;
  static const Color surfaceTertiary = AppPrimitiveColors.grey100;
  static const Color surfaceTertiaryHover = AppPrimitiveColors.grey200;
  static const Color surfaceTertiaryPressed = AppPrimitiveColors.grey300;

  // --- Selected ---
  static const Color backgroundSelected = AppPrimitiveColors.green100;
  static const Color backgroundSelectedHover = AppPrimitiveColors.green200;
  static const Color backgroundSelectedPressed = AppPrimitiveColors.green300;
  static const Color backgroundSelectedBold = AppPrimitiveColors.green700;
  static const Color backgroundSelectedBoldHover = AppPrimitiveColors.green800;
  static const Color backgroundSelectedBoldPressed = AppPrimitiveColors.green900;

  // --- Status ---
  static const Color backgroundDanger = AppPrimitiveColors.red800;
  static const Color backgroundDangerLight = AppPrimitiveColors.red100;
  static const Color backgroundWarning = AppPrimitiveColors.deepOrange800;
  static const Color backgroundWarningLight = AppPrimitiveColors.deepOrange100;
  static const Color backgroundSuccess = AppPrimitiveColors.green800;
  static const Color backgroundSuccessLight = AppPrimitiveColors.green100;
  static const Color backgroundInformation = AppPrimitiveColors.blue800;
  static const Color backgroundInformationLight = AppPrimitiveColors.blue100;

  // --- Background Accent ---
  static const Color backgroundAccentRed = AppPrimitiveColors.red100;
  static const Color backgroundAccentOrange = AppPrimitiveColors.orange100;
  static const Color backgroundAccentYellow = AppPrimitiveColors.yellow100;
  static const Color backgroundAccentLime = AppPrimitiveColors.lime100;
  static const Color backgroundAccentGreen = AppPrimitiveColors.green100;
  static const Color backgroundAccentTeal = AppPrimitiveColors.teal100;
  static const Color backgroundAccentBlue = AppPrimitiveColors.blue100;
  static const Color backgroundAccentPurple = AppPrimitiveColors.purple100;
  static const Color backgroundAccentPink = AppPrimitiveColors.pink100;
  static const Color backgroundAccentGray = AppPrimitiveColors.grey100;

  // =========================================
  // 旧互換エイリアス（既存コードとの互換性）
  // =========================================

  // プライマリ
  static const Color primaryGreen = AppPrimitiveColors.lightGreen700;
  static const Color primaryLight = AppPrimitiveColors.lightGreen300;
  static const Color primaryDark = AppPrimitiveColors.lightGreen800;

  // 背景
  static const Color backgroundLight = backgroundBase;
  static const Color surfaceLight = surfacePrimary;

  // テキスト
  static const Color textPrimaryLight = textDefault;
  static const Color textSecondaryLight = textSubtle;
  static const Color textTertiaryLight = textSubtlest;

  // ステータス（植物の状態）
  static const Color statusHappy = AppPrimitiveColors.green400;
  static const Color statusThirsty = AppPrimitiveColors.amber600;
  static const Color statusWilting = AppPrimitiveColors.red400;
  static const Color statusBlooming = AppPrimitiveColors.pink300;
  static const Color statusHappyBg = AppPrimitiveColors.green50;
  static const Color statusThirstyBg = AppPrimitiveColors.amber50;
  static const Color statusWiltingBg = AppPrimitiveColors.red50;
  static const Color statusBloomingBg = AppPrimitiveColors.pink50;

  // お世話アクション（Figma Semantic: text|icon|border/care/* + background/care/*Light）
  static const Color careWater = AppPrimitiveColors.lightBlue500;
  static const Color careFertilize = AppPrimitiveColors.brown400;
  static const Color careSunlight = AppPrimitiveColors.amber400;
  static const Color careRepot = AppPrimitiveColors.deepOrange400;
  static const Color careWaterLight = AppPrimitiveColors.lightBlue50;
  static const Color careFertilizeLight = AppPrimitiveColors.brown50;
  static const Color careSunlightLight = AppPrimitiveColors.amber50;
  static const Color careRepotLight = AppPrimitiveColors.deepOrange50;

  // ドット絵表示エリア
  // bg は backgroundBase, border は borderBrandSubtle を利用（Figma Semantic と一致）

  // セマンティック
  static const Color success = backgroundSuccess;
  static const Color warning = AppPrimitiveColors.orange500;
  static const Color error = backgroundDanger;
  static const Color info = backgroundInformation;

  // ボーダー
  static const Color borderLight = AppPrimitiveColors.grey300;
  static const Color dividerLight = AppPrimitiveColors.grey200;

  // =========================================
  // ダークモード暫定値（Figma Dark未定義）
  // =========================================
  static const Color backgroundDark = Color(0xFF1A2E1A);
  static const Color surfaceDark = Color(0xFF243424);
  static const Color surfaceDimLight = AppPrimitiveColors.lightGreen100;
  static const Color surfaceDimDark = Color(0xFF1E2C1E);
  static const Color textPrimaryDark = Color(0xFFE8F0E0);
  static const Color textSecondaryDark = Color(0xFFA8BCA8);
  static const Color textTertiaryDark = Color(0xFF6B806B);
  static const Color borderDark = Color(0xFF3A4E3A);
  static const Color dividerDark = Color(0xFF2E422E);
  static const Color pixelBackgroundDark = Color(0xFF2A3E2A);
}

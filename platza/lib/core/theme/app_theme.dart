import 'package:flutter/material.dart';
import 'package:platza/core/theme/app_colors.dart';
import 'package:platza/core/theme/app_spacing.dart';
import 'package:platza/core/theme/app_typography.dart';

/// アプリのテーマ定義
///
/// Material 3 ベースに、Platza のレトロゲーム風デザインを統合。
class AppTheme {
  AppTheme._();

  // =========================================
  // ライトテーマ
  // =========================================
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      brightness: Brightness.light,
      surface: AppColors.surfaceLight,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // --- テキストテーマ ---
      textTheme: _buildTextTheme(Brightness.light),

      // --- AppBar ---
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),

      // --- カード ---
      cardTheme: const CardThemeData(
        elevation: 0,
        color: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          side: BorderSide(color: AppColors.borderLight),
        ),
        margin: EdgeInsets.zero,
      ),

      // --- FAB ---
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
      ),

      // --- ナビゲーションバー ---
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primaryGreen.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.navLabel.copyWith(
              color: AppColors.primaryDark,
            );
          }
          return AppTypography.navLabel.copyWith(
            color: AppColors.textTertiaryLight,
          );
        }),
      ),

      // --- 入力フィールド ---
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDimLight,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),

      // --- ボタン ---
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          textStyle: AppTypography.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          side: const BorderSide(color: AppColors.primaryGreen),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),

      // --- ListTile ---
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
      ),

      // --- Divider ---
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),

      // --- Switch ---
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return null;
        }),
      ),

      // --- ProgressIndicator ---
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryGreen,
      ),
    );
  }

  // =========================================
  // ダークテーマ
  // =========================================
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryGreen,
      brightness: Brightness.dark,
      surface: AppColors.surfaceDark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,

      textTheme: _buildTextTheme(Brightness.dark),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),

      cardTheme: const CardThemeData(
        elevation: 0,
        color: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
          side: BorderSide(color: AppColors.borderDark),
        ),
        margin: EdgeInsets.zero,
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusLg,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primaryGreen.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTypography.navLabel.copyWith(
              color: AppColors.primaryLight,
            );
          }
          return AppTypography.navLabel.copyWith(
            color: AppColors.textTertiaryDark,
          );
        }),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDimDark,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: AppTypography.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTypography.labelLarge,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryGreen,
      ),
    );
  }

  // =========================================
  // テキストテーマ
  // =========================================
  static TextTheme _buildTextTheme(Brightness brightness) {
    final Color primary = brightness == Brightness.light
        ? AppColors.textPrimaryLight
        : AppColors.textPrimaryDark;
    final Color secondary = brightness == Brightness.light
        ? AppColors.textSecondaryLight
        : AppColors.textSecondaryDark;

    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: primary),
      displayMedium: AppTypography.displayMedium.copyWith(color: primary),
      displaySmall: AppTypography.displaySmall.copyWith(color: primary),
      titleLarge: AppTypography.titleLarge.copyWith(color: primary),
      titleMedium: AppTypography.titleMedium.copyWith(color: primary),
      titleSmall: AppTypography.titleSmall.copyWith(color: primary),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: primary),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: primary),
      bodySmall: AppTypography.bodySmall.copyWith(color: secondary),
      labelLarge: AppTypography.labelLarge.copyWith(color: primary),
      labelMedium: AppTypography.labelMedium.copyWith(color: secondary),
      labelSmall: AppTypography.labelSmall.copyWith(color: secondary),
    );
  }
}

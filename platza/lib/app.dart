import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/router_provider.dart';
import 'package:platza/application/providers/user_settings_providers.dart';
import 'package:platza/core/theme/app_theme.dart';

/// アプリのルートウィジェット
class PlatzaApp extends ConsumerWidget {
  const PlatzaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final settingsAsync = ref.watch(userSettingsProvider);

    // ユーザー設定からテーマモードを決定
    final themeMode = settingsAsync.whenOrNull(
          data: (settings) =>
              settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        ) ??
        ThemeMode.system;

    return MaterialApp.router(
      title: 'Platza',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      // テーマ切替アニメを無効化する（暫定対処）。
      // iOS で `OutlinedButton.icon` 配下の `AnimatedDefaultTextStyle` が
      // ライト↔ダーク lerp 中に inherit 不整合でクラッシュする問題があり、
      // 切替を瞬時に行うことで lerp パスを通らないようにしている。
      // 恒久対応は `PlatzaOutlinedButton` のコンポーネント化で行う予定。
      themeAnimationDuration: Duration.zero,
      routerConfig: router,
    );
  }
}

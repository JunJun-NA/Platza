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
      routerConfig: router,
    );
  }
}

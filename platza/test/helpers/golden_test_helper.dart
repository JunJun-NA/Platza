import 'package:flutter/material.dart';
import 'package:platza/core/theme/app_theme.dart';

/// ゴールデンテスト用ヘルパー
///
/// ウィジェットをテーマ付き MaterialApp でラップして返す。
Widget buildTestableWidget(
  Widget child, {
  Brightness brightness = Brightness.light,
  Size surfaceSize = const Size(400, 300),
}) {
  final theme =
      brightness == Brightness.light ? AppTheme.light : AppTheme.dark;

  return MaterialApp(
    theme: theme,
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(child: child),
    ),
  );
}

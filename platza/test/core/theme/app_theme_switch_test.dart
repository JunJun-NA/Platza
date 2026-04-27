import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/core/theme/app_theme.dart';

/// テーマ切替時に `OutlinedButton` / `Switch` を含む画面が
/// `TextStyle.lerp` の inherit 不整合でクラッシュしないことを保証する。
///
/// バグ再発防止: 設定画面のダークモードトグルを押すと
/// `Failed to interpolate TextStyles with different inherit values.`
/// で OutlinedButton 配下が落ちていた（dark テーマに outlinedButtonTheme が
/// 無く、ライト側と異なる lerp 経路に乗っていたため）。
void main() {
  testWidgets(
    'light ↔ dark 切替で OutlinedButton / Switch を含む画面がクラッシュしない',
    (tester) async {
      await tester.pumpWidget(const _ThemeHarness());

      // 初期状態: ライトテーマ
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);

      // ライト → ダーク切替
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // ダーク → ライト切替
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );
}

class _ThemeHarness extends StatefulWidget {
  const _ThemeHarness();

  @override
  State<_ThemeHarness> createState() => _ThemeHarnessState();
}

class _ThemeHarnessState extends State<_ThemeHarness> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Column(
          children: [
            Switch(
              value: _isDark,
              onChanged: (v) => setState(() => _isDark = v),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('サインアウト'),
            ),
            const ListTile(title: Text('ListTile')),
          ],
        ),
      ),
    );
  }
}

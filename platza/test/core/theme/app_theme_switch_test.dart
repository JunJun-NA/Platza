import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/core/theme/app_theme.dart';

/// テーマ切替時に `OutlinedButton` / `Switch` を含む画面が
/// `TextStyle.lerp` の inherit 不整合でクラッシュしないことを保証する。
///
/// バグ再発防止: 設定画面のダークモードトグルを押すと
/// `Failed to interpolate TextStyles with different inherit values.`
/// で OutlinedButton 配下が落ちていた。iOS では Typography が
/// `whiteCupertino` / `blackCupertino` を経由するため、`englishLike2021`
/// （inherit:false）と組み合わさったときに `theme.textTheme.labelLarge`
/// が inherit:false になり、テーマ切替アニメ中に lerp 不整合が起こる。
void main() {
  // 各 TargetPlatform で同じ harness を回す。
  // iOS / macOS が Cupertino 系 Typography を使うため再現する。
  for (final platform in <TargetPlatform>[
    TargetPlatform.iOS,
    TargetPlatform.android,
    TargetPlatform.macOS,
  ]) {
    testWidgets(
      'light ↔ dark 切替で OutlinedButton.icon を含む画面がクラッシュしない '
      '(${platform.name})',
      (tester) async {
        debugDefaultTargetPlatformOverride = platform;
        try {
          await tester.pumpWidget(const _ThemeHarness());

          expect(find.byType(OutlinedButton), findsOneWidget);
          expect(find.byType(SwitchListTile), findsOneWidget);

          // ライト → ダーク
          await tester.tap(find.byType(SwitchListTile));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);

          // ダーク → ライト
          await tester.tap(find.byType(SwitchListTile));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        } finally {
          debugDefaultTargetPlatformOverride = null;
        }
      },
    );
  }
}

/// 本番の SettingsScreen + AccountLinkSection の構成を再現するハーネス。
///
/// `SwitchListTile`（ダークモードトグル）と `OutlinedButton.icon`（サインアウト）が
/// 同じ `ListView` 上に同居する状況で、トグルからの themeMode 変化に伴う
/// `AnimatedTheme` lerp を発火させる。
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
        appBar: AppBar(title: const Text('設定')),
        body: ListView(
          children: [
            const ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('user@example.com'),
              subtitle: Text('メール連携'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text('サインアウト'),
                  onPressed: () {},
                ),
              ),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('ダークモード'),
              value: _isDark,
              onChanged: (v) => setState(() => _isDark = v),
            ),
          ],
        ),
      ),
    );
  }
}

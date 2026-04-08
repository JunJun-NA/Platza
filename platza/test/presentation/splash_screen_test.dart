import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/presentation/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// テスト用のGoRouterを作成
GoRouter _createTestRouter() {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home')),
        ),
      ),
    ],
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SplashScreen.sharedPreferencesFactory = null;
  });

  tearDown(() {
    SplashScreen.sharedPreferencesFactory = null;
  });

  group('SplashScreen', () {
    /// ナビゲーションタイマーを完了させてテストを正常終了する
    Future<void> drainTimers(WidgetTester tester) async {
      // SharedPreferences非同期を解決
      await tester.pump();
      await tester.pump();
      // ナビゲーションのFuture.delayedを完了
      await tester.pump(const Duration(seconds: 3));
      // ナビゲーション後のフレーム
      await tester.pump();
    }

    testWidgets('ウィジェットが正常に作成・表示される', (tester) async {
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      expect(find.byType(SplashScreen), findsOneWidget);

      await drainTimers(tester);
    });

    testWidgets('Platzaタイトルが表示される', (tester) async {
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump(const Duration(milliseconds: 800));

      expect(find.text('Platza'), findsOneWidget);

      await drainTimers(tester);
    });

    testWidgets('サブタイトルが表示される', (tester) async {
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump(const Duration(milliseconds: 800));

      expect(find.text('ドット絵で育てる、植物のお世話'), findsOneWidget);

      await drainTimers(tester);
    });

    testWidgets('バージョンテキストが表示される', (tester) async {
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pump(const Duration(milliseconds: 800));

      expect(find.text('v0.1.0'), findsOneWidget);

      await drainTimers(tester);
    });

    testWidgets('初回起動フラグがSharedPreferencesに保存される', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // SharedPreferencesの非同期処理を待つ
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('has_launched_before'), isTrue);

      await drainTimers(tester);
    });

    testWidgets('タイマー完了後にホーム画面へ遷移する', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final router = _createTestRouter();

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      // スプラッシュ画面が表示されている
      expect(find.byType(SplashScreen), findsOneWidget);

      await drainTimers(tester);

      // ホーム画面に遷移済み
      expect(find.text('Home'), findsOneWidget);
    });
  });
}

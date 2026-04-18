import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/presentation/home/home_screen.dart';
import 'package:platza/presentation/plant_detail/plant_detail_screen.dart';
import 'package:platza/presentation/plant_edit/plant_edit_screen.dart';
import 'package:platza/presentation/plant_register/plant_register_screen.dart';
import 'package:platza/presentation/care_calendar/care_calendar_screen.dart';
import 'package:platza/presentation/care_log/care_log_screen.dart';
import 'package:platza/presentation/statistics/statistics_screen.dart';
import 'package:platza/presentation/settings/settings_screen.dart';
import 'package:platza/presentation/debug/pixel_art_gallery_screen.dart';
import 'package:platza/presentation/splash/splash_screen.dart';
import 'package:platza/presentation/widgets/organisms/shell_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouterのプロバイダ
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      // スプラッシュ画面
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      // ナビゲーションバー付きのシェル
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ShellScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.statistics,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StatisticsScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
      // フルスクリーン画面（register / edit は :id より先に定義すること）
      GoRoute(
        path: AppRoutes.plantRegister,
        builder: (context, state) => const PlantRegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.plantEdit,
        builder: (context, state) {
          final plantId = state.pathParameters['id']!;
          return PlantEditScreen(plantId: plantId);
        },
      ),
      GoRoute(
        path: AppRoutes.plantDetail,
        builder: (context, state) {
          final plantId = state.pathParameters['id']!;
          return PlantDetailScreen(plantId: plantId);
        },
      ),
      // デバッグ: ドット絵ギャラリー
      GoRoute(
        path: '/debug/gallery',
        builder: (context, state) => const PixelArtGalleryScreen(),
      ),
      GoRoute(
        path: AppRoutes.careLog,
        builder: (context, state) {
          final plantId = state.pathParameters['id']!;
          return CareLogScreen(plantId: plantId);
        },
      ),
      GoRoute(
        path: AppRoutes.careCalendar,
        builder: (context, state) {
          final plantId = state.pathParameters['id']!;
          return CareCalendarScreen(plantId: plantId);
        },
      ),
    ],
  );
});

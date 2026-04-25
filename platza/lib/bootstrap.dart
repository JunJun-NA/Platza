import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:platza/app.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/core/env/flavor.dart';
import 'package:platza/firebase_options.dart';
import 'package:platza/infrastructure/services/firebase_emulator.dart';
import 'package:platza/infrastructure/services/notification_service.dart';

/// アプリ起動の共通処理。flavor 別エントリポイント (`main_dev.dart` /
/// `main_prod.dart`) からのみ呼び出される。
Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnv.init(flavor);

  // Firebase 初期化。debug ビルド時は Emulator Suite に接続する。
  // 実プロジェクト接続後はここで本番にも接続する想定。
  await Firebase.initializeApp(options: firebaseOptionsForFlavor(flavor));
  if (kDebugMode) {
    await connectToFirebaseEmulators();
  }

  // 日本語ロケールの日付フォーマット初期化（table_calendar で使用）
  await initializeDateFormatting('ja_JP');

  // 通知サービスの初期化（タイムゾーンデータも含む）
  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.requestPermissions();

  runApp(
    ProviderScope(
      overrides: [
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const PlatzaApp(),
    ),
  );
}

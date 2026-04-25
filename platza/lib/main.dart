import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:platza/app.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/firebase_options.dart';
import 'package:platza/infrastructure/services/firebase_emulator.dart';
import 'package:platza/infrastructure/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 初期化。debug ビルド時は Emulator Suite に接続する。
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        // 初期化済みのNotificationServiceをProviderに注入
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const PlatzaApp(),
    ),
  );
}

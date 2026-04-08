import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/app.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/infrastructure/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

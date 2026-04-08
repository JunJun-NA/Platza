import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:platza/domain/entities/care_schedule.dart';
import 'package:platza/domain/entities/plant.dart';

/// ローカル通知を管理するサービス
class NotificationService {
  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// 通知プラグインの初期化
  Future<void> initialize() async {
    if (_initialized) return;

    // タイムゾーンデータの初期化
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(_resolveLocalTimezone()));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings: initSettings);
    _initialized = true;
  }

  /// ローカルタイムゾーン名を解決する
  String _resolveLocalTimezone() {
    try {
      final now = DateTime.now();
      final offset = now.timeZoneOffset;
      // よく使われるタイムゾーンのマッピング
      if (offset.inHours == 9) return 'Asia/Tokyo';
      if (offset.inHours == 0) return 'UTC';
      // フォールバック
      return 'UTC';
    } catch (e) {
      return 'UTC';
    }
  }

  /// iOS の通知権限をリクエストする
  Future<bool> requestPermissions() async {
    try {
      // iOS 権限リクエスト
      final iosPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      if (iosPlugin != null) {
        final granted = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }

      // Android 13+ 権限リクエスト
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        final granted =
            await androidPlugin.requestNotificationsPermission();
        return granted ?? false;
      }

      return true;
    } catch (e) {
      debugPrint('通知権限リクエストエラー: $e');
      return false;
    }
  }

  /// 指定日時に通知をスケジュールする
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    try {
      final scheduledTz = tz.TZDateTime.from(scheduledDate, tz.local);

      // 過去の日時はスキップ
      if (scheduledTz.isBefore(tz.TZDateTime.now(tz.local))) {
        return;
      }

      const androidDetails = AndroidNotificationDetails(
        'platza_care_reminders',
        'お世話リマインダー',
        channelDescription: '植物のお世話リマインダー通知',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledTz,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint('通知スケジュールエラー: $e');
    }
  }

  /// 通知をキャンセルする
  Future<void> cancelNotification(int id) async {
    try {
      await _plugin.cancel(id: id);
    } catch (e) {
      debugPrint('通知キャンセルエラー: $e');
    }
  }

  /// 全通知をキャンセルする
  Future<void> cancelAllNotifications() async {
    try {
      await _plugin.cancelAll();
    } catch (e) {
      debugPrint('全通知キャンセルエラー: $e');
    }
  }

  /// 全お世話スケジュールに対して通知をスケジュールする
  ///
  /// [schedules] 通知対象のスケジュール一覧
  /// [plants] plantId -> Plant のマップ
  /// [reminderHour] リマインダー時刻（時）
  /// [reminderMinute] リマインダー時刻（分）
  Future<void> scheduleCareReminders(
    List<CareSchedule> schedules,
    Map<String, Plant> plants, {
    int reminderHour = 8,
    int reminderMinute = 0,
  }) async {
    // 既存の通知を全てクリアして再スケジュール
    await cancelAllNotifications();

    for (final schedule in schedules) {
      if (!schedule.isEnabled) continue;

      final plant = plants[schedule.plantId];
      if (plant == null) continue;

      final notificationId = generateNotificationId(
        schedule.plantId,
        schedule.careType.name,
      );

      // スケジュールの日付にリマインダー時刻を設定
      final scheduledDate = DateTime(
        schedule.nextDueDate.year,
        schedule.nextDueDate.month,
        schedule.nextDueDate.day,
        reminderHour,
        reminderMinute,
      );

      final title = '${schedule.careType.emoji} ${schedule.careType.label}の時間です';
      final body = '${plant.nickname}の${schedule.careType.label}をしましょう！';

      await scheduleNotification(
        id: notificationId,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
      );
    }
  }

  /// plantId と careType から通知IDを生成する
  static int generateNotificationId(String plantId, String careType) {
    final combined = '$plantId:$careType';
    // hashCode は int を返すが、通知IDとして安全な範囲に収める
    return combined.hashCode.abs() % 100000;
  }
}

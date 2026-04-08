import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/infrastructure/services/notification_service.dart';

/// NotificationService のシングルトンProvider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// 全お世話スケジュールの通知をスケジュールする
///
/// 設定画面でONにした時や、アプリ起動時に呼び出す
Future<void> scheduleAllCareNotifications(Ref ref) async {
  try {
    final notificationService = ref.read(notificationServiceProvider);
    final settingsRepo = ref.read(userSettingsRepositoryProvider);
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final plantRepo = ref.read(plantRepositoryProvider);

    // 現在の設定を取得
    final settings = await settingsRepo.watchSettings().first;
    if (!settings.notificationEnabled) return;

    // 期限が来ているスケジュールと全植物を取得
    final dueSchedules = await scheduleRepo.getDueSchedules();
    final allPlants = await plantRepo.getAllPlants();

    // Plant を Map に変換
    final plantMap = <String, Plant>{};
    for (final plant in allPlants) {
      plantMap[plant.id] = plant;
    }

    // 通知をスケジュール
    await notificationService.scheduleCareReminders(
      dueSchedules,
      plantMap,
      reminderHour: settings.waterReminderHour,
      reminderMinute: settings.waterReminderMinute,
    );
  } catch (e) {
    // 通知スケジュールの失敗はアプリに致命的ではないので無視
  }
}

/// WidgetRef から全お世話スケジュールの通知をスケジュールする
///
/// 設定画面などConsumerWidget内から呼び出す
Future<void> scheduleAllCareNotificationsFromWidget(WidgetRef ref) async {
  try {
    final notificationService = ref.read(notificationServiceProvider);
    final settingsRepo = ref.read(userSettingsRepositoryProvider);
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final plantRepo = ref.read(plantRepositoryProvider);

    final settings = await settingsRepo.watchSettings().first;
    if (!settings.notificationEnabled) return;

    final dueSchedules = await scheduleRepo.getDueSchedules();
    final allPlants = await plantRepo.getAllPlants();

    final plantMap = <String, Plant>{};
    for (final plant in allPlants) {
      plantMap[plant.id] = plant;
    }

    await notificationService.scheduleCareReminders(
      dueSchedules,
      plantMap,
      reminderHour: settings.waterReminderHour,
      reminderMinute: settings.waterReminderMinute,
    );
  } catch (e) {
    // 通知スケジュールの失敗はアプリに致命的ではないので無視
  }
}

/// 特定の植物・お世話タイプの通知を再スケジュールする
///
/// お世話実行後にnextDueDateを更新した後に呼び出す
Future<void> rescheduleNotificationForCare(
  Ref ref, {
  required CareSchedule schedule,
  required Plant plant,
}) async {
  try {
    final notificationService = ref.read(notificationServiceProvider);
    final settingsRepo = ref.read(userSettingsRepositoryProvider);

    final settings = await settingsRepo.watchSettings().first;
    if (!settings.notificationEnabled) return;

    final notificationId = NotificationService.generateNotificationId(
      schedule.plantId,
      schedule.careType.name,
    );

    // 古い通知をキャンセルして新しい通知をスケジュール
    await notificationService.cancelNotification(notificationId);

    final scheduledDate = DateTime(
      schedule.nextDueDate.year,
      schedule.nextDueDate.month,
      schedule.nextDueDate.day,
      settings.waterReminderHour,
      settings.waterReminderMinute,
    );

    final title = '${schedule.careType.emoji} ${schedule.careType.label}の時間です';
    final body = '${plant.nickname}の${schedule.careType.label}をしましょう！';

    await notificationService.scheduleNotification(
      id: notificationId,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
    );
  } catch (e) {
    // 通知スケジュールの失敗はアプリに致命的ではないので無視
  }
}

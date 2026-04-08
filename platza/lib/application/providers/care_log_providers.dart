import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/infrastructure/services/notification_service.dart';
import 'package:uuid/uuid.dart';

/// 特定の植物のお世話ログをリアルタイム監視するProvider
final careLogsForPlantProvider =
    StreamProvider.family<List<CareLog>, String>((ref, plantId) {
  final repo = ref.watch(careLogRepositoryProvider);
  return repo.watchLogsForPlant(plantId);
});

/// お世話ログを追加し、植物の状態を更新するユーティリティ
///
/// [plantId] 対象の植物ID
/// [careType] お世話の種類
/// [note] メモ（任意）
Future<void> addCareLog(
  WidgetRef ref, {
  required String plantId,
  required CareType careType,
  String? note,
}) async {
  final careLogRepo = ref.read(careLogRepositoryProvider);
  final plantRepo = ref.read(plantRepositoryProvider);

  final now = DateTime.now();

  // お世話ログを追加
  final log = CareLog(
    id: const Uuid().v4(),
    plantId: plantId,
    careType: careType,
    performedAt: now,
    note: note,
  );
  await careLogRepo.addLog(log);

  // 植物の状態を更新
  final plant = await plantRepo.getPlantById(plantId);
  if (plant == null) return;

  Plant updated;
  switch (careType) {
    case CareType.water:
      updated = plant.copyWith(
        lastWatered: now,
        status: PlantStatus.happy,
      );
    case CareType.fertilize:
      updated = plant.copyWith(lastFertilized: now);
    case CareType.repot:
      updated = plant.copyWith(lastRepotted: now);
    case CareType.sunlight:
      // 日当たり変更はステータスのみ更新
      updated = plant.copyWith(status: PlantStatus.happy);
  }
  await plantRepo.updatePlant(updated);

  // お世話スケジュールの nextDueDate を更新し、通知を再スケジュール
  try {
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final schedules = await scheduleRepo.getSchedulesForPlant(plantId);
    final matchingSchedule = schedules
        .where((s) => s.careType == careType && s.isEnabled)
        .toList();

    if (matchingSchedule.isNotEmpty) {
      final schedule = matchingSchedule.first;
      final newNextDueDate = now.add(Duration(days: schedule.intervalDays));
      final updatedSchedule = schedule.copyWith(nextDueDate: newNextDueDate);
      await scheduleRepo.updateSchedule(updatedSchedule);

      // 通知を再スケジュール
      final notificationService = ref.read(notificationServiceProvider);
      final settingsRepo = ref.read(userSettingsRepositoryProvider);
      final settings = await settingsRepo.watchSettings().first;

      if (settings.notificationEnabled) {
        final notificationId = NotificationService.generateNotificationId(
          plantId,
          careType.name,
        );
        await notificationService.cancelNotification(notificationId);

        final scheduledDate = DateTime(
          newNextDueDate.year,
          newNextDueDate.month,
          newNextDueDate.day,
          settings.waterReminderHour,
          settings.waterReminderMinute,
        );
        final title = '${careType.emoji} ${careType.label}の時間です';
        final body = '${updated.nickname}の${careType.label}をしましょう！';

        await notificationService.scheduleNotification(
          id: notificationId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
        );
      }
    }
  } catch (e) {
    debugPrint('通知再スケジュールエラー: $e');
  }
}

/// お世話ログを編集し、関連データを再計算するユーティリティ
Future<void> editCareLog(
  WidgetRef ref, {
  required CareLog updatedLog,
}) async {
  final careLogRepo = ref.read(careLogRepositoryProvider);
  await careLogRepo.updateLog(updatedLog);

  await _recalculatePlantState(ref, updatedLog.plantId, updatedLog.careType);
}

/// お世話ログを削除し、関連データを再計算するユーティリティ
Future<void> deleteCareLog(
  WidgetRef ref, {
  required CareLog log,
}) async {
  final careLogRepo = ref.read(careLogRepositoryProvider);
  await careLogRepo.deleteLog(log.id);

  await _recalculatePlantState(ref, log.plantId, log.careType);
}

/// ログ変更後にPlantの日付とスケジュール・通知を再計算する共通処理
Future<void> _recalculatePlantState(
  WidgetRef ref,
  String plantId,
  CareType careType,
) async {
  final careLogRepo = ref.read(careLogRepositoryProvider);
  final plantRepo = ref.read(plantRepositoryProvider);

  final plant = await plantRepo.getPlantById(plantId);
  if (plant == null) return;

  // 該当ケアタイプの最新ログから日付を再算出
  final logs = await careLogRepo.getLogsByType(plantId, careType);
  final latestDate = logs.isNotEmpty ? logs.first.performedAt : null;

  Plant updated;
  switch (careType) {
    case CareType.water:
      updated = plant.copyWith(lastWatered: latestDate);
    case CareType.fertilize:
      updated = plant.copyWith(lastFertilized: latestDate);
    case CareType.repot:
      updated = plant.copyWith(lastRepotted: latestDate);
    case CareType.sunlight:
      updated = plant;
  }
  await plantRepo.updatePlant(updated);

  // スケジュールと通知を再計算
  try {
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final schedules = await scheduleRepo.getSchedulesForPlant(plantId);
    final matchingSchedule = schedules
        .where((s) => s.careType == careType && s.isEnabled)
        .toList();

    if (matchingSchedule.isNotEmpty) {
      final schedule = matchingSchedule.first;
      final baseDate = latestDate ?? DateTime.now();
      final newNextDueDate = baseDate.add(Duration(days: schedule.intervalDays));
      final updatedSchedule = schedule.copyWith(nextDueDate: newNextDueDate);
      await scheduleRepo.updateSchedule(updatedSchedule);

      final notificationService = ref.read(notificationServiceProvider);
      final settingsRepo = ref.read(userSettingsRepositoryProvider);
      final settings = await settingsRepo.watchSettings().first;

      final notificationId = NotificationService.generateNotificationId(
        plantId,
        careType.name,
      );
      await notificationService.cancelNotification(notificationId);

      if (settings.notificationEnabled && latestDate != null) {
        final scheduledDate = DateTime(
          newNextDueDate.year,
          newNextDueDate.month,
          newNextDueDate.day,
          settings.waterReminderHour,
          settings.waterReminderMinute,
        );
        final title = '${careType.emoji} ${careType.label}の時間です';
        final body = '${updated.nickname}の${careType.label}をしましょう！';

        await notificationService.scheduleNotification(
          id: notificationId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
        );
      }
    }
  } catch (e) {
    debugPrint('再計算エラー: $e');
  }
}

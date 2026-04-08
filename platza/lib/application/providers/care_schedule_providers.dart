import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/domain/entities/entities.dart';

/// 特定の植物のお世話スケジュールを取得するProvider
final careSchedulesForPlantProvider =
    FutureProvider.family<List<CareSchedule>, String>((ref, plantId) async {
  final repo = ref.watch(careScheduleRepositoryProvider);
  return repo.getSchedulesForPlant(plantId);
});

/// 期限が来ているスケジュールを取得するProvider
final dueSchedulesProvider = FutureProvider<List<CareSchedule>>((ref) async {
  final repo = ref.watch(careScheduleRepositoryProvider);
  return repo.getDueSchedules();
});

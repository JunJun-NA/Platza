import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/application/services/statistics_utils.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';

/// 直近30日分の全お世話ログを取得するProvider
final allCareLogsProvider = FutureProvider<List<CareLog>>((ref) async {
  final repo = ref.watch(careLogRepositoryProvider);
  final now = DateTime.now();
  final thirtyDaysAgo = now.subtract(const Duration(days: 30));
  return repo.getLogsByDateRange(thirtyDaysAgo, now);
});

/// 統計サマリーデータ
class StatisticsSummary {
  const StatisticsSummary({
    required this.totalPlants,
    required this.bestStreak,
    required this.monthlyCareCount,
    required this.weeklyCareCount,
    required this.careTypeBreakdown,
    required this.dailyActivity,
    required this.perPlantStats,
  });

  final int totalPlants;
  final int bestStreak;
  final int monthlyCareCount;
  final int weeklyCareCount;
  final Map<CareType, int> careTypeBreakdown;
  final List<int> dailyActivity;
  final List<PlantStats> perPlantStats;
}

/// 植物ごとの統計
class PlantStats {
  const PlantStats({
    required this.plant,
    required this.careCount,
  });

  final Plant plant;
  final int careCount;
}

/// 統計サマリーを組み立てるProvider
final statisticsSummaryProvider =
    FutureProvider<StatisticsSummary>((ref) async {
  final plants = await ref.watch(plantsProvider.future);
  final logs = await ref.watch(allCareLogsProvider.future);

  // 植物ごとのお世話回数を集計
  final plantCareMap = <String, int>{};
  for (final log in logs) {
    plantCareMap[log.plantId] = (plantCareMap[log.plantId] ?? 0) + 1;
  }

  final perPlantStats = plants.map((plant) {
    return PlantStats(
      plant: plant,
      careCount: plantCareMap[plant.id] ?? 0,
    );
  }).toList()
    ..sort((a, b) => b.careCount.compareTo(a.careCount));

  return StatisticsSummary(
    totalPlants: plants.length,
    bestStreak: StatisticsUtils.calculateBestStreak(plants),
    monthlyCareCount: StatisticsUtils.calculateMonthlyCareCount(logs),
    weeklyCareCount: StatisticsUtils.calculateWeeklyCareCount(logs),
    careTypeBreakdown: StatisticsUtils.calculateCareTypeBreakdown(logs),
    dailyActivity: StatisticsUtils.calculateDailyActivity(logs, 7),
    perPlantStats: perPlantStats,
  );
});

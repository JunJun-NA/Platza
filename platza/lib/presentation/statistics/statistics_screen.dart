import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/statistics_providers.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// 統計画面 - お世話の統計・ストリーク表示
class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(statisticsSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('統計'),
      ),
      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          emoji: '😢',
          title: 'データを読み込めませんでした',
          subtitle: error.toString(),
        ),
        data: (summary) {
          if (summary.totalPlants == 0) {
            return const EmptyState(
              emoji: '📊',
              title: 'まだ植物が登録されていません',
              subtitle: '植物を登録すると統計が表示されます',
            );
          }
          return ListView(
            padding: AppSpacing.screenPadding,
            children: [
              _SummaryCards(summary: summary),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: '今週のお世話'),
              DayBarChart(dailyActivity: summary.dailyActivity),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: 'ケア種別の内訳'),
              _CareTypeBreakdown(breakdown: summary.careTypeBreakdown),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(title: '植物別のお世話頻度'),
              _PerPlantList(perPlantStats: summary.perPlantStats),
            ],
          );
        },
      ),
    );
  }
}

/// 概要カード（3つ横並び）
class _SummaryCards extends StatelessWidget {
  const _SummaryCards({required this.summary});

  final StatisticsSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatSummaryCard(
            emoji: '🌿',
            label: '植物数',
            value: '${summary.totalPlants}',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatSummaryCard(
            emoji: '🔥',
            label: '最長連続',
            value: '${summary.bestStreak}日',
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: StatSummaryCard(
            emoji: '✅',
            label: '今月のお世話',
            value: '${summary.monthlyCareCount}回',
          ),
        ),
      ],
    );
  }
}

/// ケア種別の内訳
class _CareTypeBreakdown extends StatelessWidget {
  const _CareTypeBreakdown({required this.breakdown});

  final Map<CareType, int> breakdown;

  Color _colorForType(CareType type) {
    return switch (type) {
      CareType.water => AppColors.careWater,
      CareType.fertilize => AppColors.careFertilize,
      CareType.repot => AppColors.careRepot,
      CareType.sunlight => AppColors.careSunlight,
    };
  }

  Color _bgColorForType(CareType type) {
    return switch (type) {
      CareType.water => AppColors.careWaterLight,
      CareType.fertilize => AppColors.careFertilizeLight,
      CareType.repot => AppColors.careRepotLight,
      CareType.sunlight => AppColors.careSunlightLight,
    };
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = breakdown.values.fold(0, (a, b) => a + b);
    final effectiveTotal = totalCount == 0 ? 1 : totalCount;

    return PlatzaCard(
      child: Column(
        children: CareType.values.map((type) {
          final count = breakdown[type] ?? 0;
          final ratio = count / effectiveTotal;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    '${type.emoji} ${type.label}',
                    style: AppTypography.caption,
                  ),
                ),
                Expanded(
                  child: PercentageBar(
                    ratio: ratio,
                    activeColor: _colorForType(type),
                    trackColor: _bgColorForType(type),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  width: 36,
                  child: Text(
                    '$count回',
                    style: AppTypography.label.copyWith(
                      color: AppColors.textSubtle,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 植物別のお世話頻度
class _PerPlantList extends StatelessWidget {
  const _PerPlantList({required this.perPlantStats});

  final List<PlantStats> perPlantStats;

  @override
  Widget build(BuildContext context) {
    if (perPlantStats.isEmpty) {
      return const PlatzaCard(
        child: Center(
          child: Text(
            'お世話データがありません',
            style: AppTypography.caption,
          ),
        ),
      );
    }

    return PlatzaCard(
      child: Column(
        children: perPlantStats.map((stats) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stats.plant.nickname,
                        style: AppTypography.heading,
                      ),
                      const SizedBox(height: AppSpacing.xxxs),
                      Text(
                        'お世話 ${stats.careCount}回 / 連続 ${stats.plant.streakDays}日',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSubtlest,
                        ),
                      ),
                    ],
                  ),
                ),
                if (stats.plant.streakDays > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundAccentOrange,
                      borderRadius: AppRadius.all8,
                    ),
                    child: Text(
                      '🔥 ${stats.plant.streakDays}',
                      style: AppTypography.label,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

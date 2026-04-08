import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/care_log_providers.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// お世話ログ画面 - 日付ごとにグループ化してお世話履歴を表示
class CareLogScreen extends ConsumerWidget {
  final String plantId;

  const CareLogScreen({super.key, required this.plantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(careLogsForPlantProvider(plantId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('お世話ログ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return const EmptyState(
              emoji: '📅',
              title: 'まだお世話ログがありません',
              subtitle: '植物のお世話をすると、ここに履歴が表示されます',
            );
          }
          return _buildLogList(context, logs);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  /// ログを日付ごとにグループ化して表示
  Widget _buildLogList(BuildContext context, List<CareLog> logs) {
    // 日付でグループ化
    final grouped = <String, List<CareLog>>{};
    for (final log in logs) {
      final dateKey = _formatDate(log.performedAt);
      grouped.putIfAbsent(dateKey, () => []).add(log);
    }

    final dateKeys = grouped.keys.toList();

    return ListView.builder(
      padding: AppSpacing.screenPadding,
      itemCount: dateKeys.length,
      itemBuilder: (context, index) {
        final dateKey = dateKeys[index];
        final dateLogs = grouped[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) const SizedBox(height: AppSpacing.lg),
            // 日付ヘッダー
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                dateKey,
                style: AppTypography.sectionHeader.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            // その日のログ一覧
            ...dateLogs.map((log) => _buildLogEntry(context, log)),
          ],
        );
      },
    );
  }

  Widget _buildLogEntry(BuildContext context, CareLog log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: PlatzaCard(
        child: Row(
          children: [
            // お世話種類のアイコン
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _careTypeColor(log.careType).withValues(alpha: 0.15),
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Center(
                child: Text(
                  log.careType.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // ログ情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log.careType.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  if (log.note != null && log.note!.isNotEmpty)
                    Text(
                      log.note!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            // 時刻
            Text(
              _formatTime(log.performedAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Color _careTypeColor(CareType careType) {
    return switch (careType) {
      CareType.water => AppColors.waterBlue,
      CareType.fertilize => AppColors.fertilizerBrown,
      CareType.sunlight => AppColors.sunlightYellow,
      CareType.repot => AppColors.repotOrange,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

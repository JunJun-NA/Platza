import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/care_log_providers.dart';
import 'package:platza/application/providers/care_schedule_providers.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
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
          return _buildLogList(context, ref, logs);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  /// ログを日付ごとにグループ化して表示
  Widget _buildLogList(
      BuildContext context, WidgetRef ref, List<CareLog> logs) {
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
                style: AppTypography.heading.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            // その日のログ一覧
            ...dateLogs
                .map((log) => _buildLogEntry(context, ref, log)),
          ],
        );
      },
    );
  }

  Widget _buildLogEntry(BuildContext context, WidgetRef ref, CareLog log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: CareLogEntryRow(
        careType: log.careType,
        time: _formatTime(log.performedAt),
        note: log.note,
        onTap: () => _showEditSheet(context, ref, log),
      ),
    );
  }

  /// 編集ボトムシートを表示
  void _showEditSheet(BuildContext context, WidgetRef ref, CareLog log) {
    final noteController = TextEditingController(text: log.note ?? '');
    var selectedDate = log.performedAt;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (builderContext, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom:
                    MediaQuery.of(builderContext).viewInsets.bottom + AppSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ヘッダー
                  Row(
                    children: [
                      Text(
                        log.careType.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${log.careType.label}を編集',
                        style: Theme.of(builderContext).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(builderContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // 日時選択
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('実施日時'),
                    subtitle: Text(
                      '${_formatDate(selectedDate)} ${_formatTime(selectedDate)}',
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: builderContext,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date == null) return;

                      if (!builderContext.mounted) return;
                      final time = await showTimePicker(
                        context: builderContext,
                        initialTime: TimeOfDay.fromDateTime(selectedDate),
                      );
                      if (time == null) return;

                      setState(() {
                        selectedDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // メモ入力
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'メモ',
                      hintText: 'メモを入力（任意）',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ボタン群
                  Row(
                    children: [
                      // 削除ボタン
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(builderContext);
                          _showDeleteConfirmation(context, ref, log);
                        },
                        icon: const Icon(Icons.delete_outline),
                        label: const Text('削除'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(builderContext).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(builderContext).colorScheme.error,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // 保存ボタン
                      FilledButton(
                        onPressed: () async {
                          final updatedLog = log.copyWith(
                            performedAt: selectedDate,
                            note: noteController.text.isEmpty
                                ? null
                                : noteController.text,
                          );
                          await editCareLog(ref, updatedLog: updatedLog);

                          if (!builderContext.mounted) return;
                          Navigator.pop(builderContext);

                          if (!context.mounted) return;
                          _invalidateProviders(ref);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('ログを更新しました')),
                          );
                        },
                        child: const Text('保存'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// 削除確認ダイアログ
  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, CareLog log) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('ログを削除'),
          content: Text(
            '${_formatDate(log.performedAt)} の${log.careType.label}のログを削除しますか？\nこの操作は取り消せません。',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('キャンセル'),
            ),
            FilledButton(
              onPressed: () async {
                await deleteCareLog(ref, log: log);

                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);

                if (!context.mounted) return;
                _invalidateProviders(ref);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ログを削除しました')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(dialogContext).colorScheme.error,
              ),
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }

  void _invalidateProviders(WidgetRef ref) {
    ref.invalidate(plantByIdProvider(plantId));
    ref.invalidate(careSchedulesForPlantProvider(plantId));
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

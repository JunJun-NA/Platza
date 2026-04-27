import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/care_schedule_providers.dart';
import 'package:platza/application/services/care_schedule_utils.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/application/providers/notification_providers.dart';
import 'package:platza/infrastructure/services/notification_service.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// 植物編集画面 - ニックネームと置き場所を変更、削除も可能
class PlantEditScreen extends ConsumerStatefulWidget {
  final String plantId;

  const PlantEditScreen({super.key, required this.plantId});

  @override
  ConsumerState<PlantEditScreen> createState() => _PlantEditScreenState();
}

class _PlantEditScreenState extends ConsumerState<PlantEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  PlantLocation _selectedLocation = PlantLocation.indoor;
  int? _waterIntervalDays;
  int? _fertilizeIntervalDays;
  int? _repotIntervalDays;
  bool _isLoaded = false;
  bool _isSaving = false;
  bool _isDeleting = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _initFromPlant(Plant plant) {
    if (!_isLoaded) {
      _nicknameController.text = plant.nickname;
      _selectedLocation = plant.location;
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final plantAsync = ref.watch(plantByIdProvider(widget.plantId));

    return plantAsync.when(
      data: (plant) {
        if (plant == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
            body: const Center(child: Text('植物が見つかりません')),
          );
        }

        _initFromPlant(plant);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: const Text('植物を編集'),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: _isSaving ? null : () => _savePlant(plant),
              ),
            ],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ニックネーム入力
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(
                      labelText: 'ニックネーム',
                      hintText: '例: うちのエケちゃん',
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'ニックネームを入力してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // 置き場所選択
                  Text(
                    '置き場所',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...PlantLocation.values.map((location) {
                    return _buildLocationTile(location);
                  }),
                  const SizedBox(height: AppSpacing.xxl),
                  // お世話の間隔セクション
                  _buildCareIntervalSection(context, plant),
                  const SizedBox(height: AppSpacing.xxl),
                  // 削除ボタン
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: (_isDeleting || _isSaving)
                          ? null
                          : () => _showDeleteConfirmation(plant),
                      icon: _isDeleting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.delete_outline),
                      label: Text(_isDeleting ? '削除中…' : 'この植物を削除'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textDanger,
                        side: const BorderSide(color: AppColors.borderDanger),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('植物を編集'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('植物を編集'),
        ),
        body: Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  Widget _buildCareIntervalSection(BuildContext context, Plant plant) {
    final species = PlantSpeciesData.getById(plant.speciesId);
    final schedulesAsync = ref.watch(
      careSchedulesForPlantProvider(widget.plantId),
    );

    return schedulesAsync.when(
      data: (schedules) {
        // 水やりスケジュールを探す
        final waterSchedule = schedules
            .where((s) => s.careType == CareType.water && s.isEnabled)
            .toList();
        final fertilizeSchedule = schedules
            .where((s) => s.careType == CareType.fertilize && s.isEnabled)
            .toList();
        final repotSchedule = schedules
            .where((s) => s.careType == CareType.repot && s.isEnabled)
            .toList();

        // 初期値をセット（まだセットされていない場合のみ）
        _waterIntervalDays ??=
            waterSchedule.isNotEmpty ? waterSchedule.first.intervalDays : null;
        _fertilizeIntervalDays ??= fertilizeSchedule.isNotEmpty
            ? fertilizeSchedule.first.intervalDays
            : null;
        _repotIntervalDays ??= repotSchedule.isNotEmpty
            ? repotSchedule.first.intervalDays
            : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'お世話の間隔',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_waterIntervalDays != null)
              _buildIntervalSlider(
                context,
                emoji: '💧',
                label: '水やり',
                value: _waterIntervalDays!,
                min: 1,
                max: 60,
                recommendedDays: species.waterFrequencyDays,
                onChanged: (value) {
                  setState(() => _waterIntervalDays = value);
                },
              ),
            if (_fertilizeIntervalDays != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildIntervalSlider(
                context,
                emoji: '🌱',
                label: '肥料',
                value: _fertilizeIntervalDays!,
                min: 1,
                max: 90,
                recommendedDays: species.fertilizerFrequencyDays,
                onChanged: (value) {
                  setState(() => _fertilizeIntervalDays = value);
                },
              ),
            ],
            if (_repotIntervalDays != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildIntervalSlider(
                context,
                emoji: '🪴',
                label: '植え替え',
                value: _repotIntervalDays!,
                min: 30,
                max: 1095,
                recommendedDays: species.repotFrequencyDays,
                onChanged: (value) {
                  setState(() => _repotIntervalDays = value);
                },
              ),
            ],
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildIntervalSlider(
    BuildContext context, {
    required String emoji,
    required String label,
    required int value,
    required int min,
    required int max,
    required int recommendedDays,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            Text(
              '$value日ごと',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          activeColor: AppColors.primaryGreen,
          onChanged: (v) => onChanged(v.round()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            '推奨: $recommendedDays日',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSubtle,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationTile(PlantLocation location) {
    return SelectionTile(
      title: location.label,
      leading: Text(location.emoji, style: const TextStyle(fontSize: 32)),
      isSelected: _selectedLocation == location,
      onTap: () => setState(() => _selectedLocation = location),
    );
  }

  Future<void> _savePlant(Plant plant) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final updatedPlant = plant.copyWith(
        nickname: _nicknameController.text.trim(),
        location: _selectedLocation,
      );

      final repo = ref.read(plantRepositoryProvider);
      await repo.updatePlant(updatedPlant);

      // お世話間隔の更新
      await _updateCareIntervals(plant);

      // プロバイダを無効化してデータを再取得
      ref.invalidate(plantByIdProvider(widget.plantId));
      ref.invalidate(plantsProvider);
      ref.invalidate(careSchedulesForPlantProvider(widget.plantId));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('植物を更新しました'),
            duration: Duration(seconds: 2),
          ),
        );
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _updateCareIntervals(Plant plant) async {
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final schedules = await scheduleRepo.getSchedulesForPlant(widget.plantId);

    for (final schedule in schedules) {
      int? newInterval;
      if (schedule.careType == CareType.water &&
          _waterIntervalDays != null &&
          _waterIntervalDays != schedule.intervalDays) {
        newInterval = _waterIntervalDays;
      } else if (schedule.careType == CareType.fertilize &&
          _fertilizeIntervalDays != null &&
          _fertilizeIntervalDays != schedule.intervalDays) {
        newInterval = _fertilizeIntervalDays;
      } else if (schedule.careType == CareType.repot &&
          _repotIntervalDays != null &&
          _repotIntervalDays != schedule.intervalDays) {
        newInterval = _repotIntervalDays;
      }

      if (newInterval != null) {
        final newNextDueDate = calculateNextDueDate(
          careType: schedule.careType,
          plant: plant,
          intervalDays: newInterval,
        );

        final updatedSchedule = schedule.copyWith(
          intervalDays: newInterval,
          nextDueDate: newNextDueDate,
        );
        await scheduleRepo.updateSchedule(updatedSchedule);

        // 通知を再スケジュール
        try {
          final notificationService = ref.read(notificationServiceProvider);
          final settingsRepo = ref.read(userSettingsRepositoryProvider);
          final settings = await settingsRepo.watchSettings().first;

          if (settings.notificationEnabled) {
            final notificationId =
                NotificationService.generateNotificationId(
              updatedSchedule.plantId,
              updatedSchedule.careType.name,
            );
            await notificationService.cancelNotification(notificationId);

            final scheduledDate = DateTime(
              updatedSchedule.nextDueDate.year,
              updatedSchedule.nextDueDate.month,
              updatedSchedule.nextDueDate.day,
              settings.waterReminderHour,
              settings.waterReminderMinute,
            );
            final title =
                '${updatedSchedule.careType.emoji} ${updatedSchedule.careType.label}の時間です';
            final body =
                '${plant.nickname}の${updatedSchedule.careType.label}をしましょう！';

            await notificationService.scheduleNotification(
              id: notificationId,
              title: title,
              body: body,
              scheduledDate: scheduledDate,
            );
          }
        } catch (e) {
          // 通知スケジュールの失敗はアプリに致命的ではないので無視
        }
      }
    }
  }

  Future<void> _showDeleteConfirmation(Plant plant) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('植物を削除'),
        content: Text(
          '「${plant.nickname}」を削除しますか？\nお世話ログやスケジュールも一緒に削除されます。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textDanger,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _deletePlant();
    }
  }

  Future<void> _deletePlant() async {
    if (_isDeleting) return;
    setState(() => _isDeleting = true);

    try {
      final repo = ref.read(plantRepositoryProvider);
      await repo.deletePlant(widget.plantId);

      // プロバイダを無効化
      ref.invalidate(plantsProvider);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('植物を削除しました'),
          duration: Duration(seconds: 2),
        ),
      );
      context.go(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDeleting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('削除に失敗しました: $e')),
      );
    }
  }
}

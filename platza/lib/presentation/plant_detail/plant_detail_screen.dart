import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/care_log_providers.dart';
import 'package:platza/application/providers/care_schedule_providers.dart';
import 'package:platza/application/providers/plant_photo_providers.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

/// 植物詳細画面 - ドット絵キャラクターとお世話アクション
class PlantDetailScreen extends ConsumerStatefulWidget {
  final String plantId;

  const PlantDetailScreen({super.key, required this.plantId});

  @override
  ConsumerState<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends ConsumerState<PlantDetailScreen>
    with SingleTickerProviderStateMixin {
  /// ドット絵のアイドルアニメーション（上下にゆらゆら）
  late final AnimationController _bobController;
  late final Animation<double> _bobAnimation;

  /// お世話リアクション表示用
  CareType? _activeCareReaction;

  @override
  void initState() {
    super.initState();
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _bobAnimation = Tween<double>(begin: -3.0, end: 3.0).animate(
      CurvedAnimation(parent: _bobController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bobController.dispose();
    super.dispose();
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

        final species = PlantSpeciesData.getById(plant.speciesId);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text(plant.nickname),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  await context.push(
                    AppRoutes.plantEditPath(widget.plantId),
                  );
                  // 編集画面から戻った後にデータを再取得
                  ref.invalidate(plantByIdProvider(widget.plantId));
                  ref.invalidate(plantsProvider);
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showPhotoPickerBottomSheet(context),
            child: const Icon(Icons.camera_alt),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // ドット絵キャラクター表示エリア
                Padding(
                  padding: AppSpacing.screenPadding,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PixelContainer(
                        size: PixelContainerSize.hero,
                        child: AnimatedBuilder(
                          animation: _bobAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _bobAnimation.value),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            width: AppSpacing.pixelArtHero,
                            height: AppSpacing.pixelArtHero,
                            child: PixelArtWidget(
                              speciesId: plant.speciesId,
                              status: plant.status,
                              growthStage: plant.growthStage,
                              size: AppSpacing.pixelArtHero,
                            ),
                          ),
                        ),
                      ),
                      // お世話リアクションオーバーレイ
                      if (_activeCareReaction != null)
                        Positioned.fill(
                          child: CareReactionOverlay(
                            careType: _activeCareReaction!,
                            onComplete: () {
                              if (mounted) {
                                setState(() {
                                  _activeCareReaction = null;
                                });
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // 種類名
                Text(
                  species.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                // ステータス表示
                Padding(
                  padding: AppSpacing.screenPaddingHorizontal,
                  child: PlatzaCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatusItem(
                          context,
                          '状態',
                          '${plant.status.emoji} ${plant.status.label}',
                        ),
                        _buildStatusItem(
                          context,
                          '成長',
                          '🌱 ${plant.growthStage.label}',
                        ),
                        _buildStatusItem(
                          context,
                          '連続',
                          '${plant.streakDays}日',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // 次のお世話タイミング
                _buildNextCareSection(context),
                const SizedBox(height: AppSpacing.xl),
                // お世話アクションボタン
                Padding(
                  padding: AppSpacing.screenPaddingHorizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: CareType.values.map((type) {
                      return CareActionButton(
                        careType: type,
                        onTap: () async {
                          // リアクションアニメーションを表示
                          setState(() {
                            _activeCareReaction = type;
                          });

                          await addCareLog(
                            ref,
                            plantId: widget.plantId,
                            careType: type,
                          );
                          // 植物データ・スケジュールを再取得
                          ref.invalidate(plantByIdProvider(widget.plantId));
                          ref.invalidate(
                            careSchedulesForPlantProvider(widget.plantId),
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${type.emoji} ${type.label}を記録しました',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                // お世話ログへのリンク
                Padding(
                  padding: AppSpacing.screenPaddingHorizontal,
                  child: PlatzaCard(
                    onTap: () =>
                        context.push(AppRoutes.careLogPath(widget.plantId)),
                    padding: EdgeInsets.zero,
                    child: const ListTile(
                      leading: Icon(Icons.history),
                      title: Text('お世話ログ'),
                      subtitle: Text('過去のお世話履歴を確認'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                // お世話カレンダーへのリンク
                Padding(
                  padding: AppSpacing.screenPaddingHorizontal,
                  child: PlatzaCard(
                    onTap: () => context
                        .push(AppRoutes.careCalendarPath(widget.plantId)),
                    padding: EdgeInsets.zero,
                    child: const ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text('お世話カレンダー'),
                      subtitle: Text('月単位で実績と予定を確認'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // 写真記録セクション
                _buildPhotoSection(context),
                const SizedBox(height: AppSpacing.xl),
              ],
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
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }

  /// 写真記録セクション
  Widget _buildPhotoSection(BuildContext context) {
    final photosAsync = ref.watch(photosForPlantProvider(widget.plantId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: '写真記録',
        ),
        photosAsync.when(
          data: (photos) {
            if (photos.isEmpty) {
              return const Padding(
                padding: AppSpacing.screenPaddingHorizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: Center(
                    child: Text(
                      'まだ写真がありません',
                      style: TextStyle(color: AppColors.textSubtle),
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: AppSpacing.screenPaddingHorizontal,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AppSpacing.xs,
                  mainAxisSpacing: AppSpacing.xs,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return GestureDetector(
                    onTap: () => _showPhotoViewer(context, photo),
                    child: ClipRRect(
                      borderRadius: AppSpacing.borderRadiusSm,
                      child: Image.file(
                        File(photo.filePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surfaceTertiary,
                            child: const Icon(
                              Icons.broken_image,
                              color: AppColors.textSubtle,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  /// 写真選択のボトムシートを表示
  void _showPhotoPickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () {
                  Navigator.pop(context);
                  _pickPhoto(fromCamera: true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('ギャラリーから選択'),
                onTap: () {
                  Navigator.pop(context);
                  _pickPhoto(fromCamera: false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// 写真を取得して保存
  Future<void> _pickPhoto({required bool fromCamera}) async {
    final photoService = ref.read(photoServiceProvider);
    final String? filePath;

    if (fromCamera) {
      filePath = await photoService.pickFromCamera();
    } else {
      filePath = await photoService.pickFromGallery();
    }

    if (filePath == null) {
      if (mounted && fromCamera) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('カメラを利用できませんでした')),
        );
      }
      return;
    }

    final photo = PlantPhoto(
      id: const Uuid().v4(),
      plantId: widget.plantId,
      filePath: filePath,
      createdAt: DateTime.now(),
    );

    final repo = ref.read(plantPhotoRepositoryProvider);
    await repo.addPhoto(photo);
  }

  /// 写真ビューアを表示
  void _showPhotoViewer(BuildContext context, PlantPhoto photo) {
    showDialog(
      context: context,
      builder: (context) => PhotoViewerDialog(
        photo: photo,
        onDelete: () async {
          final photoService = ref.read(photoServiceProvider);
          final repo = ref.read(plantPhotoRepositoryProvider);
          await photoService.deletePhotoFile(photo.filePath);
          await repo.deletePhoto(photo.id);
        },
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  /// 次のお世話タイミングセクション
  Widget _buildNextCareSection(BuildContext context) {
    final schedulesAsync = ref.watch(
      careSchedulesForPlantProvider(widget.plantId),
    );

    return schedulesAsync.when(
      data: (schedules) {
        if (schedules.isEmpty) return const SizedBox.shrink();

        // 有効なスケジュールのみ、nextDueDateが近い順にソート
        final active = schedules.where((s) => s.isEnabled).toList()
          ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));

        if (active.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: AppSpacing.screenPaddingHorizontal,
          child: PlatzaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '次のお世話',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                ...active.map(
                  (schedule) => _buildScheduleRow(context, schedule),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  /// スケジュール1行の表示
  Widget _buildScheduleRow(BuildContext context, CareSchedule schedule) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(
      schedule.nextDueDate.year,
      schedule.nextDueDate.month,
      schedule.nextDueDate.day,
    );
    final daysLeft = dueDay.difference(today).inDays;

    final isOverdue = daysLeft < 0;
    final isDueToday = daysLeft == 0;

    // 残り日数のテキスト
    String daysText;
    if (isOverdue) {
      daysText = '${-daysLeft}日超過';
    } else if (isDueToday) {
      daysText = '今日';
    } else if (daysLeft == 1) {
      daysText = '明日';
    } else {
      daysText = 'あと$daysLeft日';
    }

    // 色の決定
    final Color textColor;
    final Color bgColor;
    if (isOverdue) {
      textColor = AppColors.textDanger;
      bgColor = AppColors.backgroundDangerLight;
    } else if (isDueToday) {
      textColor = AppColors.textWarning;
      bgColor = AppColors.backgroundWarningLight;
    } else if (daysLeft <= 2) {
      textColor = AppColors.textAccentOrange;
      bgColor = AppColors.backgroundAccentOrange;
    } else {
      textColor = AppColors.textSubtle;
      bgColor = AppColors.surfaceTertiary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Text(
            schedule.careType.emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              schedule.careType.label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Text(
              daysText,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '(${schedule.intervalDays}日ごと)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSubtle,
                ),
          ),
        ],
      ),
    );
  }
}

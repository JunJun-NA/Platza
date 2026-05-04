import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/home/widgets/home_header.dart';
import 'package:platza/presentation/home/widgets/natural_light_overlay.dart';
import 'package:platza/presentation/home/widgets/plant_room_layer.dart';
import 'package:platza/presentation/home/widgets/room_background.dart';
import 'package:platza/presentation/home/widgets/starter_hint_card.dart';

/// ホーム画面 - 部屋シーンの中に植物を配置するレイアウト
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(plantsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. 部屋背景
          const RoomBackground(),
          // 2. 自然光オーバーレイ
          const Positioned.fill(
            child: IgnorePointer(child: NaturalLightOverlay()),
          ),
          // 3. 植物レイヤー
          Positioned.fill(
            child: plantsAsync.when(
              data: (plants) => PlantRoomLayer(plants: plants),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          // 4. UI レイヤー
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeader(),
                  if (plantsAsync.value?.isEmpty ?? false) ...[
                    const SizedBox(height: AppSpacing.md),
                    StarterHintCard(
                      onTap: () => context.push(AppRoutes.plantRegister),
                    ),
                  ],
                  if (plantsAsync.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.md),
                      child: Text(
                        'エラーが発生しました: ${plantsAsync.error}',
                        style: AppTypography.body
                            .copyWith(color: AppColors.textDanger),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.plantRegister),
        backgroundColor: AppColors.surfacePrimary,
        foregroundColor: AppColors.iconBrand,
        elevation: 4,
        icon: const Icon(Icons.add),
        label: const Text('植物を追加'),
        shape: const StadiumBorder(),
      ),
    );
  }
}

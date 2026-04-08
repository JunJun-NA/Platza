import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/home/widgets/plant_card.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// ホーム画面 - 植物一覧をドット絵カードで表示
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantsAsync = ref.watch(plantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Platza',
          style: AppTypography.displaySmall.copyWith(
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        actions: [
          // デバッグ: ドット絵ギャラリー
          IconButton(
            icon: const Icon(Icons.grid_view),
            tooltip: 'ドット絵ギャラリー',
            onPressed: () => context.push('/debug/gallery'),
          ),
        ],
      ),
      body: plantsAsync.when(
        data: (plants) {
          if (plants.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildPlantGrid(context, plants);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.plantRegister),
        icon: const Icon(Icons.add),
        label: const Text('植物を追加'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const EmptyState(
      emoji: '🌱',
      title: 'まだ植物がいません',
      subtitle: '＋ボタンから植物を追加してみましょう',
    );
  }

  Widget _buildPlantGrid(BuildContext context, List plants) {
    return GridView.builder(
      padding: AppSpacing.screenPadding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppSpacing.gridCrossAxisCount,
        childAspectRatio: AppSpacing.gridChildAspectRatio,
        crossAxisSpacing: AppSpacing.gridCrossAxisSpacing,
        mainAxisSpacing: AppSpacing.gridMainAxisSpacing,
      ),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        return PlantCard(plant: plants[index]);
      },
    );
  }
}

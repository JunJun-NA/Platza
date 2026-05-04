import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/plant.dart';
import 'package:platza/presentation/home/data/room_layout.dart';
import 'package:platza/presentation/widgets/atoms/plant_art_widget.dart';

/// 部屋シーンの上に植物を配置するレイヤー。
///
/// [PlantSlot] 群（`kRoomSlots`）の相対座標に従って [PlantArtWidget] を
/// `Positioned` で配置。各植物はタップで詳細画面へ遷移する。
class PlantRoomLayer extends StatelessWidget {
  const PlantRoomLayer({super.key, required this.plants});

  final List<Plant> plants;

  @override
  Widget build(BuildContext context) {
    final placements = assignPlantsToSlots(plants, kRoomSlots);
    if (placements.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final p in placements)
              Positioned(
                left: p.slot.x * w - p.slot.maxSize / 2,
                top: p.slot.y * h - p.slot.maxSize,
                width: p.slot.maxSize,
                height: p.slot.maxSize,
                child: _PlantInRoom(plant: p.plant, slotSize: p.slot.maxSize),
              ),
          ],
        );
      },
    );
  }
}

class _PlantInRoom extends StatelessWidget {
  const _PlantInRoom({required this.plant, required this.slotSize});

  final Plant plant;
  final double slotSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(AppRoutes.plantDetailPath(plant.id)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: PlantArtWidget(
              speciesId: plant.speciesId,
              status: plant.status,
              growthStage: plant.growthStage,
              size: slotSize,
            ),
          ),
          _NicknamePill(nickname: plant.nickname),
        ],
      ),
    );
  }
}

/// 植物の下に表示する半透明の名札ピル。
class _NicknamePill extends StatelessWidget {
  const _NicknamePill({required this.nickname});

  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary.withValues(alpha: 0.85),
        borderRadius: AppRadius.allFull,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        nickname,
        style: AppTypography.label.copyWith(color: AppColors.textDefault),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

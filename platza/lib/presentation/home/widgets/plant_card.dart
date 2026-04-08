import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/presentation/widgets/widgets.dart';

/// ホーム画面の植物カードウィジェット
class PlantCard extends StatelessWidget {
  const PlantCard({super.key, required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final species = PlantSpeciesData.getById(plant.speciesId);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push(AppRoutes.plantDetailPath(plant.id));
        },
        borderRadius: AppSpacing.borderRadiusLg,
        child: Column(
          children: [
            // ドット絵表示エリア
            Expanded(
              flex: 3,
              child: PixelContainer(
                size: PixelContainerSize.small,
                width: double.infinity,
                showBorder: false,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final artSize = constraints.biggest.shortestSide;
                    return PixelArtWidget(
                      speciesId: plant.speciesId,
                      status: plant.status,
                      growthStage: plant.growthStage,
                      size: artSize,
                    );
                  },
                ),
              ),
            ),
            // 情報エリア
            Expanded(
              flex: 2,
              child: Padding(
                padding: AppSpacing.cardPaddingSm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.nickname,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xxxs),
                    Text(
                      species.name,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    StatusBadge(status: plant.status),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

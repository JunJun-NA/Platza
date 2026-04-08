import 'package:flutter/material.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/pixel_art_widget.dart';

/// ドット絵の全パターンを一覧表示するデバッグ画面
class PixelArtGalleryScreen extends StatelessWidget {
  const PixelArtGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final species = PlantSpeciesData.allSpecies;

    return Scaffold(
      appBar: AppBar(title: const Text('ドット絵ギャラリー')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: species.length,
        itemBuilder: (context, index) {
          final sp = species[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sp.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              // ステータス × 成長段階のグリッド
              // 列: 成長段階（seedling, growing, mature, flowering）
              // 行: ステータス（happy, thirsty, wilting, blooming）
              SizedBox(
                height: 320,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ヘッダー行
                      Row(
                        children: [
                          const SizedBox(width: 60),
                          for (final stage in GrowthStage.values)
                            SizedBox(
                              width: 80,
                              child: Text(
                                stage.label,
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // 各ステータス行
                      for (final status in PlantStatus.values)
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                '${status.emoji}\n${status.label}',
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            for (final stage in GrowthStage.values)
                              Container(
                                width: 80,
                                height: 70,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppColors.pixelBackground,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.borderLight,
                                  ),
                                ),
                                child: Center(
                                  child: PixelArtWidget(
                                    speciesId: sp.id,
                                    status: status,
                                    growthStage: stage,
                                    size: 64,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const Divider(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}

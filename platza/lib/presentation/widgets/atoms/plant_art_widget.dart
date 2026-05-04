import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platza/application/providers/asset_manifest_provider.dart';
import 'package:platza/core/constants/plant_art_assets.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/pixel_art_widget.dart';

/// 植物のアートを表示するウィジェット。
///
/// 種ごとの SVG アセット (`assets/plants_art/{assetPrefix}.svg`) があれば
/// それを優先表示し、無ければ既存の [PixelArtWidget] にフォールバックする。
///
/// - [growthStage] に応じてサイズを段階的にスケーリング
/// - [status] に応じて [ColorFilter] で色味を変化
class PlantArtWidget extends ConsumerWidget {
  const PlantArtWidget({
    super.key,
    required this.speciesId,
    required this.status,
    required this.growthStage,
    this.size = 100,
  });

  final String speciesId;
  final PlantStatus status;
  final GrowthStage growthStage;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = PlantSpeciesData.getById(speciesId);
    final svgPath = PlantArtAssets.svgPath(species.assetPrefix);
    final manifestAsync = ref.watch(assetManifestProvider);

    final hasSvg = manifestAsync.maybeWhen(
      data: (manifest) => manifest.listAssets().contains(svgPath),
      orElse: () => false,
    );

    if (!hasSvg) {
      return _buildPixelFallback();
    }
    return _buildSvg(svgPath);
  }

  Widget _buildPixelFallback() {
    return PixelArtWidget(
      speciesId: speciesId,
      status: status,
      growthStage: growthStage,
      size: size,
    );
  }

  Widget _buildSvg(String path) {
    final scale = _scaleForGrowth();
    final colorFilter = _colorFilterForStatus();

    return SizedBox(
      width: size,
      height: size,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          widthFactor: scale,
          heightFactor: scale,
          child: SvgPicture.asset(
            path,
            colorFilter: colorFilter,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  /// 成長段階に応じたスケール係数 (0.0〜1.0)。
  /// 鉢は表示領域の下端に揃え、上方向に伸びるイメージで描画する。
  double _scaleForGrowth() {
    switch (growthStage) {
      case GrowthStage.seedling:
        return 0.5;
      case GrowthStage.growing:
        return 0.75;
      case GrowthStage.mature:
      case GrowthStage.flowering:
        return 1.0;
    }
  }

  /// ステータスに応じた [ColorFilter]。元気/開花は素のまま、
  /// のどが渇いた → 彩度低下、ぐったり → セピア寄り。
  ColorFilter? _colorFilterForStatus() {
    switch (status) {
      case PlantStatus.happy:
      case PlantStatus.blooming:
        return null;
      case PlantStatus.thirsty:
        return const ColorFilter.matrix(<double>[
          0.7, 0.2, 0.1, 0, 15,
          0.1, 0.7, 0.1, 0, 15,
          0.1, 0.2, 0.6, 0, 0,
          0,   0,   0,   1, 0,
        ]);
      case PlantStatus.wilting:
        return const ColorFilter.matrix(<double>[
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0,     0,     0,     1, 0,
        ]);
    }
  }
}

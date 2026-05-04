import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/application/providers/asset_manifest_provider.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/pixel_art_widget.dart';
import 'package:platza/presentation/widgets/atoms/plant_art_widget.dart';

class _EmptyManifest implements AssetManifest {
  @override
  List<AssetMetadata>? getAssetVariants(String key) => null;

  @override
  List<String> listAssets() => const [];
}

void main() {
  testWidgets('SVG アセットが存在しないとき PixelArtWidget にフォールバックする',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          assetManifestProvider
              .overrideWith((ref) async => _EmptyManifest()),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: PlantArtWidget(
              speciesId: 'echeveria',
              status: PlantStatus.happy,
              growthStage: GrowthStage.mature,
              size: 80,
            ),
          ),
        ),
      ),
    );

    // AsyncValue が解決されるまで待つ
    await tester.pumpAndSettle();

    expect(find.byType(PixelArtWidget), findsOneWidget);
  });
}

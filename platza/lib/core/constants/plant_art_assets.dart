/// 植物アートアセットのパス解決
class PlantArtAssets {
  PlantArtAssets._();

  static const String _basePath = 'assets/plants_art';

  /// `assetPrefix` から SVG アセットのフルパスを返す。
  static String svgPath(String assetPrefix) => '$_basePath/$assetPrefix.svg';
}

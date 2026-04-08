/// 植物の置き場所
enum PlantLocation {
  indoor('室内', '🏠'),
  outdoor('屋外', '🌳'),
  window('窓際', '🪟');

  const PlantLocation(this.label, this.emoji);

  final String label;
  final String emoji;
}

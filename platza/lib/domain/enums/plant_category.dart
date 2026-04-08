/// 植物のカテゴリ
enum PlantCategory {
  succulent('多肉植物'),
  cactus('サボテン');

  const PlantCategory(this.label);

  final String label;
}

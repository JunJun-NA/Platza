/// 成長段階
enum GrowthStage {
  seedling('苗'),
  growing('成長中'),
  mature('成熟'),
  flowering('開花');

  const GrowthStage(this.label);

  final String label;
}

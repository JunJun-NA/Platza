/// 植物の状態
enum PlantStatus {
  happy('元気', '😊'),
  thirsty('のどが渇いた', '😰'),
  wilting('ぐったり', '😵'),
  blooming('開花中', '🌸');

  const PlantStatus(this.label, this.emoji);

  final String label;
  final String emoji;
}

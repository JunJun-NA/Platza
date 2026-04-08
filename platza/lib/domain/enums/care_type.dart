/// お世話の種類
enum CareType {
  water('水やり', '💧'),
  fertilize('肥料', '🌱'),
  repot('植え替え', '🪴'),
  sunlight('日当たり変更', '☀️');

  const CareType(this.label, this.emoji);

  final String label;
  final String emoji;
}

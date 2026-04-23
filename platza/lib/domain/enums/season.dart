/// 季節
enum Season {
  spring('春', '🌸'),
  summer('夏', '☀️'),
  autumn('秋', '🍁'),
  winter('冬', '❄️');

  const Season(this.label, this.emoji);

  final String label;
  final String emoji;

  /// 指定した日付から季節を判定する（気象庁の区分に合わせた月ベース）
  /// 3-5月: 春 / 6-8月: 夏 / 9-11月: 秋 / 12-2月: 冬
  static Season fromDate(DateTime date) {
    final month = date.month;
    if (month >= 3 && month <= 5) return Season.spring;
    if (month >= 6 && month <= 8) return Season.summer;
    if (month >= 9 && month <= 11) return Season.autumn;
    return Season.winter;
  }
}

/// 日光の要求度
enum SunlightNeed {
  low('弱い光でOK'),
  medium('半日陰'),
  high('直射日光OK');

  const SunlightNeed(this.label);

  final String label;
}

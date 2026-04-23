import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';

/// 季節に応じたお世話アドバイスを表示するカード。
///
/// [season] 現在の季節。
/// [advice] 該当シーズンのアドバイス。`null` または空のときは汎用文を表示する。
class SeasonalCareAdviceCard extends StatelessWidget {
  const SeasonalCareAdviceCard({
    super.key,
    required this.season,
    required this.advice,
  });

  final Season season;
  final String? advice;

  @override
  Widget build(BuildContext context) {
    final hasAdvice = advice != null && advice!.trim().isNotEmpty;
    final body = hasAdvice ? advice!.trim() : _fallbackAdvice(season);
    final accent = _accentOf(season);

    return PlatzaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: accent.background,
                  borderRadius: AppRadius.all8,
                ),
                child: Text(
                  season.emoji,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${season.label}のお世話アドバイス',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: accent.foreground,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  static _SeasonAccent _accentOf(Season season) {
    return switch (season) {
      Season.summer => const _SeasonAccent(
          background: AppColors.backgroundAccentYellow,
          foreground: AppColors.textAccentOrange,
        ),
      Season.winter => const _SeasonAccent(
          background: AppColors.backgroundAccentBlue,
          foreground: AppColors.textAccentBlue,
        ),
      Season.spring => const _SeasonAccent(
          background: AppColors.backgroundAccentPink,
          foreground: AppColors.textAccentPink,
        ),
      Season.autumn => const _SeasonAccent(
          background: AppColors.backgroundAccentOrange,
          foreground: AppColors.textAccentOrange,
        ),
    };
  }

  static String _fallbackAdvice(Season season) {
    return switch (season) {
      Season.spring =>
        '生育期に入る時期です。土の様子を見ながら水やりを少しずつ増やし、植え替えや剪定に適したタイミングです。',
      Season.autumn =>
        '生育が穏やかになります。水やりを徐々に控えめにして、冬に向けて日当たりと風通しを意識しましょう。',
      Season.summer =>
        '高温多湿に注意。風通しの良い半日陰で管理し、蒸れと直射日光のダメージを防ぎましょう。',
      Season.winter =>
        '低温期は休眠する種が多く、水やりは控えめに。暖かい室内の明るい場所で管理しましょう。',
    };
  }
}

class _SeasonAccent {
  const _SeasonAccent({
    required this.background,
    required this.foreground,
  });

  final Color background;
  final Color foreground;
}

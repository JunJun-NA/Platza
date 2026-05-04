import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// 植物が 0 匹のときにホーム上部に表示する案内カード。
class StarterHintCard extends StatelessWidget {
  const StarterHintCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfacePrimary.withValues(alpha: 0.95),
      borderRadius: AppRadius.all16,
      elevation: 2,
      shadowColor: const Color(0x14000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.all16,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundAccentGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco,
                  color: AppColors.iconBrand,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'はじめの1鉢を選んで\n育ててみましょう',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textDefault,
                    height: 1.3,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.iconSubtle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

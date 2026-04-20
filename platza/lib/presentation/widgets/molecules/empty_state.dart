import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/widgets/atoms/pixel_container.dart';

/// 空状態の表示ウィジェット
///
/// 植物が登録されていない場合や、ログが空の場合に表示。
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PixelContainer(
              size: PixelContainerSize.medium,
              showBorder: false,
              child: Text(emoji, style: const TextStyle(fontSize: 48)),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              title,
              style: AppTypography.subtitle.copyWith(
                color: AppColors.textDefault,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSubtle,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// ホーム画面ヘッダー。タイトル / サブタイトル / 通知ベル。
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Platza',
                style: AppTypography.display.copyWith(
                  color: AppColors.textBrand,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'あなただけのグリーン空間をつくろう',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSubtle,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          color: AppColors.iconSubtle,
          tooltip: '通知',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('通知機能は準備中です')),
            );
          },
        ),
      ],
    );
  }
}

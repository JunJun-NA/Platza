import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// 選択状態を持つ ListTile ベースの選択肢タイル
///
/// 選択時は primary 色の太めボーダーと薄い背景でハイライトされる。
/// `plant_register` / `plant_edit` のカテゴリ / 種 / 置き場所の選択で利用。
class SelectionTile extends StatelessWidget {
  const SelectionTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.all12,
          side: BorderSide(
            color: isSelected ? AppColors.primaryGreen : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        leading: leading,
        title: Text(title),
        subtitle: subtitle != null
            ? Text(subtitle!, maxLines: 1, overflow: TextOverflow.ellipsis)
            : null,
        selected: isSelected,
        selectedTileColor: AppColors.primaryGreen.withValues(alpha: 0.05),
        onTap: onTap,
      ),
    );
  }
}

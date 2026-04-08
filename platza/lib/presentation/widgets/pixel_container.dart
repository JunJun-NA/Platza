import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';

/// ドット絵を表示するコンテナ
///
/// サイズバリエーション:
/// - [PixelContainerSize.small]  64px  - カード内のサムネイル
/// - [PixelContainerSize.medium] 100px - リスト内の表示
/// - [PixelContainerSize.large]  200px - 詳細画面のサブ表示
/// - [PixelContainerSize.hero]   260px - 詳細画面のメイン表示
enum PixelContainerSize {
  small(AppSpacing.pixelArtSmall),
  medium(AppSpacing.pixelArtMedium),
  large(AppSpacing.pixelArtLarge),
  hero(AppSpacing.pixelArtHero);

  const PixelContainerSize(this.dimension);
  final double dimension;
}

class PixelContainer extends StatelessWidget {
  const PixelContainer({
    super.key,
    required this.child,
    this.size = PixelContainerSize.medium,
    this.width,
    this.height,
    this.showBorder = true,
  });

  final Widget child;
  final PixelContainerSize size;

  /// null の場合は [size.dimension] を使用
  final double? width;
  final double? height;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.pixelBackgroundDark : AppColors.pixelBackground;
    final borderColor = isDark ? AppColors.borderDark : AppColors.pixelBorder;

    return Container(
      width: width ?? (size == PixelContainerSize.hero ? double.infinity : size.dimension),
      height: height ?? size.dimension,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: size == PixelContainerSize.small
            ? AppSpacing.borderRadiusMd
            : AppSpacing.borderRadiusXl,
        border: showBorder
            ? Border.all(color: borderColor, width: size == PixelContainerSize.hero ? 3 : 2)
            : null,
        boxShadow: size == PixelContainerSize.hero ? AppShadows.pixelArea : null,
      ),
      child: Center(child: child),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:platza/core/constants/pixel_art_data.dart';
import 'package:platza/domain/enums/enums.dart';

/// ピクセルアートで植物を描画するウィジェット
///
/// [speciesId]に応じた固有のドット絵を、[status]と[growthStage]に応じて
/// 色やサイズを変えて描画する。
class PixelArtWidget extends StatelessWidget {
  const PixelArtWidget({
    super.key,
    required this.speciesId,
    required this.status,
    required this.growthStage,
    this.size = 100,
  });

  /// 植物の種ID
  final String speciesId;

  /// 植物の状態（色に影響）
  final PlantStatus status;

  /// 成長段階（表示サイズ・複雑さに影響）
  final GrowthStage growthStage;

  /// 描画サイズ（幅・高さ）
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PixelArtPainter(
        pattern: PixelArtData.getPattern(speciesId),
        status: status,
        growthStage: growthStage,
      ),
    );
  }
}

/// ピクセルアートを描画するCustomPainter
class _PixelArtPainter extends CustomPainter {
  _PixelArtPainter({
    required this.pattern,
    required this.status,
    required this.growthStage,
  });

  final List<String> pattern;
  final PlantStatus status;
  final GrowthStage growthStage;

  /// グリッドサイズ（16x16）
  static const int gridSize = 16;

  @override
  void paint(Canvas canvas, Size size) {
    final colors = _getColorPalette();

    // 成長段階に応じて表示する行数を決定
    final visibleRows = _getVisibleRows();
    final startRow = gridSize - visibleRows;

    // 可視行の使用する列範囲を特定（横方向もフィットさせるため）
    int minCol = gridSize;
    int maxCol = 0;
    for (int row = startRow; row < gridSize; row++) {
      if (row >= pattern.length) continue;
      final rowData = pattern[row];
      for (int col = 0; col < rowData.length && col < gridSize; col++) {
        if (rowData[col] != '.') {
          if (col < minCol) minCol = col;
          if (col > maxCol) maxCol = col;
        }
      }
    }
    if (minCol > maxCol) return; // 描画するものがない

    final usedCols = maxCol - minCol + 1;

    // 横幅・縦幅にフィットするピクセルサイズを計算（余白を持たせる）
    final availableWidth = size.width * 0.8;
    final availableHeight = size.height * 0.8;
    final pixelSize = (availableWidth / usedCols).clamp(
      0.0,
      availableHeight / visibleRows,
    );

    // 中央に配置するオフセット
    final contentWidth = usedCols * pixelSize;
    final contentHeight = visibleRows * pixelSize;
    final xOffset = (size.width - contentWidth) / 2;
    final yOffset = (size.height - contentHeight) / 2;

    for (int row = startRow; row < gridSize; row++) {
      if (row >= pattern.length) continue;
      final rowData = pattern[row];

      for (int col = 0; col < rowData.length && col < gridSize; col++) {
        final char = rowData[col];
        final color = _getColorForChar(char, colors);

        if (color != null) {
          final rect = Rect.fromLTWH(
            (col - minCol) * pixelSize + xOffset,
            (row - startRow) * pixelSize + yOffset,
            pixelSize,
            pixelSize,
          );
          canvas.drawRect(rect, Paint()..color = color);
        }
      }
    }
  }

  /// 成長段階に応じて表示する行数
  int _getVisibleRows() {
    switch (growthStage) {
      case GrowthStage.seedling:
        return 6; // 鉢と少しだけ
      case GrowthStage.growing:
        return 11; // 中程度
      case GrowthStage.mature:
        return 16; // 全体表示
      case GrowthStage.flowering:
        return 16; // 全体表示（花付き）
    }
  }

  /// 状態に応じたカラーパレットを取得
  _ColorPalette _getColorPalette() {
    switch (status) {
      case PlantStatus.happy:
        return const _ColorPalette(
          leaf: Color(0xFF4CAF50),       // 鮮やかな緑
          highlight: Color(0xFF81C784),  // 明るい緑
          dark: Color(0xFF2E3A2E),       // 暗い輪郭
          stem: Color(0xFF6D4C2A),       // 茶色の茎
          pot: Color(0xFFBF6B3E),        // テラコッタ
          flower: Color(0xFFF06292),     // ピンクの花
          window: Color(0xFFB2EBF2),     // 透明窓（ハオルチア）
          thorn: Color(0xFFE0E0E0),      // トゲ
        );
      case PlantStatus.thirsty:
        return const _ColorPalette(
          leaf: Color(0xFFC8B44A),       // 黄みがかった緑
          highlight: Color(0xFFDDD076),  // 淡い黄緑
          dark: Color(0xFF3E3A2E),       // 暗い輪郭
          stem: Color(0xFF7D5C3A),       // 茶色の茎
          pot: Color(0xFFBF6B3E),        // テラコッタ
          flower: Color(0xFFF8BBD0),     // 薄いピンク
          window: Color(0xFFE0F2F1),     // 薄い窓
          thorn: Color(0xFFE0E0E0),      // トゲ
        );
      case PlantStatus.wilting:
        return const _ColorPalette(
          leaf: Color(0xFF8B7355),       // 茶色がかった緑
          highlight: Color(0xFFA89070),  // 薄茶
          dark: Color(0xFF3E322A),       // 暗い輪郭
          stem: Color(0xFF5D3C1A),       // 暗い茶
          pot: Color(0xFFBF6B3E),        // テラコッタ
          flower: Color(0xFFBCAAA4),     // くすんだ花
          window: Color(0xFFD7CCC8),     // くすんだ窓
          thorn: Color(0xFFBDBDBD),      // くすんだトゲ
        );
      case PlantStatus.blooming:
        return const _ColorPalette(
          leaf: Color(0xFF66BB6A),       // 明るい緑
          highlight: Color(0xFFA5D6A7),  // さらに明るい緑
          dark: Color(0xFF2E3A2E),       // 暗い輪郭
          stem: Color(0xFF6D4C2A),       // 茶色の茎
          pot: Color(0xFFBF6B3E),        // テラコッタ
          flower: Color(0xFFEC407A),     // 鮮やかなピンク
          window: Color(0xFFB2EBF2),     // 透明窓
          thorn: Color(0xFFE0E0E0),      // トゲ
        );
    }
  }

  /// 文字からカラーを取得
  Color? _getColorForChar(String char, _ColorPalette palette) {
    // floweringまたはbloomingでない場合、花は表示しない
    final showFlower = status == PlantStatus.blooming ||
        growthStage == GrowthStage.flowering;

    switch (char) {
      case 'L':
        return palette.leaf;
      case 'H':
        return palette.highlight;
      case 'D':
        return palette.dark;
      case 'S':
        return palette.stem;
      case 'P':
        return palette.pot;
      case 'F':
        return showFlower ? palette.flower : null;
      case 'W':
        return palette.window;
      case 'T':
        return palette.thorn;
      default:
        return null; // 透明（'.'など）
    }
  }

  @override
  bool shouldRepaint(covariant _PixelArtPainter oldDelegate) {
    return oldDelegate.status != status ||
        oldDelegate.growthStage != growthStage ||
        oldDelegate.pattern != pattern;
  }
}

/// ピクセルアート描画用のカラーパレット
class _ColorPalette {
  const _ColorPalette({
    required this.leaf,
    required this.highlight,
    required this.dark,
    required this.stem,
    required this.pot,
    required this.flower,
    required this.window,
    required this.thorn,
  });

  final Color leaf;
  final Color highlight;
  final Color dark;
  final Color stem;
  final Color pot;
  final Color flower;
  final Color window;
  final Color thorn;
}

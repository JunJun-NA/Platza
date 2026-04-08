import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/widgets/pixel_container.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('PixelContainer ゴールデンテスト', () {
    testWidgets('全サイズバリエーション（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final size in PixelContainerSize.values)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PixelContainer(
                      size: size,
                      child: Text(
                        size.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/pixel_container_sizes_light.png'),
      );
    });

    testWidgets('全サイズバリエーション（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final size in PixelContainerSize.values)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PixelContainer(
                      size: size,
                      child: Text(
                        size.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/pixel_container_sizes_dark.png'),
      );
    });

    testWidgets('ボーダーなし', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const PixelContainer(
            size: PixelContainerSize.medium,
            showBorder: false,
            child: Text('🌿', style: TextStyle(fontSize: 32)),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/pixel_container_no_border.png'),
      );
    });
  });
}

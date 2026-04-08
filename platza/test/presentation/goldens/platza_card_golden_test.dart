import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/widgets/platza_card.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('PlatzaCard ゴールデンテスト', () {
    testWidgets('基本表示（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 300,
            child: PlatzaCard(
              child: Text('カードコンテンツ'),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/platza_card_light.png'),
      );
    });

    testWidgets('基本表示（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 300,
            child: PlatzaCard(
              child: Text('カードコンテンツ'),
            ),
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/platza_card_dark.png'),
      );
    });

    testWidgets('タップ可能なカード（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          SizedBox(
            width: 300,
            child: PlatzaCard(
              onTap: () {},
              child: const Text('タップ可能なカード'),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/platza_card_tappable_light.png'),
      );
    });
  });
}

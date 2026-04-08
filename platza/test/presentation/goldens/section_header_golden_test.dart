import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/widgets/section_header.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('SectionHeader ゴールデンテスト', () {
    testWidgets('タイトルのみ（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 400,
            child: SectionHeader(title: 'お世話履歴'),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/section_header_light.png'),
      );
    });

    testWidgets('タイトルのみ（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SizedBox(
            width: 400,
            child: SectionHeader(title: 'お世話履歴'),
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/section_header_dark.png'),
      );
    });

    testWidgets('アクション付き（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          SizedBox(
            width: 400,
            child: SectionHeader(
              title: 'お世話履歴',
              action: TextButton(
                onPressed: () {},
                child: const Text('すべて見る'),
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/section_header_with_action_light.png'),
      );
    });
  });
}

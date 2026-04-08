import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/widgets/empty_state.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('EmptyState ゴールデンテスト', () {
    testWidgets('基本表示（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const EmptyState(
            emoji: '🌵',
            title: 'まだ植物がありません',
            subtitle: '右下の＋ボタンから追加しましょう',
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/empty_state_light.png'),
      );
    });

    testWidgets('基本表示（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const EmptyState(
            emoji: '🌵',
            title: 'まだ植物がありません',
            subtitle: '右下の＋ボタンから追加しましょう',
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/empty_state_dark.png'),
      );
    });

    testWidgets('アクション付き（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          EmptyState(
            emoji: '🌵',
            title: 'まだ植物がありません',
            subtitle: '右下の＋ボタンから追加しましょう',
            action: FilledButton(
              onPressed: () {},
              child: const Text('植物を追加'),
            ),
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/empty_state_with_action_light.png'),
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/presentation/home/widgets/starter_hint_card.dart';

void main() {
  group('StarterHintCard', () {
    testWidgets('案内テキストが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: StarterHintCard(onTap: () {})),
        ),
      );
      expect(find.textContaining('はじめの1鉢'), findsOneWidget);
    });

    testWidgets('タップで onTap が呼ばれる', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarterHintCard(onTap: () => tapped++),
          ),
        ),
      );
      await tester.tap(find.byType(StarterHintCard));
      expect(tapped, 1);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/care_action_button.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('CareActionButton ゴールデンテスト', () {
    testWidgets('全ケアタイプ - enabled（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final type in CareType.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CareActionButton(
                    careType: type,
                    onTap: () {},
                  ),
                ),
            ],
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/care_action_button_enabled_light.png'),
      );
    });

    testWidgets('全ケアタイプ - enabled（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final type in CareType.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CareActionButton(
                    careType: type,
                    onTap: () {},
                  ),
                ),
            ],
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/care_action_button_enabled_dark.png'),
      );
    });

    testWidgets('全ケアタイプ - disabled（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final type in CareType.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CareActionButton(
                    careType: type,
                    onTap: () {},
                    enabled: false,
                  ),
                ),
            ],
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/care_action_button_disabled_light.png'),
      );
    });
  });
}

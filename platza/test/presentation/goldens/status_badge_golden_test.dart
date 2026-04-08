import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/status_badge.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('StatusBadge ゴールデンテスト', () {
    testWidgets('dot バリアント - 全ステータス（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final status in PlantStatus.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StatusBadge(
                    status: status,
                    variant: StatusBadgeVariant.dot,
                  ),
                ),
            ],
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/status_badge_dot_light.png'),
      );
    });

    testWidgets('dot バリアント - 全ステータス（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final status in PlantStatus.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StatusBadge(
                    status: status,
                    variant: StatusBadgeVariant.dot,
                  ),
                ),
            ],
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/status_badge_dot_dark.png'),
      );
    });

    testWidgets('chip バリアント - 全ステータス（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final status in PlantStatus.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StatusBadge(
                    status: status,
                    variant: StatusBadgeVariant.chip,
                  ),
                ),
            ],
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/status_badge_chip_light.png'),
      );
    });

    testWidgets('chip バリアント - 全ステータス（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final status in PlantStatus.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StatusBadge(
                    status: status,
                    variant: StatusBadgeVariant.chip,
                  ),
                ),
            ],
          ),
          brightness: Brightness.dark,
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/status_badge_chip_dark.png'),
      );
    });

    testWidgets('icon バリアント - 全ステータス', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final status in PlantStatus.values)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: StatusBadge(
                    status: status,
                    variant: StatusBadgeVariant.icon,
                  ),
                ),
            ],
          ),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/status_badge_icon.png'),
      );
    });
  });
}

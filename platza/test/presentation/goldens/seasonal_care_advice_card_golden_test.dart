import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/seasonal_care_advice_card.dart';

import '../../helpers/golden_test_helper.dart';

void main() {
  group('SeasonalCareAdviceCard ゴールデンテスト', () {
    testWidgets('夏 - summerCare 表示（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SeasonalCareAdviceCard(
            season: Season.summer,
            advice: '直射日光を避け、風通しの良い半日陰で管理。蒸れに注意',
          ),
          surfaceSize: const Size(400, 200),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/seasonal_care_advice_summer_light.png'),
      );
    });

    testWidgets('冬 - winterCare 表示（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SeasonalCareAdviceCard(
            season: Season.winter,
            advice: '水やりを月1回程度に減らし、室内の明るい場所で管理',
          ),
          surfaceSize: const Size(400, 200),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/seasonal_care_advice_winter_light.png'),
      );
    });

    testWidgets('春 - 汎用文フォールバック（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SeasonalCareAdviceCard(
            season: Season.spring,
            advice: null,
          ),
          surfaceSize: const Size(400, 240),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/seasonal_care_advice_spring_light.png'),
      );
    });

    testWidgets('秋 - 汎用文フォールバック（ライト）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SeasonalCareAdviceCard(
            season: Season.autumn,
            advice: null,
          ),
          surfaceSize: const Size(400, 240),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/seasonal_care_advice_autumn_light.png'),
      );
    });

    testWidgets('夏 - summerCare 表示（ダーク）', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const SeasonalCareAdviceCard(
            season: Season.summer,
            advice: '直射日光を避け、風通しの良い半日陰で管理。蒸れに注意',
          ),
          brightness: Brightness.dark,
          surfaceSize: const Size(400, 200),
        ),
      );
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('golden_files/seasonal_care_advice_summer_dark.png'),
      );
    });
  });
}

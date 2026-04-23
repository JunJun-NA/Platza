import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/seasonal_care_advice_card.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: Scaffold(body: child),
    );

void main() {
  group('SeasonalCareAdviceCard', () {
    testWidgets('夏は summerCare が表示される', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const SeasonalCareAdviceCard(
            season: Season.summer,
            advice: '風通しの良い半日陰で管理',
          ),
        ),
      );

      expect(find.text('夏のお世話アドバイス'), findsOneWidget);
      expect(find.text('風通しの良い半日陰で管理'), findsOneWidget);
      expect(find.text('☀️'), findsOneWidget);
    });

    testWidgets('冬は winterCare が表示される', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const SeasonalCareAdviceCard(
            season: Season.winter,
            advice: '水やりは月1回程度',
          ),
        ),
      );

      expect(find.text('冬のお世話アドバイス'), findsOneWidget);
      expect(find.text('水やりは月1回程度'), findsOneWidget);
      expect(find.text('❄️'), findsOneWidget);
    });

    testWidgets('advice が null のときは汎用文を表示する', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const SeasonalCareAdviceCard(
            season: Season.spring,
            advice: null,
          ),
        ),
      );

      expect(find.text('春のお世話アドバイス'), findsOneWidget);
      expect(
        find.textContaining('生育期に入る時期'),
        findsOneWidget,
      );
    });

    testWidgets('advice が空文字列のときは汎用文を表示する', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const SeasonalCareAdviceCard(
            season: Season.autumn,
            advice: '   ',
          ),
        ),
      );

      expect(find.text('秋のお世話アドバイス'), findsOneWidget);
      expect(
        find.textContaining('生育が穏やかになります'),
        findsOneWidget,
      );
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:platza/application/providers/care_calendar_providers.dart';
import 'package:platza/application/providers/care_log_providers.dart';
import 'package:platza/application/providers/care_schedule_providers.dart';
import 'package:platza/application/providers/plant_providers.dart';
import 'package:platza/core/theme/app_theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/care_calendar/care_calendar_screen.dart';

const _plantId = 'plant-1';

Plant _buildPlant() => Plant(
      id: _plantId,
      nickname: 'ぷにぷに',
      speciesId: 'echeveria',
      location: PlantLocation.window,
      status: PlantStatus.happy,
      growthStage: GrowthStage.mature,
      createdAt: DateTime(2026, 1, 1),
    );

Widget _buildApp({
  required List<CareLog> logs,
  required List<CareSchedule> schedules,
}) {
  return ProviderScope(
    overrides: [
      plantByIdProvider(_plantId).overrideWith((_) async => _buildPlant()),
      careLogsForPlantProvider(_plantId)
          .overrideWith((_) => Stream<List<CareLog>>.value(logs)),
      careSchedulesForPlantProvider(_plantId)
          .overrideWith((_) async => schedules),
      careCalendarDataProvider(_plantId).overrideWith((ref) {
        return AsyncValue.data(
          buildCareCalendarData(logs: logs, schedules: schedules),
        );
      }),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: const CareCalendarScreen(plantId: _plantId),
    ),
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ja_JP');
  });

  group('CareCalendarScreen', () {
    testWidgets('データが空でも安全に表示される', (tester) async {
      await tester.pumpWidget(_buildApp(logs: [], schedules: []));
      await tester.pumpAndSettle();

      expect(find.text('ぷにぷに'), findsOneWidget);
      expect(find.text('この日はお世話の記録も予定もありません'), findsOneWidget);
      // 凡例が表示される
      expect(find.text('実施済み'), findsOneWidget);
      expect(find.text('予定'), findsOneWidget);
    });

    testWidgets('当日のイベントがカード表示される', (tester) async {
      final today = DateTime.now();
      final performedToday = DateTime(
        today.year,
        today.month,
        today.day,
        8,
        0,
      );

      final logs = [
        CareLog(
          id: 'l1',
          plantId: _plantId,
          careType: CareType.water,
          performedAt: performedToday,
          note: 'たっぷり',
        ),
      ];

      await tester.pumpWidget(_buildApp(logs: logs, schedules: []));
      await tester.pumpAndSettle();

      expect(find.text('水やり'), findsWidgets);
      expect(find.text('実施済み'), findsWidgets);
      expect(find.text('たっぷり'), findsOneWidget);
    });

    testWidgets('前月・翌月に移動するボタンが存在する', (tester) async {
      await tester.pumpWidget(_buildApp(logs: [], schedules: []));
      await tester.pumpAndSettle();

      // table_calendar のデフォルトは chevron_left / chevron_right
      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });
  });
}

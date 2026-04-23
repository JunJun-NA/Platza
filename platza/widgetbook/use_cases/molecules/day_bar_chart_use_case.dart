import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/day_bar_chart.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: DayBarChart)
Widget dayBarChartDefault(BuildContext context) {
  return const DayBarChart(dailyActivity: [2, 0, 3, 1, 0, 4, 2]);
}

@widgetbook.UseCase(name: 'Empty', type: DayBarChart)
Widget dayBarChartEmpty(BuildContext context) {
  return const DayBarChart(dailyActivity: [0, 0, 0, 0, 0, 0, 0]);
}

@widgetbook.UseCase(name: 'Spiked', type: DayBarChart)
Widget dayBarChartSpiked(BuildContext context) {
  return const DayBarChart(dailyActivity: [0, 0, 0, 0, 0, 10, 0]);
}

import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/schedule_status_badge.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: ScheduleStatusBadge)
Widget scheduleStatusBadgeDefault(BuildContext context) {
  final daysLeft = context.knobs.int
      .slider(label: 'daysLeft', initialValue: 3, min: -7, max: 30);
  return ScheduleStatusBadge(daysLeft: daysLeft);
}

@widgetbook.UseCase(name: 'Overdue', type: ScheduleStatusBadge)
Widget scheduleStatusBadgeOverdue(BuildContext context) {
  return const ScheduleStatusBadge(daysLeft: -2);
}

@widgetbook.UseCase(name: 'Today', type: ScheduleStatusBadge)
Widget scheduleStatusBadgeToday(BuildContext context) {
  return const ScheduleStatusBadge(daysLeft: 0);
}

@widgetbook.UseCase(name: 'Soon', type: ScheduleStatusBadge)
Widget scheduleStatusBadgeSoon(BuildContext context) {
  return const ScheduleStatusBadge(daysLeft: 2);
}

@widgetbook.UseCase(name: 'Later', type: ScheduleStatusBadge)
Widget scheduleStatusBadgeLater(BuildContext context) {
  return const ScheduleStatusBadge(daysLeft: 7);
}

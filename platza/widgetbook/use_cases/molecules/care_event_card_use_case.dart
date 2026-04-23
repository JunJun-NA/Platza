import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/care_event_card.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Performed', type: CareEventCard)
Widget careEventCardPerformed(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.water,
  );
  return CareEventCard(
    careType: careType,
    isPerformed: true,
    time: '10:00',
    note: 'たっぷり水やり',
  );
}

@widgetbook.UseCase(name: 'Scheduled', type: CareEventCard)
Widget careEventCardScheduled(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.fertilize,
  );
  return CareEventCard(careType: careType, isPerformed: false);
}

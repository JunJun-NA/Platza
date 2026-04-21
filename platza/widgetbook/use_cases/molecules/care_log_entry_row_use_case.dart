import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/care_log_entry_row.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: CareLogEntryRow)
Widget careLogEntryRowDefault(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.water,
  );
  final note = context.knobs.stringOrNull(
    label: 'note',
    initialValue: 'しっかりたっぷり',
  );
  return CareLogEntryRow(
    careType: careType,
    time: '14:30',
    note: note,
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Without note', type: CareLogEntryRow)
Widget careLogEntryRowNoNote(BuildContext context) {
  return const CareLogEntryRow(careType: CareType.fertilize, time: '08:15');
}

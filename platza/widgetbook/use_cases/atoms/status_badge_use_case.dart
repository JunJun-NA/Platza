import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/status_badge.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Dot', type: StatusBadge)
Widget statusBadgeDot(BuildContext context) {
  final status = context.knobs.object.dropdown<PlantStatus>(
    label: 'status',
    options: PlantStatus.values,
    labelBuilder: (v) => v.label,
    initialOption: PlantStatus.happy,
  );
  return StatusBadge(status: status);
}

@widgetbook.UseCase(name: 'Chip', type: StatusBadge)
Widget statusBadgeChip(BuildContext context) {
  final status = context.knobs.object.dropdown<PlantStatus>(
    label: 'status',
    options: PlantStatus.values,
    labelBuilder: (v) => v.label,
    initialOption: PlantStatus.thirsty,
  );
  return StatusBadge(status: status, variant: StatusBadgeVariant.chip);
}

@widgetbook.UseCase(name: 'Icon', type: StatusBadge)
Widget statusBadgeIcon(BuildContext context) {
  final status = context.knobs.object.dropdown<PlantStatus>(
    label: 'status',
    options: PlantStatus.values,
    labelBuilder: (v) => v.label,
    initialOption: PlantStatus.blooming,
  );
  return StatusBadge(status: status, variant: StatusBadgeVariant.icon);
}

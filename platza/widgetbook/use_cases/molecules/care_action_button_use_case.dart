import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/molecules/care_action_button.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: CareActionButton)
Widget careActionButtonDefault(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.water,
  );
  final enabled = context.knobs.boolean(label: 'enabled', initialValue: true);
  return CareActionButton(
    careType: careType,
    enabled: enabled,
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'All types', type: CareActionButton)
Widget careActionButtonAllTypes(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: CareType.values
        .map((type) => CareActionButton(
              careType: type,
              onTap: () {},
            ))
        .toList(),
  );
}

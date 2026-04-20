import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/care_type_icon_container.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: CareTypeIconContainer)
Widget careTypeIconContainerDefault(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.water,
  );
  final size = context.knobs.double
      .slider(label: 'size', initialValue: 40, min: 24, max: 64);
  return CareTypeIconContainer(careType: careType, size: size);
}

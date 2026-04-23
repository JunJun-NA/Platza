import 'package:flutter/material.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/presentation/widgets/atoms/percentage_bar.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: PercentageBar)
Widget percentageBarDefault(BuildContext context) {
  final ratio = context.knobs.double
      .slider(label: 'ratio', initialValue: 0.6, min: 0, max: 1);
  final height = context.knobs.double
      .slider(label: 'height', initialValue: 20, min: 8, max: 40);
  return SizedBox(
    width: 240,
    child: PercentageBar(
      ratio: ratio,
      activeColor: AppColors.careWater,
      trackColor: AppColors.careWaterLight,
      height: height,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/atoms/pixel_container.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Sizes', type: PixelContainer)
Widget pixelContainerSizes(BuildContext context) {
  final size = context.knobs.object.dropdown<PixelContainerSize>(
    label: 'size',
    options: PixelContainerSize.values,
    labelBuilder: (v) => v.name,
    initialOption: PixelContainerSize.medium,
  );
  final showBorder = context.knobs.boolean(
    label: 'showBorder',
    initialValue: true,
  );
  return PixelContainer(
    size: size,
    showBorder: showBorder,
    child: const Text('🌵', style: TextStyle(fontSize: 48)),
  );
}

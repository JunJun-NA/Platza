import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/selection_tile.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SelectionTile)
Widget selectionTileDefault(BuildContext context) {
  final isSelected =
      context.knobs.boolean(label: 'isSelected', initialValue: false);
  final title = context.knobs.string(label: 'title', initialValue: '多肉植物');
  final subtitle = context.knobs.stringOrNull(
    label: 'subtitle',
    initialValue: 'ぷっくりと葉に水分を蓄える植物',
  );
  return SelectionTile(
    title: title,
    subtitle: subtitle,
    leading: const Text('🪴', style: TextStyle(fontSize: 32)),
    isSelected: isSelected,
    onTap: () {},
  );
}

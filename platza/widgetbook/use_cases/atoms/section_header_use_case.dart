import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/atoms/section_header.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SectionHeader)
Widget sectionHeaderDefault(BuildContext context) {
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'お世話ログ',
  );
  return SectionHeader(title: title);
}

@widgetbook.UseCase(name: 'With action', type: SectionHeader)
Widget sectionHeaderWithAction(BuildContext context) {
  final title = context.knobs.string(
    label: 'title',
    initialValue: '写真記録',
  );
  return SectionHeader(
    title: title,
    action: TextButton(
      onPressed: () {},
      child: const Text('もっと見る'),
    ),
  );
}

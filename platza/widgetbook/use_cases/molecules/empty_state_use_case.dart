import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/empty_state.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: EmptyState)
Widget emptyStateDefault(BuildContext context) {
  final emoji = context.knobs.string(label: 'emoji', initialValue: '🪴');
  final title = context.knobs.string(
    label: 'title',
    initialValue: 'まだ植物が登録されていません',
  );
  final subtitle = context.knobs.string(
    label: 'subtitle',
    initialValue: '新しい植物を登録してお世話を始めましょう',
  );
  return EmptyState(emoji: emoji, title: title, subtitle: subtitle);
}

@widgetbook.UseCase(name: 'With action', type: EmptyState)
Widget emptyStateWithAction(BuildContext context) {
  return EmptyState(
    emoji: '📅',
    title: 'まだお世話ログがありません',
    subtitle: '植物のお世話をすると、ここに履歴が表示されます',
    action: FilledButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add),
      label: const Text('記録する'),
    ),
  );
}

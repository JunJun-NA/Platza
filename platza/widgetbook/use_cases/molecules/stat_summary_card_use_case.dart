import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/stat_summary_card.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: StatSummaryCard)
Widget statSummaryCardDefault(BuildContext context) {
  final emoji = context.knobs.string(label: 'emoji', initialValue: '🌿');
  final value = context.knobs.string(label: 'value', initialValue: '12');
  final label = context.knobs.string(label: 'label', initialValue: '植物数');
  return SizedBox(
    width: 120,
    child: StatSummaryCard(emoji: emoji, value: value, label: label),
  );
}

@widgetbook.UseCase(name: 'Three up', type: StatSummaryCard)
Widget statSummaryCardThreeUp(BuildContext context) {
  return const Row(
    children: [
      Expanded(child: StatSummaryCard(emoji: '🌿', value: '12', label: '植物数')),
      SizedBox(width: 8),
      Expanded(child: StatSummaryCard(emoji: '🔥', value: '7日', label: '最長連続')),
      SizedBox(width: 8),
      Expanded(child: StatSummaryCard(emoji: '✅', value: '34回', label: '今月のお世話')),
    ],
  );
}

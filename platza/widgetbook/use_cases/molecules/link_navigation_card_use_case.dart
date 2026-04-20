import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/link_navigation_card.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: LinkNavigationCard)
Widget linkNavigationCardDefault(BuildContext context) {
  final title = context.knobs.string(label: 'title', initialValue: 'お世話ログ');
  final subtitle = context.knobs
      .string(label: 'subtitle', initialValue: '過去のお世話履歴を確認');
  return LinkNavigationCard(
    icon: Icons.history,
    title: title,
    subtitle: subtitle,
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Without subtitle', type: LinkNavigationCard)
Widget linkNavigationCardNoSubtitle(BuildContext context) {
  return LinkNavigationCard(
    icon: Icons.settings,
    title: '設定',
    onTap: () {},
  );
}

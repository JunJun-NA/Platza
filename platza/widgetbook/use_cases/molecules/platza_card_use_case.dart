import 'package:flutter/material.dart';
import 'package:platza/presentation/widgets/molecules/platza_card.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text content', type: PlatzaCard)
Widget platzaCardText(BuildContext context) {
  final tappable = context.knobs.boolean(label: 'tappable', initialValue: false);
  return PlatzaCard(
    onTap: tappable ? () {} : null,
    child: const Text('カードの中身はなんでもOK'),
  );
}

@widgetbook.UseCase(name: 'List tile', type: PlatzaCard)
Widget platzaCardListTile(BuildContext context) {
  return PlatzaCard(
    onTap: () {},
    padding: EdgeInsets.zero,
    child: const ListTile(
      leading: Icon(Icons.calendar_month),
      title: Text('お世話カレンダー'),
      subtitle: Text('月単位で実績と予定を確認'),
      trailing: Icon(Icons.chevron_right),
    ),
  );
}

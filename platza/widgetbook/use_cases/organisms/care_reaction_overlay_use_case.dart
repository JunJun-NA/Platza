import 'package:flutter/material.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/pixel_container.dart';
import 'package:platza/presentation/widgets/organisms/care_reaction_overlay.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Playground', type: CareReactionOverlay)
Widget careReactionOverlayPlayground(BuildContext context) {
  final careType = context.knobs.object.dropdown<CareType>(
    label: 'careType',
    options: CareType.values,
    labelBuilder: (v) => v.label,
    initialOption: CareType.water,
  );

  return _ReactionPlayground(careType: careType);
}

class _ReactionPlayground extends StatefulWidget {
  const _ReactionPlayground({required this.careType});
  final CareType careType;

  @override
  State<_ReactionPlayground> createState() => _ReactionPlaygroundState();
}

class _ReactionPlaygroundState extends State<_ReactionPlayground> {
  int _key = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            children: [
              const PixelContainer(
                size: PixelContainerSize.hero,
                child: Text('🌵', style: TextStyle(fontSize: 96)),
              ),
              Positioned.fill(
                child: CareReactionOverlay(
                  key: ValueKey(_key),
                  careType: widget.careType,
                  onComplete: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => setState(() => _key++),
          icon: const Icon(Icons.replay),
          label: const Text('リプレイ'),
        ),
      ],
    );
  }
}

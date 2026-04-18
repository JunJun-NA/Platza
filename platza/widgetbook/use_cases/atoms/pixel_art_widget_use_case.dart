import 'package:flutter/material.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/atoms/pixel_art_widget.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: PixelArtWidget)
Widget pixelArtWidgetDefault(BuildContext context) {
  final species = PlantSpeciesData.allSpecies;
  final speciesId = context.knobs.object.dropdown<String>(
    label: 'speciesId',
    options: species.map((s) => s.id).toList(),
    initialOption: species.first.id,
  );
  final status = context.knobs.object.dropdown<PlantStatus>(
    label: 'status',
    options: PlantStatus.values,
    labelBuilder: (v) => v.label,
    initialOption: PlantStatus.happy,
  );
  final growthStage = context.knobs.object.dropdown<GrowthStage>(
    label: 'growthStage',
    options: GrowthStage.values,
    labelBuilder: (v) => v.label,
    initialOption: GrowthStage.mature,
  );
  final size = context.knobs.double
      .slider(label: 'size', initialValue: 120, min: 40, max: 260);

  return PixelArtWidget(
    speciesId: speciesId,
    status: status,
    growthStage: growthStage,
    size: size,
  );
}

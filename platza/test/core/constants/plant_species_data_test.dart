import 'package:flutter_test/flutter_test.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/domain/enums/enums.dart';

void main() {
  group('PlantSpeciesData', () {
    test('allSpecies returns 10 species', () {
      expect(PlantSpeciesData.allSpecies.length, 10);
    });

    test('getById returns correct species for echeveria', () {
      final species = PlantSpeciesData.getById('echeveria');
      expect(species.id, 'echeveria');
      expect(species.name, 'エケベリア');
      expect(species.category, PlantCategory.succulent);
    });

    test('getById returns correct species for cactus_round', () {
      final species = PlantSpeciesData.getById('cactus_round');
      expect(species.id, 'cactus_round');
      expect(species.name, '丸型サボテン');
      expect(species.category, PlantCategory.cactus);
    });

    test('getById throws when species not found', () {
      expect(
        () => PlantSpeciesData.getById('nonexistent'),
        throwsStateError,
      );
    });

    test('getByCategory returns 5 succulents', () {
      final succulents =
          PlantSpeciesData.getByCategory(PlantCategory.succulent);
      expect(succulents.length, 5);
      for (final s in succulents) {
        expect(s.category, PlantCategory.succulent);
      }
    });

    test('getByCategory returns 5 cacti', () {
      final cacti = PlantSpeciesData.getByCategory(PlantCategory.cactus);
      expect(cacti.length, 5);
      for (final c in cacti) {
        expect(c.category, PlantCategory.cactus);
      }
    });

    test('all species have non-empty required fields', () {
      for (final species in PlantSpeciesData.allSpecies) {
        expect(species.id, isNotEmpty);
        expect(species.name, isNotEmpty);
        expect(species.description, isNotEmpty);
        expect(species.assetPrefix, isNotEmpty);
        expect(species.winterCare, isNotEmpty);
        expect(species.summerCare, isNotEmpty);
        expect(species.waterFrequencyDays, greaterThan(0));
        expect(species.fertilizerFrequencyDays, greaterThan(0));
      }
    });

    test('all species have unique ids', () {
      final ids = PlantSpeciesData.allSpecies.map((s) => s.id).toSet();
      expect(ids.length, PlantSpeciesData.allSpecies.length);
    });
  });
}

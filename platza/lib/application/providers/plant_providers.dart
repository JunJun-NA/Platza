import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/domain/entities/entities.dart';

/// 全植物一覧をリアルタイム監視するProvider
final plantsProvider = StreamProvider<List<Plant>>((ref) {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.watchAllPlants();
});

/// IDで単一の植物を取得するProvider
final plantByIdProvider =
    FutureProvider.family<Plant?, String>((ref, id) async {
  final repo = ref.watch(plantRepositoryProvider);
  return repo.getPlantById(id);
});

/// 植物種マスターデータのProvider
final plantSpeciesProvider = Provider<List<PlantSpecies>>((ref) {
  return PlantSpeciesData.allSpecies;
});

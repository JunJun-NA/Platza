import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/infrastructure/services/photo_service.dart';

/// 写真サービスのProvider
final photoServiceProvider = Provider<PhotoService>((ref) {
  return PhotoService();
});

/// 特定の植物の写真をリアルタイム監視するProvider
final photosForPlantProvider =
    StreamProvider.family<List<PlantPhoto>, String>((ref, plantId) {
  final repo = ref.watch(plantPhotoRepositoryProvider);
  return repo.watchPhotosForPlant(plantId);
});

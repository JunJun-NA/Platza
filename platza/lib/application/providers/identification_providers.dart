import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platza/infrastructure/services/plant_identification_service.dart';

/// 植物種同定サービスのProvider
final plantIdentificationServiceProvider =
    Provider<PlantIdentificationService>((ref) {
  return PlantIdentificationService();
});

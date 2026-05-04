import 'package:platza/domain/entities/plant.dart';

/// 部屋シーン内の植物配置スロット。
///
/// 座標は背景画像の表示領域に対する相対値（0.0〜1.0）で定義する。
/// `(x, y)` はスロットの **底面中央** を指す（鉢底が床面に沿うようにするため）。
class PlantSlot {
  const PlantSlot({
    required this.id,
    required this.x,
    required this.y,
    required this.maxSize,
  });

  final String id;

  /// 横位置（0.0=左端, 1.0=右端）。鉢底中央の x。
  final double x;

  /// 縦位置（0.0=上端, 1.0=下端）。鉢底の y。
  final double y;

  /// スロットに収める最大サイズ（dp、正方形）。
  final double maxSize;
}

/// 単一レイアウトの初期スロット定義。背景画像
/// `assets/backgrounds/image.png` の構造（左の窓・中央上の棚・右のドレッサー）に合わせる。
///
/// 奥（吊るし）→ 中（棚・ドレッサー）→ 手前（床）の順に並べ、
/// Stack の重ね順がそのまま遠近感になるようにする。
const List<PlantSlot> kRoomSlots = [
  // --- 吊るし（最奥・天井付近） ---
  PlantSlot(id: 'hang-center', x: 0.55, y: 0.18, maxSize: 110),
  // --- 棚の上（中段） ---
  PlantSlot(id: 'shelf-left', x: 0.32, y: 0.50, maxSize: 90),
  // --- ドレッサーの上 ---
  PlantSlot(id: 'dresser-top', x: 0.78, y: 0.62, maxSize: 90),
  // --- 床（手前） ---
  PlantSlot(id: 'floor-left', x: 0.18, y: 0.92, maxSize: 140),
  PlantSlot(id: 'floor-center', x: 0.48, y: 0.97, maxSize: 160),
  PlantSlot(id: 'floor-right', x: 0.78, y: 0.93, maxSize: 130),
];

/// 植物リストとスロット定義から、表示する `(plant, slot)` の組を作る。
/// 植物の数が `slots` を超える場合、超過分は表示対象外（次ストーリで対応）。
List<PlantPlacement> assignPlantsToSlots(
  List<Plant> plants,
  List<PlantSlot> slots,
) {
  final count = plants.length < slots.length ? plants.length : slots.length;
  return List<PlantPlacement>.generate(
    count,
    (index) => PlantPlacement(plant: plants[index], slot: slots[index]),
  );
}

/// 配置 1 件分の組
class PlantPlacement {
  const PlantPlacement({required this.plant, required this.slot});

  final Plant plant;
  final PlantSlot slot;
}

/// ピクセルアートの描画データ定義
///
/// 各文字が1ピクセルに対応:
/// '.' = 透明
/// 'L' = 葉/本体（緑、状態により変化）
/// 'D' = 輪郭線/暗部
/// 'S' = 茎/幹（茶色）
/// 'P' = 鉢（テラコッタ）
/// 'F' = 花（ピンク、blooming/floweringのみ表示）
/// 'H' = ハイライト（明るい緑）
/// 'W' = 窓/先端（ハオルチア用）
/// 'T' = トゲ（サボテン用）
class PixelArtData {
  PixelArtData._();

  /// 種IDからピクセルデータを取得
  static List<String> getPattern(String speciesId) {
    return _patterns[speciesId] ?? _patterns['echeveria']!;
  }

  /// 全種のmature（成熟）パターン 16x16グリッド
  static final Map<String, List<String>> _patterns = {
    // エケベリア - ロゼット形の多肉植物
    'echeveria': [
      '................',
      '......FFF.......',
      '.....F.F.F......',
      '......DDD.......',
      '....DHLHLD......',
      '...DHLLHLHD.....',
      '..DHLLLLLHLD....',
      '..DLHLLLLHLD....',
      '.DHLLLLLLLHLD...',
      '.DLHLLLLLHLLD...',
      '..DHLLLLLHLD....',
      '..DDLLLLLDD.....',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // セダム - 密集した小さな葉
    'sedum': [
      '................',
      '................',
      '....DLD.DLD.....',
      '...DLHLDLHLD....',
      '..DLD.DLDDLD....',
      '..DLHLDLHLLD....',
      '.DLD.DLD.DLD....',
      '.DLHLDLHLDLD....',
      '..DLDDLDDLD.....',
      '...DLLLLLD......',
      '....DSSSD.......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // ハオルチア - 窓付きの尖った葉
    'haworthia': [
      '................',
      '.....DWD........',
      '....DWLD........',
      '...DWLLD..DWD...',
      '..DWLLLD.DWLD...',
      '..DLLLLD.WLLD...',
      '...DLLD.DWLLD...',
      '..DWLLDDDLLLD...',
      '.DWLLLLLLLLLD...',
      '.DLLLLLLLLLD....',
      '..DLLLLLLLD.....',
      '...DDLLLDD......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // グラプトペタルム - 厚い丸い葉
    'graptopetallum': [
      '................',
      '......FF........',
      '.....FLFD.......',
      '....DHHLD.......',
      '...DHLLHLD......',
      '..DHLLLLHLD.....',
      '..DLLHLLHLD.....',
      '.DHLLLLLLLLD....',
      '.DLLLHLLLLLD....',
      '.DHLLLLLLHLD....',
      '..DLLLLLLLLD....',
      '...DDLLLDD......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // アロエ - 高く尖った葉
    'aloe': [
      '....DLD.DLD.....',
      '...DLLD.DLLD....',
      '...DLLD.DLLD....',
      '..DLHLD.DLHLD...',
      '..DLLLD.DLLLD...',
      '..DLLLDDDLLLD...',
      '.DLLLLDDDLLLLD..',
      '.DLLLLLLLLLLLD..',
      '.DLHLLLLLLHLLD..',
      '..DLLLLLLLLLD...',
      '..DLLLLLLLLD....',
      '...DDLLLDD......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // 丸型サボテン - 丸い球体
    'cactus_round': [
      '................',
      '................',
      '......FFF.......',
      '.....DDDDD......',
      '...TDLHLHLDТ....',
      '..TDLLLLLLLD....',
      '..DLHLLLLHLD....',
      '.TDLLLLLLLLDT...',
      '.DLHLLLLLHLD....',
      '.TDLLLLLLLLDT...',
      '..DLHLLLLHLD....',
      '..TDLLLLLLDT....',
      '...DDDDDDD......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // 柱サボテン - 高い柱状
    'cactus_pillar': [
      '....DDDDD.......',
      '...DLHLHLD......',
      '..TDLLLLLDT.....',
      '..TDLHLHLDT.....',
      '..TDLLLLLDT.....',
      '..TDLHLHLDT.....',
      '..TDLLLLLDT.....',
      '..TDLHLHLDT.....',
      '..TDLLLLLDT.....',
      '..TDLHLHLDT.....',
      '..TDLLLLLDT.....',
      '...DDDDDDD......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // ウチワサボテン - 平たいパドル形
    'cactus_paddle': [
      '....TDDDT.......',
      '...TDLHLDT......',
      '..TDLLLLLDТ.....',
      '...TDLHLDT......',
      '....TDDDT.......',
      '.....DLD........',
      '...TDDDDDT......',
      '..TDLHLLLDТ.....',
      '..TDLLLLLDТ.....',
      '..TDLHLLLDТ.....',
      '...TDDDDDT......',
      '.....DSD........',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // 星形サボテン - アストロフィツム
    'cactus_star': [
      '................',
      '......FFF.......',
      '.....DDDDD......',
      '....DLHLHLD.....',
      '..TDDLLLLLDDT...',
      '.TDLHLLLLHLDT...',
      '..DLLLLLLLLLD...',
      '..TDLHLLHLDT....',
      '...DLLLLLLD.....',
      '..TDLHLLHLDT....',
      '..DLLLLLLLLLD...',
      '...DDDDDDDDD....',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],

    // 玉サボテン - 小さな球形マミラリア
    'cactus_ball': [
      '................',
      '................',
      '....FFFFF.......',
      '...FFF.FFF......',
      '....DDDDD.......',
      '..TTDLHLDTT.....',
      '..TDLLLLLDТ.....',
      '.TTDLHLHLDT.....',
      '.TDLLLLLLLDT....',
      '.TTDLHLHLDT.....',
      '..TDLLLLLDТ.....',
      '...DDDDDDD......',
      '....DSSSD.......',
      '...DPPPPD.......',
      '..DPPPPPPPD.....',
      '..DDDDDDDDD.....',
    ],
  };
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/core/constants/app_routes.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// スプラッシュ画面で使用する植物種ID一覧
const _splashSpeciesIds = [
  'echeveria',
  'sedum',
  'haworthia',
  'graptopetallum',
  'aloe',
  'cactus_round',
  'cactus_pillar',
  'cactus_paddle',
  'cactus_star',
  'cactus_ball',
];

/// SharedPreferencesで初回起動判定に使うキー
const _hasLaunchedKey = 'has_launched_before';

/// スプラッシュ画面
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  /// テスト用: SharedPreferencesをオーバーライド可能にする
  @visibleForTesting
  static Future<SharedPreferences> Function()? sharedPreferencesFactory;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatController;

  // メインアニメーション
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _logoPulse;

  // 浮遊する装飾植物のアニメーション
  late Animation<double> _float1;
  late Animation<double> _float2;
  late Animation<double> _float3;

  late String _mainSpeciesId;
  late List<String> _decorSpeciesIds;
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();

    // ランダムに植物を選択
    final random = Random();
    final shuffled = List<String>.from(_splashSpeciesIds)..shuffle(random);
    _mainSpeciesId = shuffled[0];
    _decorSpeciesIds = [shuffled[1], shuffled[2], shuffled[3]];

    // メインアニメーション（2.5秒）
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // 1) ロゴコンテナ: フェードイン + スケールアップ (0-800ms)
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.32, curve: Curves.easeOut),
      ),
    );
    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.32, curve: Curves.easeOut),
      ),
    );

    // 2) タイトル: スライドアップ + フェードイン (400-1200ms)
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.16, 0.48, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.16, 0.48, curve: Curves.easeOut),
      ),
    );

    // 3) サブタイトル: スライドアップ + フェードイン (600-1400ms)
    _subtitleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.24, 0.56, curve: Curves.easeOut),
      ),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.24, 0.56, curve: Curves.easeOut),
      ),
    );

    // 4) ロゴのパルスエフェクト (1000-2000ms)
    _logoPulse = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.05),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.05, end: 1.0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    // 浮遊アニメーション（ループ）
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _float1 = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );
    _float2 = Tween<double>(begin: 3, end: -3).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
    _float3 = Tween<double>(begin: -2, end: 5).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _mainController.forward();
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    try {
      final prefs = SplashScreen.sharedPreferencesFactory != null
          ? await SplashScreen.sharedPreferencesFactory!()
          : await SharedPreferences.getInstance();
      _isFirstLaunch = !(prefs.getBool(_hasLaunchedKey) ?? false);
      await prefs.setBool(_hasLaunchedKey, true);
    } catch (_) {
      // SharedPreferences取得に失敗した場合は初回扱いで続行
    }

    final delay = _isFirstLaunch
        ? const Duration(milliseconds: 2500)
        : const Duration(milliseconds: 1500);

    await Future<void>.delayed(delay);
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // グラデーション背景
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryDark,
                  AppColors.primaryGreen,
                ],
              ),
            ),
          ),

          // ドットパターン背景
          Positioned.fill(
            child: CustomPaint(
              painter: _DotPatternPainter(),
            ),
          ),

          // メインコンテンツ
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ロゴ + ピクセルアート
                AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: ScaleTransition(
                          scale: _logoPulse,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: AppSpacing.pixelArtLarge,
                    height: AppSpacing.pixelArtLarge,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: AppRadius.all20,
                    ),
                    child: Center(
                      child: PixelArtWidget(
                        speciesId: _mainSpeciesId,
                        status: PlantStatus.blooming,
                        growthStage: GrowthStage.flowering,
                        size: AppSpacing.pixelArtLarge - 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // タイトル
                SlideTransition(
                  position: _titleSlide,
                  child: FadeTransition(
                    opacity: _titleFade,
                    child: Text(
                      'Platza',
                      style: AppTypography.display.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // サブタイトル
                SlideTransition(
                  position: _subtitleSlide,
                  child: FadeTransition(
                    opacity: _subtitleFade,
                    child: Text(
                      'ドット絵で育てる、植物のお世話',
                      style: AppTypography.body.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 浮遊する装飾植物
          ..._buildFloatingPlants(),

          // バージョンテキスト
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _subtitleFade,
              child: Text(
                'v0.1.0',
                textAlign: TextAlign.center,
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingPlants() {
    return [
      // 左上の装飾植物
      AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          return Positioned(
            top: 120 + _float1.value,
            left: 30,
            child: FadeTransition(
              opacity: _logoFade,
              child: child,
            ),
          );
        },
        child: PixelArtWidget(
          speciesId: _decorSpeciesIds[0],
          status: PlantStatus.happy,
          growthStage: GrowthStage.mature,
          size: AppSpacing.pixelArtSmall,
        ),
      ),

      // 右上の装飾植物
      AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          return Positioned(
            top: 160 + _float2.value,
            right: 40,
            child: FadeTransition(
              opacity: _logoFade,
              child: child,
            ),
          );
        },
        child: PixelArtWidget(
          speciesId: _decorSpeciesIds[1],
          status: PlantStatus.happy,
          growthStage: GrowthStage.growing,
          size: AppSpacing.pixelArtSmall - 16,
        ),
      ),

      // 右下の装飾植物
      AnimatedBuilder(
        animation: _floatController,
        builder: (context, child) {
          return Positioned(
            bottom: 140 + _float3.value,
            right: 50,
            child: FadeTransition(
              opacity: _logoFade,
              child: child,
            ),
          );
        },
        child: PixelArtWidget(
          speciesId: _decorSpeciesIds[2],
          status: PlantStatus.blooming,
          growthStage: GrowthStage.flowering,
          size: AppSpacing.pixelArtSmall - 8,
        ),
      ),
    ];
  }
}

/// 背景のドットパターンを描画するCustomPainter
class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    const spacing = 24.0;
    const dotRadius = 1.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platza/application/providers/database_provider.dart';
import 'package:platza/application/providers/identification_providers.dart';
import 'package:platza/application/providers/plant_photo_providers.dart';
import 'package:platza/core/constants/plant_species_data.dart';
import 'package:platza/core/theme/theme.dart';
import 'package:platza/domain/entities/entities.dart';
import 'package:platza/domain/enums/enums.dart';
import 'package:platza/presentation/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

/// 植物登録画面 - カテゴリ→種類→置き場所→名前の4ステップ
class PlantRegisterScreen extends ConsumerStatefulWidget {
  const PlantRegisterScreen({super.key});

  @override
  ConsumerState<PlantRegisterScreen> createState() =>
      _PlantRegisterScreenState();
}

class _PlantRegisterScreenState extends ConsumerState<PlantRegisterScreen> {
  int _currentStep = 0;
  PlantCategory? _selectedCategory;
  PlantSpecies? _selectedSpecies;
  PlantLocation _selectedLocation = PlantLocation.indoor;
  final _nicknameController = TextEditingController();

  bool _isIdentifying = false;
  String? _identificationPhotoPath;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('植物を登録'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: Row(
              children: [
                FilledButton(
                  onPressed: details.onStepContinue,
                  child: Text(_currentStep == 3 ? '登録する' : '次へ'),
                ),
                const SizedBox(width: AppSpacing.md),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('戻る'),
                  ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('カテゴリ'),
            subtitle: _selectedCategory != null
                ? Text(_selectedCategory!.label)
                : null,
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            content: _buildCategoryStep(),
          ),
          Step(
            title: const Text('種類'),
            subtitle: _selectedSpecies != null
                ? Text(_selectedSpecies!.name)
                : null,
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            content: _buildSpeciesStep(),
          ),
          Step(
            title: const Text('置き場所'),
            subtitle: Text(_selectedLocation.label),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            content: _buildLocationStep(),
          ),
          Step(
            title: const Text('ニックネーム'),
            isActive: _currentStep >= 3,
            content: _buildNicknameStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStep() {
    return Column(
      children: [
        // 写真で判別ボタン
        _buildPhotoIdentificationButton(),
        const SizedBox(height: AppSpacing.md),
        // 区切り線
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'または手動で選択',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // 手動カテゴリ選択
        ...PlantCategory.values.map((category) {
          return SelectionTile(
            title: category.label,
            leading: Text(
              category == PlantCategory.succulent ? '🪴' : '🌵',
              style: const TextStyle(fontSize: 32),
            ),
            isSelected: _selectedCategory == category,
            onTap: () => setState(() => _selectedCategory = category),
          );
        }),
      ],
    );
  }

  Widget _buildPhotoIdentificationButton() {
    return Card(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.all12,
        side: BorderSide(
          color: AppColors.primaryGreen,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: AppRadius.all12,
        onTap: _isIdentifying ? null : _onIdentifyFromPhoto,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _isIdentifying
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Text('判別中...'),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('📷', style: TextStyle(fontSize: 28)),
                    SizedBox(width: AppSpacing.md),
                    Text(
                      '写真で植物を判別',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _onIdentifyFromPhoto() async {
    final photoService = ref.read(photoServiceProvider);

    // カメラ or ギャラリーの選択ダイアログ
    final source = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('カメラで撮影'),
              onTap: () => Navigator.pop(ctx, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('ギャラリーから選択'),
              onTap: () => Navigator.pop(ctx, 'gallery'),
            ),
          ],
        ),
      ),
    );

    if (source == null || !mounted) return;

    final imagePath = source == 'camera'
        ? await photoService.pickFromCamera()
        : await photoService.pickFromGallery();

    if (imagePath == null || !mounted) return;

    setState(() => _isIdentifying = true);

    final service = ref.read(plantIdentificationServiceProvider);
    final result = await service.identify(imagePath);

    if (!mounted) return;

    setState(() => _isIdentifying = false);

    if (result.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.errorMessage ?? '判別に失敗しました'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (result.candidates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('植物を判別できませんでした。手動で選択してください。'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // 写真パスを保存（登録後に記録写真として保存するため）
    _identificationPhotoPath = imagePath;

    // 候補をボトムシートで表示
    if (!mounted) return;
    _showCandidatesBottomSheet(result.candidates);
  }

  void _showCandidatesBottomSheet(List<IdentificationCandidate> candidates) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '判別結果',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              ...candidates.map((candidate) {
                final confidencePercent =
                    (candidate.confidence * 100).toStringAsFixed(0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.all12,
                      side: BorderSide(color: AppColors.borderLight),
                    ),
                    title: Text(candidate.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: candidate.confidence,
                          backgroundColor: Colors.grey[200],
                          color: AppColors.primaryGreen,
                        ),
                        const SizedBox(height: 2),
                        Text('$confidencePercent%'),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      _applyCandidateSelection(candidate);
                    },
                  ),
                );
              }),
              const SizedBox(height: AppSpacing.sm),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('手動で選択する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _applyCandidateSelection(IdentificationCandidate candidate) {
    try {
      final species = PlantSpeciesData.getById(candidate.speciesId);
      setState(() {
        _selectedCategory = species.category;
        _selectedSpecies = species;
        _currentStep = 2; // 置き場所ステップにジャンプ
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('選択した種が見つかりませんでした。手動で選択してください。'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildSpeciesStep() {
    if (_selectedCategory == null) {
      return const Text('カテゴリを先に選択してください');
    }
    final speciesList = PlantSpeciesData.getByCategory(_selectedCategory!);
    return Column(
      children: speciesList.map((species) {
        return SelectionTile(
          title: species.name,
          subtitle: species.description,
          isSelected: _selectedSpecies?.id == species.id,
          onTap: () => setState(() => _selectedSpecies = species),
        );
      }).toList(),
    );
  }

  Widget _buildLocationStep() {
    return Column(
      children: PlantLocation.values.map((location) {
        return SelectionTile(
          title: location.label,
          leading: Text(location.emoji, style: const TextStyle(fontSize: 32)),
          isSelected: _selectedLocation == location,
          onTap: () => setState(() => _selectedLocation = location),
        );
      }).toList(),
    );
  }

  Widget _buildNicknameStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _nicknameController,
          decoration: const InputDecoration(
            labelText: 'ニックネーム',
            hintText: '例: うちのエケちゃん',
          ),
          maxLength: 20,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '植物につける愛称を入力してください',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _onStepContinue() {
    if (_currentStep == 0 && _selectedCategory == null) return;
    if (_currentStep == 1 && _selectedSpecies == null) return;
    if (_currentStep == 3) {
      _registerPlant();
      return;
    }
    setState(() => _currentStep++);
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _registerPlant() async {
    if (_nicknameController.text.trim().isEmpty) return;

    final plantRepo = ref.read(plantRepositoryProvider);
    final scheduleRepo = ref.read(careScheduleRepositoryProvider);
    final now = DateTime.now();
    const uuid = Uuid();
    final plantId = uuid.v4();

    // 植物エンティティを作成・保存
    final plant = Plant(
      id: plantId,
      nickname: _nicknameController.text.trim(),
      speciesId: _selectedSpecies!.id,
      location: _selectedLocation,
      createdAt: now,
    );
    await plantRepo.addPlant(plant);

    // デフォルトのお世話スケジュールを作成（水やり・肥料）
    final waterSchedule = CareSchedule(
      id: uuid.v4(),
      plantId: plantId,
      careType: CareType.water,
      intervalDays: _selectedSpecies!.waterFrequencyDays,
      nextDueDate: now.add(
        Duration(days: _selectedSpecies!.waterFrequencyDays),
      ),
    );
    await scheduleRepo.addSchedule(waterSchedule);

    final fertilizerSchedule = CareSchedule(
      id: uuid.v4(),
      plantId: plantId,
      careType: CareType.fertilize,
      intervalDays: _selectedSpecies!.fertilizerFrequencyDays,
      nextDueDate: now.add(
        Duration(days: _selectedSpecies!.fertilizerFrequencyDays),
      ),
    );
    await scheduleRepo.addSchedule(fertilizerSchedule);

    final repotSchedule = CareSchedule(
      id: uuid.v4(),
      plantId: plantId,
      careType: CareType.repot,
      intervalDays: _selectedSpecies!.repotFrequencyDays,
      nextDueDate: now.add(
        Duration(days: _selectedSpecies!.repotFrequencyDays),
      ),
    );
    await scheduleRepo.addSchedule(repotSchedule);

    // 写真で判別した場合、撮影した写真を植物の最初の記録として保存
    if (_identificationPhotoPath != null) {
      final photoRepo = ref.read(plantPhotoRepositoryProvider);
      final photo = PlantPhoto(
        id: uuid.v4(),
        plantId: plantId,
        filePath: _identificationPhotoPath!,
        caption: '登録時の写真',
        createdAt: now,
      );
      await photoRepo.addPhoto(photo);
    }

    if (mounted) context.pop();
  }
}

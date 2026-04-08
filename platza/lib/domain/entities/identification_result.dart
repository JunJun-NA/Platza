/// 植物種同定の候補
class IdentificationCandidate {
  const IdentificationCandidate({
    required this.speciesId,
    required this.name,
    required this.confidence,
  });

  final String speciesId;
  final String name;
  final double confidence;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentificationCandidate &&
          runtimeType == other.runtimeType &&
          speciesId == other.speciesId &&
          name == other.name &&
          confidence == other.confidence;

  @override
  int get hashCode => Object.hash(speciesId, name, confidence);

  @override
  String toString() =>
      'IdentificationCandidate(speciesId: $speciesId, name: $name, confidence: $confidence)';
}

/// 植物種同定の結果
class IdentificationResult {
  const IdentificationResult({
    this.candidates = const [],
    this.isError = false,
    this.errorMessage,
  });

  /// エラー結果を生成するファクトリ
  factory IdentificationResult.error(String message) {
    return IdentificationResult(
      isError: true,
      errorMessage: message,
    );
  }

  final List<IdentificationCandidate> candidates;
  final bool isError;
  final String? errorMessage;

  @override
  String toString() =>
      'IdentificationResult(candidates: $candidates, isError: $isError, errorMessage: $errorMessage)';
}

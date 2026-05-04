// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_manifest_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// アプリにバンドルされたアセット一覧を一度だけロードしてキャッシュする

@ProviderFor(assetManifest)
final assetManifestProvider = AssetManifestProvider._();

/// アプリにバンドルされたアセット一覧を一度だけロードしてキャッシュする

final class AssetManifestProvider extends $FunctionalProvider<
        AsyncValue<AssetManifest>, AssetManifest, FutureOr<AssetManifest>>
    with $FutureModifier<AssetManifest>, $FutureProvider<AssetManifest> {
  /// アプリにバンドルされたアセット一覧を一度だけロードしてキャッシュする
  AssetManifestProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'assetManifestProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$assetManifestHash();

  @$internal
  @override
  $FutureProviderElement<AssetManifest> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AssetManifest> create(Ref ref) {
    return assetManifest(ref);
  }
}

String _$assetManifestHash() => r'6f6713f2f715386d26ed5846f25b528d70857323';

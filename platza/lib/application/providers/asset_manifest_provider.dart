import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_manifest_provider.g.dart';

/// アプリにバンドルされたアセット一覧を一度だけロードしてキャッシュする
@Riverpod(keepAlive: true)
Future<AssetManifest> assetManifest(Ref ref) {
  return AssetManifest.loadFromAssetBundle(rootBundle);
}

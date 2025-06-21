import 'package:flutter/services.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:path/path.dart';

final class AssetRepository implements AssetApi {
  const AssetRepository();

  static const _assetDir = 'assets';

  @override
  Future<List<String>> loadImagePaths() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    return assetManifest
        .listAssets()
        .where((string) => string.startsWith(join(_assetDir, 'images')))
        .toList();
  }
}

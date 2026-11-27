abstract interface class AssetApi {
  const AssetApi();

  Future<List<String>> loadImagePaths();
}

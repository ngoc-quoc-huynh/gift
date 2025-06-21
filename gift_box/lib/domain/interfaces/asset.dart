// ignore: one_member_abstracts, for future extension.
abstract interface class AssetApi {
  const AssetApi();

  Future<List<String>> loadImagePaths();
}

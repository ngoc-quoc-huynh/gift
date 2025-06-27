// ignore: one_member_abstracts, for future extension.
abstract interface class NativeApi {
  const NativeApi();

  Future<void> openUrl(Uri uri);
}

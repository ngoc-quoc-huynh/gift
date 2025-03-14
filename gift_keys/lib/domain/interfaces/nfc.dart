abstract interface class NfcApi {
  const NfcApi();

  Future<bool> isEnabled();

  Stream<String> startDiscovery();
}

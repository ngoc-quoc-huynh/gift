import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class NfcRepository implements NfcApi {
  const NfcRepository();

  static final _instance = NfcManager();

  @override
  Future<bool> isEnabled() => _instance.isNfcEnabled();

  @override
  Stream<String> startDiscovery() => _instance.startDiscovery();
}

import 'package:gift_keys/domain/models/nfc_command.dart';

abstract interface class NfcApi {
  const NfcApi();

  Future<bool> isEnabled();

  Stream<String> startDiscovery();

  Future<bool> sendCommand(NfcCommand nfcCommand);
}

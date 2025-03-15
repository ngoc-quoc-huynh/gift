import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:gift_keys/infrastructure/dtos/nfc/command.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class NfcRepository implements NfcApi {
  const NfcRepository();

  static final _instance = NfcManager();

  @override
  Future<bool> isEnabled() => _instance.isNfcEnabled();

  @override
  Stream<String> startDiscovery() => _instance.startDiscovery();

  @override
  Future<bool> sendCommand(domain.NfcCommand nfcCommand) async {
    final response = await _instance.sendCommand(
      CommandExtension.fromDomain(nfcCommand),
    );

    return switch (response) {
      ApduResponse.ok => true,
      _ => false,
    };
  }
}

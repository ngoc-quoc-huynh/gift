import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:gift_keys/infrastructure/dtos/nfc/command.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class NfcRepository with LoggerMixin implements NfcApi {
  const NfcRepository();

  static final _instance = NfcManager();

  @override
  Future<bool> isEnabled() async {
    final isEnabled = await _instance.isNfcEnabled();
    logInfo('Checked if NFC is enabled: $isEnabled');

    return isEnabled;
  }

  @override
  Stream<String> startDiscovery() => _instance.startDiscovery().map((tag) {
    logInfo('Discovered NFC tag: $tag');
    return tag;
  });

  @override
  Future<bool> sendCommand(domain.NfcCommand nfcCommand) async {
    final response = await _instance.sendCommand(
      CommandExtension.fromDomain(nfcCommand),
    );

    final result = switch (response) {
      ApduResponse.ok => true,
      _ => false,
    };
    logInfo('Sent NFC command with response: $result');

    return result;
  }
}

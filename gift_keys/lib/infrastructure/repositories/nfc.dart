import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:gift_keys/infrastructure/dtos/nfc/command.dart';
import 'package:gift_keys/injector.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class NfcRepository implements NfcApi {
  NfcRepository(this._nfcManager);

  final NfcManager _nfcManager;

  static final _loggerApi = Injector.instance.loggerApi;

  @override
  Future<bool> isEnabled() async {
    final isEnabled = await _nfcManager.isNfcEnabled();
    _loggerApi.logInfo('Checked if NFC is enabled: $isEnabled');

    return isEnabled;
  }

  @override
  Stream<String> startDiscovery() => _nfcManager.startDiscovery().map((tag) {
    _loggerApi.logInfo('Discovered NFC tag: $tag');
    return tag;
  });

  @override
  Future<bool> sendCommand(domain.NfcCommand nfcCommand) async {
    try {
      final response = await _nfcManager.sendCommand(
        CommandExtension.fromDomain(nfcCommand),
      );

      final result = switch (response) {
        ApduResponse.ok => true,
        _ => false,
      };
      _loggerApi.logInfo('Sent NFC command with response: $result');

      return result;
    } on NfcException catch (e, stackTrace) {
      _loggerApi.logException(
        'Sent NFC command failed.',
        exception: e,
        stackTrace: stackTrace,
      );

      return false;
    }
  }
}

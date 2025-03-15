import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:nfc_manager/nfc_manager.dart';

extension CommandExtension on Command {
  static Command fromDomain(domain.NfcCommand command) => switch (command) {
    domain.SelectAidCommand() => SelectAidCommandExtension.fromDomain(command),
    domain.VerifyPinCommand() => VerifyPinCommandExtension.fromDomain(command),
  };
}

extension SelectAidCommandExtension on SelectAidCommand {
  static SelectAidCommand fromDomain(domain.SelectAidCommand command) =>
      SelectAidCommand(command.data.toUint8List(isHex: true));
}

extension VerifyPinCommandExtension on VerifyPinCommand {
  static VerifyPinCommand fromDomain(domain.VerifyPinCommand command) =>
      VerifyPinCommand(command.data.toHexString().toUint8List());
}

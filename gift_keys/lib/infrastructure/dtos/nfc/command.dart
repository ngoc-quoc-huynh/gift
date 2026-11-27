import 'dart:convert';

import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:nfc_manager/nfc_manager.dart';

extension ApduCommandExtension on ApduCommand {
  static ApduCommand fromDomain(domain.NfcCommand command) => switch (command) {
    domain.SelectAidCommand(:final data) => ApduCommand.selectAid(
      data.hexToBytes(),
    ),
    domain.VerifyPinCommand(:final data) => ApduCommand.verifyPin(
      utf8.encode(utf8.encode(data).toHex()),
    ),
  };
}

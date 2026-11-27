import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:gift_keys/infrastructure/dtos/nfc/command.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  const aid = 'F000000001';
  final aidBytes = Uint8List.fromList([0xF0, 0x00, 0x00, 0x00, 0x01]);
  const password = '1234';
  final passwordBytes = Uint8List.fromList([
    0x33,
    0x31,
    0x33,
    0x32,
    0x33,
    0x33,
    0x33,
    0x34,
  ]);

  group('ApduCommandExtension', () {
    group('fromDomain', () {
      test(
        'returns correctly for SelectAidCommand.',
        () => expect(
          ApduCommandExtension.fromDomain(const domain.SelectAidCommand(aid)),
          ApduCommand.selectAid(aidBytes),
        ),
      );

      test(
        'returns correctly for VerifyPinCommand.',
        () => expect(
          ApduCommandExtension.fromDomain(
            const domain.VerifyPinCommand(password),
          ),
          ApduCommand.verifyPin(passwordBytes),
        ),
      );
    });
  });
}

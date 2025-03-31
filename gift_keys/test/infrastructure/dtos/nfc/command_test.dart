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

  group('CommandExtension', () {
    group('fromDomain', () {
      test(
        'return correctly for SelectAidCommandExtension.',
        () => expect(
          CommandExtension.fromDomain(const domain.SelectAidCommand(aid)),
          SelectAidCommand(aidBytes),
        ),
      );

      test(
        'return correctly for VerifyPinCommandExtension.',
        () => expect(
          CommandExtension.fromDomain(const domain.VerifyPinCommand(password)),
          VerifyPinCommand(passwordBytes),
        ),
      );
    });
  });

  group('SelectAidCommandExtension', () {
    group('fromDomain', () {
      test(
        'returns correctly.',
        () => expect(
          SelectAidCommandExtension.fromDomain(
            const domain.SelectAidCommand(aid),
          ),
          SelectAidCommand(aidBytes),
        ),
      );
    });
  });

  group('VerifyPinCommandExtension', () {
    test('returns correctly', () {
      expect(
        VerifyPinCommandExtension.fromDomain(
          const domain.VerifyPinCommand(password),
        ),
        VerifyPinCommand(passwordBytes),
      );
    });
  });
}

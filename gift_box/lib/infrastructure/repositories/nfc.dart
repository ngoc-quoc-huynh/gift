import 'dart:typed_data';

import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/domain/models/nfc_status.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class NfcRepository implements NfcApi {
  const NfcRepository();

  static final _instance = NfcManager();

  @override
  Future<bool> isEnabled() => _instance.isNfcEnabled();

  @override
  Stream<NfcStatus> startEmulation(Uint8List aid, Uint8List pin) =>
      _instance.startEmulation(aid: aid, pin: pin).map(
            (status) => switch (status) {
              HostCardEmulationStatus.invalidCommand ||
              HostCardEmulationStatus.invalidAid ||
              HostCardEmulationStatus.wrongPin ||
              HostCardEmulationStatus.functionNotSupported =>
                NfcStatus.error,
              HostCardEmulationStatus.pinVerified => NfcStatus.success,
              _ => NfcStatus.idle,
            },
          );
}

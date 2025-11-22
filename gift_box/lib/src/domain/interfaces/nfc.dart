import 'dart:typed_data';

import 'package:gift_box/src/domain/models/nfc_status.dart';

abstract interface class NfcApi {
  const NfcApi();

  Future<bool> isEnabled();

  Stream<NfcStatus> startEmulation(Uint8List aid, Uint8List pin);
}

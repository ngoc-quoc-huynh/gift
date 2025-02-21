import 'dart:typed_data';

import 'package:gift_box/domain/models/nfc_status.dart';

// ignore: one_member_abstracts, for potential future extensions.
abstract interface class NfcApi {
  const NfcApi();

  Stream<NfcStatus> startEmulation(Uint8List aid, Uint8List pin);
}

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_satisfactory/domain/interfaces/nfc.dart';
import 'package:gift_box_satisfactory/domain/models/nfc_status.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final aid = Uint8List(0);
  final pin = Uint8List(0);
  final nfcApi = MockNfcApi();

  setUpAll(
    () => Injector.instance
      ..registerAid(aid)
      ..registerPin(pin)
      ..registerSingleton<NfcApi>(nfcApi),
  );

  tearDownAll(Injector.instance.reset);

  when(
    () => nfcApi.startEmulation(aid, pin),
  ).thenAnswer((_) => const Stream<NfcStatus>.empty());

  // TODO: Currently no possible to test due to this issue: https://github.com/rive-app/rive-flutter/issues/354
}

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/domain/models/nfc_status.dart';
import 'package:gift_box/injector.dart';
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
      ..registerSingleton<NfcApi>(nfcApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  when(
    () => nfcApi.startEmulation(aid, pin),
  ).thenAnswer((_) => const Stream<NfcStatus>.empty());

  // TODO: Currently no possible to test due to this issue: https://github.com/rive-app/rive-flutter/issues/354
}

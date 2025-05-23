import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/gift/nfc_status.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

Future<void> main() async {
  final nfcApi = MockNfcApi();

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<NfcApi>(nfcApi)
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  when(nfcApi.isEnabled).thenAnswer((_) async => true);

  await goldenTest(
    'renders correctly.',
    fileName: 'nfc_status',
    builder: () => const GiftNfcStatus(),
  );
}

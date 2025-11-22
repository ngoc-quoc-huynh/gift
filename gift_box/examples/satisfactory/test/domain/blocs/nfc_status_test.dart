import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/gift_box.dart';
import 'package:gift_box_satisfactory/domain/blocs/nfc_status/bloc.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  final nfcApi = MockNfcApi();

  setUpAll(() => Injector.instance.registerSingleton<NfcApi>(nfcApi));

  tearDownAll(Injector.instance.reset);

  test(
    'initial state is NfcStatusLoadInProgress.',
    () => expect(NfcStatusBloc().state, const NfcStatusLoadInProgress()),
  );

  group('NfcStatusCheckEvent', () {
    blocTest<NfcStatusBloc, NfcStatusState>(
      'emits NfcStatusLoadOnSuccess with isEnabled true.',
      setUp: () => when(nfcApi.isEnabled).thenAnswer((_) async => true),
      build: NfcStatusBloc.new,
      act: (bloc) => bloc.add(const NfcStatusCheckEvent()),
      expect: () => const [NfcStatusLoadOnSuccess(isEnabled: true)],
      verify: (_) => verify(nfcApi.isEnabled).called(1),
    );

    blocTest<NfcStatusBloc, NfcStatusState>(
      'emits NfcStatusLoadOnSuccess with isEnabled false.',
      setUp: () => when(nfcApi.isEnabled).thenAnswer((_) async => false),
      build: NfcStatusBloc.new,
      act: (bloc) => bloc.add(const NfcStatusCheckEvent()),
      expect: () => const [NfcStatusLoadOnSuccess(isEnabled: false)],
      verify: (_) => verify(nfcApi.isEnabled).called(1),
    );
  });
}

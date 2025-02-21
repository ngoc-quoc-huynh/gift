import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/gift_box/bloc.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/domain/models/nfc_status.dart';
import 'package:gift_box/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  final aid = Uint8List(0);
  final pin = Uint8List(0);
  final nfcApi = MockNfcApi();

  setUpAll(
    () => Injector.instance.registerSingleton<NfcApi>(nfcApi),
  );

  tearDownAll(Injector.instance.unregister<NfcApi>);

  test(
    'initial state is GiftBoxIdle.',
    () => expect(
      GiftBoxBloc(aid: aid, pin: pin).state,
      const GiftBoxIdle(),
    ),
  );

  group('GiftBoxInitializeEvent', () {
    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxOpenWrongEvent when NfcStatus is error.',
      setUp: () {
        when(() => nfcApi.startEmulation(aid, pin)).thenAnswer(
          (_) => Stream.value(NfcStatus.error),
        );
      },
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxInitializeEvent()),
      expect: () => const [
        GiftBoxOpenOnFailure(),
        GiftBoxIdle(),
      ],
      verify: (_) => verify(() => nfcApi.startEmulation(aid, pin)).called(1),
    );

    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxOpenWrongEvent when NfcStatus is idle.',
      setUp: () {
        when(() => nfcApi.startEmulation(aid, pin)).thenAnswer(
          (_) => Stream.value(NfcStatus.idle),
        );
      },
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxInitializeEvent()),
      expect: () => const [GiftBoxIdle()],
      verify: (_) => verify(() => nfcApi.startEmulation(aid, pin)).called(1),
    );

    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxOpenCorrectEvent when NfcStatus is success.',
      setUp: () {
        when(() => nfcApi.startEmulation(aid, pin)).thenAnswer(
          (_) => Stream.value(NfcStatus.success),
        );
      },
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxInitializeEvent()),
      expect: () => const [
        GiftBoxOpenOnSuccess(),
        GiftBoxIdle(),
      ],
      verify: (_) => verify(() => nfcApi.startEmulation(aid, pin)).called(1),
    );
  });

  group('GiftBoxOpenCorrectEvent', () {
    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxOpenOnSuccess.',
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxOpenCorrectEvent()),
      expect: () => const [
        GiftBoxOpenOnSuccess(),
        GiftBoxIdle(),
      ],
    );
  });

  group('GiftBoxOpenWrongEvent', () {
    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxOpenOnFailure.',
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxOpenWrongEvent()),
      expect: () => const [
        GiftBoxOpenOnFailure(),
        GiftBoxIdle(),
      ],
    );
  });

  group('GiftBoxIdleEvent', () {
    blocTest<GiftBoxBloc, GiftBoxState>(
      'emits GiftBoxIdle.',
      build: () => GiftBoxBloc(aid: aid, pin: pin),
      act: (bloc) => bloc.add(const GiftBoxIdleEvent()),
      expect: () => const [GiftBoxIdle()],
    );
  });
}

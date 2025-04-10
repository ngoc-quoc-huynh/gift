import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should not be awaited.

void main() {
  final nfcApi = MockNfcApi();
  const aid = 'F000000001';
  const password = '1234';

  setUpAll(() => Injector.instance.registerSingleton<NfcApi>(nfcApi));

  tearDownAll(Injector.instance.reset);

  test(
    'initial state is KeyFormInitial.',
    () => expect(NfcDiscoveryBloc().state, const NfcDiscoveryLoadInProgress()),
  );

  group('NfcDiscoveryInitializeEvent', () {
    blocTest<NfcDiscoveryBloc, NfcDiscoveryState>(
      'emits NfcDiscoveryConnectInProgress.',
      setUp:
          () => when(
            nfcApi.startDiscovery,
          ).thenAnswer((_) => const Stream<String>.empty()),
      build: NfcDiscoveryBloc.new,
      act:
          (bloc) => bloc.add(
            const NfcDiscoveryInitializeEvent(aid: aid, password: password),
          ),
      expect:
          () => const [
            NfcDiscoveryLoadInProgress(),
            NfcDiscoveryConnectInProgress(aid, password),
          ],
      verify: (_) => verify(nfcApi.startDiscovery).called(1),
    );

    blocTest<NfcDiscoveryBloc, NfcDiscoveryState>(
      'emits NfcDiscoveryConnectOnSuccess when Stream emits a tag.',
      setUp: () {
        when(nfcApi.startDiscovery).thenAnswer((_) => Stream.value('tag'));
        when(
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
        ).thenAnswer((_) async => true);
        when(
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ).thenAnswer((_) async => true);
      },
      build: NfcDiscoveryBloc.new,
      act:
          (bloc) => bloc.add(
            const NfcDiscoveryInitializeEvent(aid: aid, password: password),
          ),
      expect:
          () => const [
            NfcDiscoveryLoadInProgress(),
            NfcDiscoveryConnectInProgress(aid, password),
            NfcDiscoveryConnectOnSuccess(aid, password),
          ],
      verify: (_) {
        final verifications = verifyInOrder([
          nfcApi.startDiscovery,
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );
  });

  group('NfcDiscoverySendCommandEvent', () {
    blocTest<NfcDiscoveryBloc, NfcDiscoveryState>(
      'emits NfcDiscoveryConnectOnSuccess.',
      setUp: () {
        when(
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
        ).thenAnswer((_) async => true);
        when(
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ).thenAnswer((_) async => true);
      },
      build: NfcDiscoveryBloc.new,
      seed: () => const NfcDiscoveryConnectInProgress(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoverySendCommandEvent()),
      expect: () => const [NfcDiscoveryConnectOnSuccess(aid, password)],
      verify: (_) {
        final verifications = verifyInOrder([
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );

    blocTest<NfcDiscoveryBloc, NfcDiscoveryState>(
      'emits NfcDiscoveryConnectOnFailure when select fails.',
      setUp:
          () => when(
            () => nfcApi.sendCommand(const SelectAidCommand(aid)),
          ).thenAnswer((_) async => false),
      build: NfcDiscoveryBloc.new,
      seed: () => const NfcDiscoveryConnectInProgress(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoverySendCommandEvent()),
      expect: () => const [NfcDiscoveryConnectOnFailure(aid, password)],
      verify: (_) {
        verify(() => nfcApi.sendCommand(const SelectAidCommand(aid))).called(1);
        verifyNever(() => nfcApi.sendCommand(const VerifyPinCommand(password)));
      },
    );

    blocTest<NfcDiscoveryBloc, NfcDiscoveryState>(
      'emits NfcDiscoveryConnectOnFailure when verify fails.',
      setUp: () {
        when(
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
        ).thenAnswer((_) async => true);
        when(
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ).thenAnswer((_) async => false);
      },
      build: NfcDiscoveryBloc.new,
      seed: () => const NfcDiscoveryConnectInProgress(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoverySendCommandEvent()),
      expect: () => const [NfcDiscoveryConnectOnFailure(aid, password)],
      verify: (_) {
        final verifications = verifyInOrder([
          () => nfcApi.sendCommand(const SelectAidCommand(aid)),
          () => nfcApi.sendCommand(const VerifyPinCommand(password)),
        ]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );
  });

  group('NfcDiscoveryPauseEvent', () {
    blocTest(
      'emits nothing if state is NfcDiscoveryConnectOnSuccess.',
      build: NfcDiscoveryBloc.new,
      seed: () => const NfcDiscoveryConnectOnSuccess(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoveryPauseEvent()),
      expect: () => const <NfcDiscoveryState>[],
    );

    final sub = MockStreamSubscription<String>();
    blocTest(
      'emits nothing if state is NfcDiscoveryConnectInProgress.',
      setUp: () {
        when(sub.pause).thenAnswer((_) => Future<void>.value());
        when(sub.cancel).thenAnswer((_) => Future<void>.value());
      },
      build: () => NfcDiscoveryBloc()..sub = sub,
      seed: () => const NfcDiscoveryConnectInProgress(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoveryPauseEvent()),
      expect: () => const <NfcDiscoveryState>[],
      verify: (bloc) {
        final verifications = verifyInOrder([sub.pause, sub.cancel]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );
  });

  group('NfcDiscoveryResumeEvent', () {
    blocTest(
      'emits nothing if state is NfcDiscoveryConnectOnSuccess.',
      build: NfcDiscoveryBloc.new,
      seed: () => const NfcDiscoveryConnectOnSuccess(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoveryResumeEvent()),
      expect: () => const <NfcDiscoveryState>[],
    );

    final sub = MockStreamSubscription<String>();
    blocTest(
      'emits nothing if state is NfcDiscoveryConnectInProgress.',
      setUp: () {
        when(sub.resume).thenAnswer((_) => Future<void>.value());
        when(sub.cancel).thenAnswer((_) => Future<void>.value());
      },
      build: () => NfcDiscoveryBloc()..sub = sub,
      seed: () => const NfcDiscoveryConnectInProgress(aid, password),
      act: (bloc) => bloc.add(const NfcDiscoveryResumeEvent()),
      expect: () => const <NfcDiscoveryState>[],
      verify: (bloc) {
        final verifications = verifyInOrder([sub.resume, sub.cancel]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );
  });
}

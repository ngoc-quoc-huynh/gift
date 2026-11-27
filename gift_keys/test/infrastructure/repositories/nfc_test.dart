import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart' as domain;
import 'package:gift_keys/infrastructure/repositories/nfc.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../mocks.dart';

void main() {
  final nfcManager = MockNfcManager();
  final loggerApi = MockLoggerApi();
  final repository = NfcRepository(nfcManager);

  setUpAll(
    () => Injector.instance
      ..registerSingleton<NfcApi>(NfcRepository(nfcManager))
      ..registerSingleton<LoggerApi>(loggerApi),
  );

  tearDownAll(Injector.instance.reset);

  group('isEnabled', () {
    test('returns true correctly.', () async {
      when(nfcManager.isNfcEnabled).thenAnswer((_) async => true);

      final result = await repository.isEnabled();

      expect(result, isTrue);
      verify(nfcManager.isNfcEnabled).called(1);
      verify(() => loggerApi.logInfo(any())).called(1);
    });

    test('returns false correctly.', () async {
      when(nfcManager.isNfcEnabled).thenAnswer((_) async => false);

      final result = await repository.isEnabled();

      expect(result, isFalse);
      verify(nfcManager.isNfcEnabled).called(1);
      verify(() => loggerApi.logInfo(any())).called(1);
    });
  });

  group('startDiscovery', () {
    test('emits nothing if no tags are discovered.', () async {
      when(nfcManager.startDiscovery).thenAnswer((_) => const Stream.empty());

      await expectLater(repository.startDiscovery(), emitsInOrder([]));
      verify(nfcManager.startDiscovery).called(1);
      verifyNever(() => loggerApi.logInfo(any()));
    });

    test('emits correctly when tags are discovered.', () async {
      when(
        nfcManager.startDiscovery,
      ).thenAnswer((_) => Stream.fromIterable(['tag1']));

      await expectLater(repository.startDiscovery(), emitsInOrder(['tag1']));
      verify(nfcManager.startDiscovery).called(1);
      verify(() => loggerApi.logInfo(any())).called(1);
    });
  });

  group('sendCommand', () {
    const aid = 'F000000001';

    test('returns true if response is ok.', () async {
      when(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).thenAnswer(
        (_) async =>
            ApduResponse.fromUint8List(Uint8List.fromList([0x90, 0x00])),
      );

      final result = await repository.sendCommand(
        const domain.SelectAidCommand(aid),
      );

      expect(result, isTrue);
      verify(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).called(1);
      verify(() => loggerApi.logInfo(any())).called(1);
    });

    test('returns false if response is not ok.', () async {
      when(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).thenAnswer(
        (_) async =>
            ApduResponse.fromUint8List(Uint8List.fromList([0x6A, 0x82])),
      );

      final result = await repository.sendCommand(
        const domain.SelectAidCommand(aid),
      );

      expect(result, isFalse);
      verify(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).called(1);
      verify(() => loggerApi.logInfo(any())).called(1);
    });

    test('returns false if NfcException is thrown.', () async {
      when(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).thenThrow(const TagConnectionException());

      final result = await repository.sendCommand(
        const domain.SelectAidCommand(aid),
      );

      expect(result, isFalse);
      verify(
        () => nfcManager.sendCommand(
          ApduCommand.selectAid(aid.hexToBytes()),
        ),
      ).called(1);
      verify(
        () => loggerApi.logException(
          any(),
          exception: const TagConnectionException(),
          stackTrace: any(named: 'stackTrace'),
        ),
      ).called(1);
    });
  });
}

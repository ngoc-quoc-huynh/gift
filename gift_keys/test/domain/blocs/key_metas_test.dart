import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should not be awaited.
void main() {
  final fileApi = MockFileApi();
  final localDatabaseApi = MockLocalDatabaseApi();

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<FileApi>(fileApi)
          ..registerSingleton<LocalDatabaseApi>(localDatabaseApi),
  );

  tearDownAll(Injector.instance.reset);

  test(
    'initial state is KeyMetasLoadInProgress.',
    () => expect(KeyMetasBloc().state, const KeyMetasLoadInProgress()),
  );

  group('KeyMetasInitializeEvent', () {
    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits KeyMetasLoadOnSuccess sorted correctly.',
      setUp:
          () => when(localDatabaseApi.loadKeyMetas).thenAnswer(
            (_) async => [
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
              GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
            ],
          ),
      build: KeyMetasBloc.new,
      act: (bloc) => bloc.add(const KeyMetasInitializeEvent()),
      expect:
          () => [
            const KeyMetasLoadInProgress(),
            KeyMetasLoadOnSuccess([
              GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ]),
          ],
      verify: (_) => verify(localDatabaseApi.loadKeyMetas).called(1),
    );

    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits KeyMetasLoadOnFailure when LocalDatabaseException is thrown.',
      setUp:
          () => when(
            localDatabaseApi.loadKeyMetas,
          ).thenThrow(const LocalDatabaseException()),
      build: KeyMetasBloc.new,
      act: (bloc) => bloc.add(const KeyMetasInitializeEvent()),
      expect: () => const [KeyMetasLoadInProgress(), KeyMetasLoadOnFailure()],
      verify: (_) => verify(localDatabaseApi.loadKeyMetas).called(1),
    );
  });

  group('KeyMetasAddEvent', () {
    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits nothing when state is KeyMetasLoadInProgress.',
      build: KeyMetasBloc.new,
      act:
          (bloc) => bloc.add(
            KeyMetasAddEvent(
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ),
          ),
      expect: () => const <KeyMetasState>[],
    );

    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits KeyMetasLoadOnSuccess sorted correctly.',
      build: KeyMetasBloc.new,
      seed:
          () => KeyMetasLoadOnSuccess([
            GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
          ]),
      act:
          (bloc) => bloc.add(
            KeyMetasAddEvent(
              GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
            ),
          ),
      expect:
          () => [
            KeyMetasAddOnSuccess(0, [
              GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ]),
          ],
    );
  });

  group('KeyMetasDeleteEvent', () {
    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits nothing when state is KeyMetasLoadInProgress.',
      build: KeyMetasBloc.new,
      act: (bloc) => bloc.add(const KeyMetasDeleteEvent(1)),
      expect: () => const <KeyMetasState>[],
    );

    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits KeyMetasDeleteOnSuccess.',
      build: KeyMetasBloc.new,
      seed:
          () => KeyMetasLoadOnSuccess([
            GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
          ]),
      act: (bloc) => bloc.add(const KeyMetasDeleteEvent(1)),
      expect: () => const [KeyMetasDeleteOnSuccess([])],
    );
  });

  group('KeyMetasUpdateEvent', () {
    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits nothing when state is KeyMetasLoadInProgress.',
      build: KeyMetasBloc.new,
      act:
          (bloc) => bloc.add(
            KeyMetasUpdateEvent(
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ),
          ),
      expect: () => const <KeyMetasState>[],
    );

    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits KeyMetasUpdateOnSuccess.',
      build: KeyMetasBloc.new,
      seed:
          () => KeyMetasLoadOnSuccess([
            GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
          ]),
      act:
          (bloc) => bloc.add(
            KeyMetasUpdateEvent(
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025, 3)),
            ),
          ),
      expect:
          () => [
            KeyMetasUpdateOnSuccess(0, [
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025, 3)),
              GiftKeyMeta(id: 2, name: 'Name', birthday: DateTime.utc(2025, 2)),
            ]),
          ],
    );
  });

  group('KeyMetasResetEvent', () {
    blocTest<KeyMetasBloc, KeyMetasState>(
      'emits nothing when state is KeyMetasLoadInProgress.',
      build: KeyMetasBloc.new,
      act: (bloc) => bloc.add(const KeyMetasResetEvent()),
      expect: () => const <KeyMetasState>[],
    );

    blocTest(
      'emits KeyMetasLoadOnSuccess.',
      setUp: () {
        when(
          localDatabaseApi.deleteKeys,
        ).thenAnswer((_) => Future<void>.value());
        when(fileApi.deleteAllImages).thenAnswer((_) => Future<void>.value());
      },
      build: KeyMetasBloc.new,
      seed:
          () => KeyMetasLoadOnSuccess([
            GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
          ]),
      act: (bloc) => bloc.add(const KeyMetasResetEvent()),
      expect: () => const [KeyMetasLoadInProgress(), KeyMetasLoadOnSuccess([])],
      verify: (_) {
        final verifications = verifyInOrder([
          localDatabaseApi.deleteKeys,
          fileApi.deleteAllImages,
        ]);
        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );

    blocTest(
      'emits KeyMetasResetOnFailure when LocalDatabaseException is thrown.',
      build: KeyMetasBloc.new,
      setUp:
          () => when(
            localDatabaseApi.deleteKeys,
          ).thenThrow(const LocalDatabaseException()),
      act: (bloc) => bloc.add(const KeyMetasResetEvent()),
      seed:
          () => KeyMetasLoadOnSuccess([
            GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
          ]),
      expect:
          () => [
            const KeyMetasLoadInProgress(),
            KeyMetasResetOnFailure([
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ]),
          ],
      verify: (_) {
        verify(localDatabaseApi.deleteKeys).called(1);
        verifyNever(fileApi.deleteAllImages);
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should not be awaited.

void main() {
  final fileApi = MockFileAPi();
  final localDatabaseApi = MockLocalDatabaseApi();

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<FileApi>(fileApi)
          ..registerSingleton<LocalDatabaseApi>(localDatabaseApi),
  );

  tearDownAll(Injector.instance.reset);

  test(
    'initial state is KeyFormInitial.',
    () => expect(KeyFormBloc().state, const KeyFormInitial()),
  );

  group('KeyFormAddEvent', () {
    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormLoadOnSuccess.',
      setUp: () {
        when(
          () => localDatabaseApi.saveKey(
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
        ).thenAnswer(
          (_) async =>
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
        );
        when(
          () => fileApi.moveFileToAppDir('test.webp', 1),
        ).thenAnswer((_) => Future<void>.value());
      },
      build: KeyFormBloc.new,
      act:
          (bloc) => bloc.add(
            KeyFormAddEvent(
              imagePath: 'test.webp',
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ),
      expect:
          () => [
            const KeyFormLoadInProgress(),
            KeyFormLoadOnSuccess(
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ),
          ],
      verify: (_) {
        final verifications = verifyInOrder([
          () => localDatabaseApi.saveKey(
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
          () => fileApi.moveFileToAppDir('test.webp', 1),
        ]);

        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );

    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormLoadOnFailure when LocalDatabaseException is thrown.',
      setUp:
          () => when(
            () => localDatabaseApi.saveKey(
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ).thenThrow(const LocalDatabaseException()),
      build: KeyFormBloc.new,
      act:
          (bloc) => bloc.add(
            KeyFormAddEvent(
              imagePath: 'test.webp',
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ),
      expect: () => const [KeyFormLoadInProgress(), KeyFormLoadOnFailure()],
      verify: (_) {
        verify(
          () => localDatabaseApi.saveKey(
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
        );
        verifyNever(() => fileApi.moveFileToAppDir('test.webp', 1));
      },
    );
  });

  group('KeyFormUpdateEvent', () {
    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormLoadOnSuccess.',
      setUp: () {
        when(
          () => localDatabaseApi.updateKey(
            id: 1,
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
        ).thenAnswer(
          (_) async =>
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
        );
        when(
          () => fileApi.moveFileToAppDir('test.webp', 1),
        ).thenAnswer((_) => Future<void>.value());
      },
      build: KeyFormBloc.new,
      act:
          (bloc) => bloc.add(
            KeyFormUpdateEvent(
              id: 1,
              imagePath: 'test.webp',
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ),
      expect:
          () => [
            const KeyFormLoadInProgress(),
            KeyFormLoadOnSuccess(
              GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime.utc(2025)),
            ),
          ],
      verify: (_) {
        final verifications = verifyInOrder([
          () => localDatabaseApi.updateKey(
            id: 1,
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
          () => fileApi.moveFileToAppDir('test.webp', 1),
        ]);

        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );

    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormLoadOnFailure when LocalDatabaseException is thrown.',
      setUp: () {
        when(
          () => localDatabaseApi.updateKey(
            id: 1,
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
        ).thenThrow(const LocalDatabaseException());
      },
      build: KeyFormBloc.new,
      act:
          (bloc) => bloc.add(
            KeyFormUpdateEvent(
              id: 1,
              imagePath: 'test.webp',
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ),
      expect: () => const [KeyFormLoadInProgress(), KeyFormLoadOnFailure()],
      verify: (_) {
        verify(
          () => localDatabaseApi.updateKey(
            id: 1,
            name: 'Name',
            birthday: DateTime.utc(2025),
            aid: 'F000000001',
            password: '1234',
          ),
        );
        verifyNever(() => fileApi.moveFileToAppDir('test.webp', 1));
      },
    );
  });

  group('KeyFormDeleteEvent', () {
    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormDeleteOnSuccess.',
      setUp: () {
        when(
          () => localDatabaseApi.deleteKey(1),
        ).thenAnswer((_) => Future<void>.value());
        when(
          () => fileApi.deleteImage(1),
        ).thenAnswer((_) => Future<void>.value());
      },
      build: KeyFormBloc.new,
      act: (bloc) => bloc.add(const KeyFormDeleteEvent(1)),
      expect: () => const [KeyFormLoadInProgress(), KeyFormDeleteOnSuccess(1)],
      verify: (_) {
        final verifications = verifyInOrder([
          () => localDatabaseApi.deleteKey(1),
          () => fileApi.deleteImage(1),
        ]);

        for (final verification in verifications) {
          verification.called(1);
        }
      },
    );

    blocTest<KeyFormBloc, KeyFormState>(
      'emits KeyFormLoadOnFailure when LocalDatabaseException is thrown.',
      setUp:
          () => when(
            () => localDatabaseApi.deleteKey(1),
          ).thenThrow(const LocalDatabaseException()),
      build: KeyFormBloc.new,
      act: (bloc) => bloc.add(const KeyFormDeleteEvent(1)),
      expect: () => const [KeyFormLoadInProgress(), KeyFormLoadOnFailure()],
      verify: (_) {
        verify(() => localDatabaseApi.deleteKey(1));
        verifyNever(() => fileApi.deleteImage(1));
      },
    );
  });
}

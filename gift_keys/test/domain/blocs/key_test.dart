import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should not be awaited.
void main() {
  final localDatabaseApi = MockLocalDatabaseApi();
  const id = 1;

  setUpAll(
    () =>
        Injector.instance.registerSingleton<LocalDatabaseApi>(localDatabaseApi),
  );

  tearDownAll(Injector.instance.reset);

  test(
    'initial state is KeyLoadInProgress.',
    () => expect(KeyBloc(id).state, const KeyLoadInProgress()),
  );

  group('KeyInitializeEvent', () {
    blocTest<KeyBloc, KeyState>(
      'emits KeyLoadOnSuccess.',
      setUp:
          () => when(() => localDatabaseApi.loadKey(id)).thenAnswer(
            (_) async => GiftKey(
              id: id,
              name: 'Name',
              birthday: DateTime.utc(2025),
              aid: 'F000000001',
              password: '1234',
            ),
          ),
      build: () => KeyBloc(id),
      act: (bloc) => bloc.add(const KeyInitializeEvent()),
      expect:
          () => [
            const KeyLoadInProgress(),
            KeyLoadOnSuccess(
              GiftKey(
                id: id,
                name: 'Name',
                birthday: DateTime.utc(2025),
                aid: 'F000000001',
                password: '1234',
              ),
            ),
          ],
      verify: (_) => verify(() => localDatabaseApi.loadKey(id)).called(1),
    );

    blocTest<KeyBloc, KeyState>(
      'emits KeyLoadOnFailure when LocalDatabaseException is thrown.',
      setUp:
          () => when(
            () => localDatabaseApi.loadKey(id),
          ).thenThrow(const LocalDatabaseException()),
      build: () => KeyBloc(id),
      act: (bloc) => bloc.add(const KeyInitializeEvent()),
      expect: () => const [KeyLoadInProgress(), KeyLoadOnFailure()],
      verify: (_) => verify(() => localDatabaseApi.loadKey(id)).called(1),
    );
  });
}

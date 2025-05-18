import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should not be awaited.
void main() {
  final storage = MockStorage();

  setUpAll(() {
    when(
      // ignore: avoid-dynamic, since it is the method signature.
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) => Future.value());
    HydratedBloc.storage = storage;
  });

  tearDownAll(() => HydratedBloc.storage = null);

  group('HydratedBoolCubit', () {
    test(
      'initial state is provided state.',
      () => expect(
        HydratedBoolCubit(initialState: false, storageKey: 'test').state,
        isFalse,
      ),
    );

    group('update', () {
      blocTest<HydratedBoolCubit, bool>(
        'emits new state correctly.',
        build: () => HydratedBoolCubit(initialState: false, storageKey: 'test'),
        act: (cubit) => cubit.update(true),
        expect: () => [true],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedBoolCubit(
          initialState: false,
          storageKey: 'test',
        ).fromJson({'test': false});
        expect(result, isFalse);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedBoolCubit(
          initialState: false,
          storageKey: 'test',
        ).toJson(false);
        expect(result, {'test': false});
      });
    });
  });
}

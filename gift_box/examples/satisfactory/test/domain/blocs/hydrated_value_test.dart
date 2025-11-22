import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_satisfactory/domain/blocs/hydrated_value/cubit.dart';
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

  group('HydratedValueCubit', () {
    const storageKey = 'bool';

    test(
      'initial state is provided state.',
      () => expect(
        HydratedBoolCubit(initialState: false, storageKey: storageKey).state,
        isFalse,
      ),
    );

    group('update', () {
      blocTest<HydratedBoolCubit, bool>(
        'emits new state correctly.',
        build: () =>
            HydratedBoolCubit(initialState: false, storageKey: storageKey),
        act: (cubit) => cubit.update(true),
        expect: () => [true],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedBoolCubit(
          initialState: false,
          storageKey: storageKey,
        ).fromJson({storageKey: false});

        expect(result, isFalse);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedBoolCubit(
          initialState: false,
          storageKey: storageKey,
        ).toJson(false);

        expect(result, {storageKey: false});
      });
    });
  });

  group('HydratedEnumCubit', () {
    const storageKey = 'theme_mode';

    test(
      'initial state is provided state.',
      () => expect(
        HydratedThemeModeCubit(
          initialState: ThemeMode.system,
          storageKey: storageKey,
          values: ThemeMode.values,
        ).state,
        ThemeMode.system,
      ),
    );

    group('update', () {
      blocTest<HydratedThemeModeCubit, ThemeMode>(
        'emits new state correctly.',
        build: () => HydratedThemeModeCubit(
          initialState: ThemeMode.system,
          storageKey: storageKey,
          values: ThemeMode.values,
        ),
        act: (cubit) => cubit.update(ThemeMode.dark),
        expect: () => [ThemeMode.dark],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedThemeModeCubit(
          initialState: ThemeMode.system,
          storageKey: storageKey,
          values: ThemeMode.values,
        ).fromJson({storageKey: ThemeMode.system.name});

        expect(result, ThemeMode.system);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedThemeModeCubit(
          initialState: ThemeMode.system,
          storageKey: storageKey,
          values: ThemeMode.values,
        ).toJson(ThemeMode.system);

        expect(result, {storageKey: ThemeMode.system.name});
      });
    });
  });
}

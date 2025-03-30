import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
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

  group('LanguageOptionHydratedValueCubit', () {
    test(
      'initial state is LanguageOption.system.',
      () => expect(
        LanguageOptionHydratedValueCubit().state,
        LanguageOption.system,
      ),
    );

    group('update', () {
      blocTest<LanguageOptionHydratedValueCubit, LanguageOption>(
        'emits new state correctly.',
        build: LanguageOptionHydratedValueCubit.new,
        act: (cubit) => cubit.update(LanguageOption.english),
        expect: () => [LanguageOption.english],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = LanguageOptionHydratedValueCubit().fromJson({
          'option': 'english',
        });
        expect(result, LanguageOption.english);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = LanguageOptionHydratedValueCubit().toJson(
          LanguageOption.system,
        );
        expect(result, {'option': 'system'});
      });
    });
  });

  group('ThemeModeHydratedValueCubit', () {
    test(
      'initial state is ThemeMode.system.',
      () => expect(ThemeModeHydratedValueCubit().state, ThemeMode.system),
    );

    group('update', () {
      blocTest<ThemeModeHydratedValueCubit, ThemeMode>(
        'emits new state correctly..',
        build: ThemeModeHydratedValueCubit.new,
        act: (cubit) => cubit.update(ThemeMode.dark),
        expect: () => [ThemeMode.dark],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = ThemeModeHydratedValueCubit().fromJson({
          'theme_mode': 'dark',
        });
        expect(result, ThemeMode.dark);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = ThemeModeHydratedValueCubit().toJson(ThemeMode.system);
        expect(result, {'theme_mode': 'system'});
      });
    });
  });
}

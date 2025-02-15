import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/countdown/cubit.dart';
import 'package:gift_box/injector.dart';

import '../../utils.dart';

// ignore_for_file: discarded_futures, testBloc do not need to be awaited here.

void main() {
  final birthday = DateTime(2025);

  test(
    'initial state is CountdownLoadInProgress',
    () => expect(
      CountdownCubit(birthday).state,
      const CountdownLoadInProgress(),
    ),
  );

  group('init', () {
    blocTest<CountdownCubit, CountdownState>(
      'emits nothing nothing when timer is not started.',
      setUp: Injector.instance.registerPeriodicTimer,
      tearDown: Injector.instance.unregister<Timer>,
      build: () => CountdownCubit(birthday)..init(),
      expect: () => const <CountdownState>[],
    );

    // ignore_for_file: missing-test-assertion
    test(
      'emits CountdownRunning when countdown starts',
      () => withClock<void>(
        Clock.fixed(DateTime(2024, 12, 31)),
        () => testBloc<CountdownCubit, CountdownState>(
          setUp: Injector.instance.registerPeriodicTimer,
          tearDown: Injector.instance.unregister<Timer>,
          build: () => CountdownCubit(birthday)..init(),
          wait: const Duration(seconds: 1),
          expect: () => const [CountdownRunning(Duration(hours: 24))],
        ),
      ),
    );

    test(
      'emits CountdownRunning when countdown starts',
      () => withClock<void>(
        Clock.fixed(DateTime(2025)),
        () => testBloc<CountdownCubit, CountdownState>(
          setUp: Injector.instance.registerPeriodicTimer,
          tearDown: Injector.instance.unregister<Timer>,
          build: () => CountdownCubit(birthday)..init(),
          wait: const Duration(seconds: 1),
          expect: () => const [CountdownFinished()],
        ),
      ),
    );
  });
}

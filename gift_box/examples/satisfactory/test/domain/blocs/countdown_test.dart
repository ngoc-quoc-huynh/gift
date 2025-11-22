import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/countdown/cubit.dart';
import 'package:gift_box/injector.dart';

import '../../utils.dart';

// ignore_for_file: discarded_futures, testBloc do not need to be awaited here.
// ignore_for_file: missing-test-assertion, withClock is used alongside
// blocTest, ensuring proper assertions.

void main() {
  final birthday = DateTime(2025);

  test(
    'initial state is CountdownLoadInProgress',
    () =>
        expect(CountdownCubit(birthday).state, const CountdownLoadInProgress()),
  );

  group('init', () {
    test(
      'emits CountdownFinished when timer is not started but countdown is '
      'reached.',
      () => withClock<void>(
        Clock.fixed(birthday),
        () => testBloc<CountdownCubit, CountdownState>(
          setUp: Injector.instance.registerPeriodicTimer,
          tearDown: Injector.instance.unregister<Timer>,
          build: () => CountdownCubit(birthday),
          act: (cubit) => cubit.init(),
          expect: () => const [CountdownFinished()],
        ),
      ),
    );

    test(
      'emits CountdownRunning when timer is not started and countdown is not '
      'reached.',
      () => withClock<void>(
        Clock.fixed(DateTime(2024, 12, 31)),
        () => testBloc<CountdownCubit, CountdownState>(
          setUp: Injector.instance.registerPeriodicTimer,
          tearDown: Injector.instance.unregister<Timer>,
          build: () => CountdownCubit(birthday),
          act: (cubit) => cubit.init(),
          expect: () => const [CountdownRunning(Duration(days: 1))],
        ),
      ),
    );
  });
}

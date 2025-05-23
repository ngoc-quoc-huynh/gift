import 'package:alchemist/alchemist.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/timer/countdown.dart';

import '../../../utils.dart';

Future<void> main() async {
  setUpAll(
    () =>
        Injector.instance
          ..registerBirthday(DateTime(2025))
          ..registerPeriodicTimer()
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  await goldenTest(
    'renders initial correctly.',
    fileName: 'countdown_initial',
    pumpWidget:
        (tester, widget) => withClock(
          Clock.fixed(DateTime(2025)),
          () => tester.pumpWidget(widget),
        ),
    builder: TimerCountdown.new,
    // TODO: Fix me
    skip: true,
  );

  await goldenTest(
    'renders end correctly.',
    fileName: 'countdown_end',
    pumpBeforeTest: (tester) => tester.pump(const Duration(seconds: 1)),
    pumpWidget:
        (tester, widget) => withClock(
          Clock.fixed(DateTime(2025)),
          () => tester.pumpWidget(widget),
        ),
    builder: TimerCountdown.new,
    // TODO: Fix me
    skip: true,
  );

  await goldenTest(
    'renders running correctly.',
    fileName: 'countdown_running',
    pumpBeforeTest: (tester) => tester.pump(const Duration(seconds: 1)),
    pumpWidget:
        (tester, widget) => withClock(
          Clock.fixed(DateTime(2024, 12, 31)),
          () => tester.pumpWidget(widget),
        ),
    builder: TimerCountdown.new,
    // TODO: Fix me
    skip: true,
  );
}

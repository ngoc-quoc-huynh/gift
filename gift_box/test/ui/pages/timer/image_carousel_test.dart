import 'dart:math';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/timer/image_carousel.dart';

import '../../../utils.dart';

Future<void> main() async {
  setUpAll(
    () =>
        Injector.instance
          ..registerPeriodicTimer()
          ..registerSingleton<Random>(Random(1)),
  );

  tearDownAll(Injector.instance.reset);

  await goldenTest(
    'renders correctly.',
    fileName: 'timer_carousel',
    pumpBeforeTest: precacheImages,
    constraints: widgetConstraints,
    builder: () => const TimerImageCarousel(),
  );
}

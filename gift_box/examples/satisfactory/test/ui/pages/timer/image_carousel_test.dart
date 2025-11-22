import 'dart:math';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_satisfactory/domain/interfaces/native.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:gift_box_satisfactory/ui/pages/timer/image_carousel.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
      ..registerSingleton<NativeApi>(MockNativeApi())
      ..registerPeriodicTimer()
      ..registerSingleton<Random>(Random(1)),
  );

  tearDownAll(Injector.instance.reset);

  await goldenTest(
    'renders correctly.',
    fileName: 'timer_carousel',
    pumpBeforeTest: precacheImages,
    pumpWidget: (tester, widget) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    },
    constraints: widgetConstraints,
    builder: () => const TimerImageCarousel(),
    skip: true,
  );
}

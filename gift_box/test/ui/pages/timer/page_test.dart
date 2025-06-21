import 'dart:math';

import 'package:alchemist/alchemist.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:gift_box/infrastructure/repositories/asset.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/pages/timer/page.dart';

import '../../../utils.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
      ..registerSingleton<AssetApi>(const AssetRepository())
      ..registerBirthday(DateTime(2025))
      ..registerPeriodicTimer()
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<Random>(Random(2)),
  );

  tearDownAll(Injector.instance.reset);

  await goldenTest(
    'renders correctly.',
    fileName: 'page',
    pumpBeforeTest: (tester) async {
      await precacheImages(tester);
      await tester.pump(const Duration(seconds: 1));
    },
    pumpWidget: (tester, widget) => withClock(
      Clock.fixed(DateTime(2024, 12, 31)),
      () async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
      },
    ),
    constraints: pageConstraints,
    builder: TimerPage.new,
  );
}

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/settings/app_version.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final packageInfo = MockPackageInfo();

  setUpAll(
    () => Injector.instance..registerSingleton<PackageInfo>(packageInfo),
  );

  tearDownAll(Injector.instance.reset);

  testGolden(
    'renders correctly.',
    (tester) async {
      when(() => packageInfo.version).thenReturn('1.0.0');

      const widget = SettingsAppVersion();
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('app_version', find.byWidget(widget));
    },
    surfaceSize: const Size(100, 50),
  );
}

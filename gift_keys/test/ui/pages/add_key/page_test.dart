import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/add_key/page.dart';

import '../../../utils.dart';

void main() {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    const widget = AddKeyPage();
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('page', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);
}

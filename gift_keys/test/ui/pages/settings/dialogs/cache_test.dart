import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/cache.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  final fileApi = MockFileApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileApi>(fileApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden(
    'renders correctly.',
    (tester) async {
      const widget = SettingsCacheDialog();
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('cache', find.byWidget(widget));
    },
    surfaceSize: const Size(500, 300),
  );

  // ignore: missing-test-assertion, verify is sufficient.
  testWidgets('show returns correctly.', (tester) async {
    when(fileApi.clearCache).thenAnswer((_) => Future<void>.value());

    final widget = TestGoRouter(
      onTestSetup: (context) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => SettingsCacheDialog.show(context),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byType(TextButton).last);

    verify(fileApi.clearCache).called(1);
  });
}

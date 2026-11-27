import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/config.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  final nativeApi = MockNativeApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<NativeApi>(nativeApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  // ignore: missing-test-assertion, verify is sufficient.
  testWidgets('show returns correctly.', (tester) async {
    when(
      () => nativeApi.launchUri(Config.githubDiscussionUri),
    ).thenAnswer((_) => Future<void>.value());

    final widget = TestGoRouter(
      onTestSetup: (context) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => SettingsFeedbackDialog.show(context),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byType(FilledButton).last);

    verify(() => nativeApi.launchUri(Config.githubDiscussionUri)).called(1);
  });
}

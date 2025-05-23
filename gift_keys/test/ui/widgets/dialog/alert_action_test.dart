import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';

import '../../../utils.dart';

void main() {
  const size = Size(110, 50);

  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  group('cancel', () {
    testGolden('renders correctly.', (tester) async {
      const widget = AlertDialogAction.cancel();
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('alert_action_cancel', find.byWidget(widget));
    }, surfaceSize: size);

    testWidgets('pops correctly.', (tester) async {
      final widget = TestGoRouter(
        onTestSetup: (context) => WidgetsBinding.instance.addPostFrameCallback(
          (_) => showDialog<void>(
            context: context,
            builder: (context) =>
                const Dialog(child: AlertDialogAction.cancel()),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final button = find.byType(TextButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(button, findsNothing);
    });
  });

  group('confirm', () {
    testGolden('renders correctly.', (tester) async {
      final widget = AlertDialogAction.confirm(result: () => true);
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('alert_action_confirm', find.byWidget(widget));
    }, surfaceSize: size);

    testWidgets('pops correctly.', (tester) async {
      final widget = TestGoRouter(
        onTestSetup: (context) =>
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final result = await showDialog<bool>(
                context: context,
                builder: (context) => Dialog(
                  child: AlertDialogAction.confirm(result: () => true),
                ),
              );
              expect(result, isTrue);
            }),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final button = find.byType(TextButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(button, findsNothing);
    });
  });
}

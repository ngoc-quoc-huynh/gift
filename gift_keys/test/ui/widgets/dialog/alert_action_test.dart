import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';

import '../../../utils.dart';

void main() {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  group('cancel', () {
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

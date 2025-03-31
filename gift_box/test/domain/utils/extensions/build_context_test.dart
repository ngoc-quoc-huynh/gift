import 'package:flutter/material.dart' hide Route;
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('colorScheme', () {
    testWidgets(
      'returns correctly.',
      (tester) async => tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            expect(context.colorScheme, ColorScheme.of(context));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });

  group('textTheme', () {
    testWidgets(
      'returns correctly.',
      (tester) async => tester.pumpWidget(
        MaterialApp(
          builder: (context, _) {
            expect(context.textTheme, TextTheme.of(context));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });

  group('goRoute', () {
    testWidgets('navigates correctly.', (WidgetTester tester) async {
      final pageA = Route('page-a');
      final pageB = Route('page-B');

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/a',
            routes: [
              GoRoute(
                path: '/a',
                name: pageA(),
                builder:
                    (context, _) => Scaffold(
                      appBar: AppBar(title: const Text('A')),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () => context.goRoute(pageB),
                      ),
                    ),
              ),
              GoRoute(
                path: '/b',
                name: pageB(),
                builder:
                    (_, state) =>
                        Scaffold(appBar: AppBar(title: const Text('B'))),
              ),
            ],
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.backButton(), findsNothing);
      expect(find.text('B'), findsOneWidget);
    });
  });
}

import 'package:flutter/material.dart' hide Route;
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/route.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
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

  group('dialogTheme', () {
    testWidgets(
      'returns correctly.',
      (tester) async => tester.pumpWidget(
        MaterialApp(
          builder: (context, _) {
            expect(context.dialogTheme, DialogTheme.of(context));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });

  group('theme', () {
    testWidgets(
      'returns correctly.',
      (tester) async => tester.pumpWidget(
        MaterialApp(
          builder: (context, _) {
            expect(context.theme, Theme.of(context));
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

  group('screenSize', () {
    testWidgets('returns correctly.', (WidgetTester tester) async {
      const size = Size(100, 100);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: size),
          child: Builder(
            builder: (context) {
              expect(context.screenSize, size);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('goRoute', () {
    testWidgets('navigates correctly without pathParameters.', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _App((context) => context.goRoute(_Routes.pageB)),
      );

      expect(find.text('A'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.backButton(), findsNothing);
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('navigates correctly with pathParameters.', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _App(
          (context) =>
              context.goRoute(_Routes.pageC, pathParameters: {'id': '1'}),
        ),
      );

      expect(find.text('A'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.backButton(), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('pushRoute', () {
    testWidgets('navigates correctly.', (WidgetTester tester) async {
      await tester.pumpWidget(
        _App((context) => context.pushRoute(_Routes.pageB)),
      );

      expect(find.text('A'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.backButton(), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });
  });
}

final class _Routes {
  const _Routes._();

  static final pageA = Route('page-a');
  static final pageB = Route('page-b');
  static final pageC = Route('page-c');
}

class _App extends StatelessWidget {
  const _App(this.onPressed);

  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/a',
        routes: [
          GoRoute(
            path: '/a',
            name: _Routes.pageA(),
            builder: (context, _) => Scaffold(
              appBar: AppBar(title: const Text('A')),
              floatingActionButton: FloatingActionButton(
                onPressed: () => onPressed.call(context),
              ),
            ),
          ),
          GoRoute(
            path: '/b',
            name: _Routes.pageB(),
            builder: (_, state) =>
                Scaffold(appBar: AppBar(title: const Text('B'))),
          ),
          GoRoute(
            path: '/:id',
            name: _Routes.pageC(),
            builder: (_, state) => Scaffold(
              appBar: AppBar(title: Text(state.pathParameters['id']!)),
            ),
          ),
        ],
      ),
    );
  }
}

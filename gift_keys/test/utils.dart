import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpGoldenWidget(Widget widget) => pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme(const TextTheme()),
      home: Scaffold(body: widget),
    ),
  );
}

Future<void> expectGoldenFile(String name, FinderBase<Element> finder) =>
    expectLater(finder, matchesGoldenFile('goldens/$name.png'));

@isTest
void testGolden(
  String description,
  WidgetTesterCallback callback, {
  Size surfaceSize = const Size(800, 600),
}) => testWidgets(description, (tester) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  return callback.call(tester);
}, tags: ['golden']);

const pageSurfaceSize = Size(360, 640);

class TestGoRouter extends StatelessWidget {
  const TestGoRouter({required this.onTestSetup, super.key});

  final void Function(BuildContext) onTestSetup;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomTheme.lightTheme(const TextTheme()),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, _) {
              onTestSetup.call(context);

              return const Scaffold();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:meta/meta.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpGoldenFile(String name, Widget widget) async {
    await pumpWidget(
      MaterialApp(
        theme: CustomTheme.lightTheme(const TextTheme()),
        home: Scaffold(body: widget),
      ),
    );
    await expectLater(
      find.byWidget(widget),
      matchesGoldenFile('goldens/$name.png'),
    );
  }
}

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

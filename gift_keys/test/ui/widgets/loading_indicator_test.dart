import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/widgets/loading_indicator.dart';

import '../../utils.dart';

void main() {
  testGolden(
    'renders correctly.',
    (tester) async {
      const widget = LoadingIndicator();
      await tester.pumpGoldenWidget(widget);
      await tester.pump(const Duration(seconds: 1));
      await expectGoldenFile('loading_indicator', find.byWidget(widget));
    },
    surfaceSize: const Size.square(100),
  );
}

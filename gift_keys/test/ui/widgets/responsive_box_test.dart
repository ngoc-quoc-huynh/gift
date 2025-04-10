import 'package:flutter/material.dart';
import 'package:gift_keys/ui/widgets/responsive_box.dart';

import '../../utils.dart';

void main() {
  testGolden(
    'renders correctly when width is smaller than 600.',
    (tester) async {
      const widget = ResponsiveBox(
        child: SizedBox.square(
          dimension: 100,
          child: ColoredBox(color: Colors.red),
        ),
      );
      await tester.pumpGoldenWidget(widget);
      await expectGoldenFile('responsive_box_small', widget);
    },
    surfaceSize: const Size(120, 100),
  );

  testGolden(
    'renders correctly when width is greater than 600.',
    (tester) async {
      const widget = ResponsiveBox(
        child: SizedBox(
          width: 700,
          height: 100,
          child: ColoredBox(color: Colors.red),
        ),
      );
      await tester.pumpGoldenWidget(widget);
      await expectGoldenFile('responsive_box_big', widget);
    },
    surfaceSize: const Size(610, 100),
  );
}

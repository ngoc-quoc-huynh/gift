import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/widgets/fade_out.dart';

import '../../utils.dart';

void main() {
  const size = Size(100, 100);

  testGolden('renders correctly with full opacity.', (tester) async {
    const widget = MediaQuery(
      data: MediaQueryData(size: size),
      child: SizedBox(
        width: 100,
        child: FadeBox(
          child: SizedBox.square(
            dimension: 100,
            child: ColoredBox(color: Colors.red),
          ),
        ),
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('fade_out_full', find.byWidget(widget));
  }, surfaceSize: size);

  testGolden('renders correctly with partial opacity.', (tester) async {
    const widget = MediaQuery(
      data: MediaQueryData(size: size),
      child: SizedBox(
        width: 50,
        child: FadeBox(
          child: SizedBox.square(
            dimension: 100,
            child: ColoredBox(color: Colors.red),
          ),
        ),
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('fade_out_partial', find.byWidget(widget));
  }, surfaceSize: size);

  testGolden('renders correctly with zero opacity.', (tester) async {
    const widget = MediaQuery(
      data: MediaQueryData(size: size),
      child: SizedBox(
        width: 0,
        child: FadeBox(
          child: SizedBox.square(
            dimension: 100,
            child: ColoredBox(color: Colors.red),
          ),
        ),
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('fade_out_zero', find.byWidget(widget));
  }, surfaceSize: size);
}

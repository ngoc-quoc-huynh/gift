import 'package:flutter/material.dart';
import 'package:gift_keys/ui/widgets/error_text.dart';

import '../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    const widget = ErrorText(text: 'Error');
    await tester.pumpGoldenWidget(widget);
    await expectGoldenFile('error_text', widget);
  }, surfaceSize: const Size.square(100));
}

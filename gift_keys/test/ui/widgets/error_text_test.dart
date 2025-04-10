import 'package:flutter/material.dart';
import 'package:gift_keys/ui/widgets/error_text.dart';

import '../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    await tester.pumpGoldenFile(
      'error_text',
      const ErrorText(text: 'An error occurred.'),
    );
  }, surfaceSize: const Size(300, 100));
}

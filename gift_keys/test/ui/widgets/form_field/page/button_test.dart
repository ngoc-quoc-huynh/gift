import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/widgets/form_field/page/button.dart';

import '../../../../utils.dart';

void main() {
  const size = Size(150, 50);

  group('loading', () {
    testGolden(
      'renders correctly.',
      (tester) async {
        const widget = FormFieldSubmitButton.loading();
        await tester.pumpGoldenWidget(widget);
        await tester.pump(const Duration(seconds: 1));

        await expectGoldenFile('button_loading', find.byWidget(widget));
      },
      surfaceSize: size,
    );
  });

  group('normal', () {
    testGolden(
      'renders correctly.',
      (tester) async {
        final widget = FormFieldSubmitButton.normal(
          buttonTitle: 'Button',
          onPressed: () {
            return;
          },
        );
        await tester.pumpGoldenWidget(widget);

        await expectGoldenFile('button_normal', find.byWidget(widget));
      },
      surfaceSize: size,
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/pages/settings/item.dart';

import '../../../utils.dart';

void main() {
  testGolden(
    'renders correctly.',
    (tester) async {
      final widget = SettingsItem(
        icon: Icons.brightness_6_rounded,
        title: 'Design',
        onTap: () {
          return;
        },
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('item', find.byWidget(widget));
    },
    surfaceSize: const Size(250, 80),
  );
}

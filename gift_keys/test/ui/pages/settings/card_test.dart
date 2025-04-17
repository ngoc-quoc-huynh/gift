import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/pages/settings/card.dart';
import 'package:gift_keys/ui/pages/settings/item.dart';

import '../../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    final widget = SettingsCard(
      children: [
        SettingsItem(
          icon: Icons.brightness_6_rounded,
          title: 'Design',
          onTap: () {
            return;
          },
        ),
      ],
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('card', find.byWidget(widget));
  }, surfaceSize: const Size(300, 70));
}

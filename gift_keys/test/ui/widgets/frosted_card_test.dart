import 'package:flutter/material.dart';
import 'package:gift_keys/ui/widgets/frosted_card.dart';

import '../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    const widget = SizedBox.square(
      dimension: 100,
      child: ColoredBox(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox.square(
            dimension: 50,
            child: FrostedCard(child: SizedBox.shrink()),
          ),
        ),
      ),
    );
    await tester.pumpGoldenWidget(widget);
    await expectGoldenFile('frosted_card', widget);
  }, surfaceSize: const Size.square(100));
}

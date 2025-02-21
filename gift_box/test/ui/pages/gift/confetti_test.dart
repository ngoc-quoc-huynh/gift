import 'package:alchemist/alchemist.dart';
import 'package:flutter/cupertino.dart';
import 'package:gift_box/ui/pages/gift/confetti.dart';

Future<void> main() async {
  await goldenTest(
    'renders correctly.',
    fileName: 'confetti',
    pumpBeforeTest: (tester) => tester.pump(const Duration(seconds: 1)),
    builder: () => const GiftConfetti(
      child: SizedBox.square(
        dimension: 100,
      ),
    ),
  );
}

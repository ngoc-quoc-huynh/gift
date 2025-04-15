import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

import '../../utils.dart';

void main() {
  testGolden('renders error correctly.', (tester) async {
    final widget = _TestWidget(
      (context) => CustomSnackBar.showError(context, 'Error'),
    );
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();
    await expectGoldenFile('snack_bar_error', find.byWidget(widget));
  }, surfaceSize: const Size(200, 80));

  testGolden('renders info correctly.', (tester) async {
    final widget = _TestWidget(
      (context) => CustomSnackBar.showInfo(context, 'Info'),
    );
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();
    await expectGoldenFile('snack_bar_info', find.byWidget(widget));
  }, surfaceSize: const Size(200, 80));

  testGolden('renders success correctly.', (tester) async {
    final widget = _TestWidget(
      (context) => CustomSnackBar.showSuccess(context, 'Success'),
    );
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();
    await expectGoldenFile('snack_bar_success', find.byWidget(widget));
  }, surfaceSize: const Size(200, 80));
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget(this.showSnackBar);

  final void Function(BuildContext) showSnackBar;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showSnackBar(context),
        );
        return const SizedBox.shrink();
      },
    );
  }
}

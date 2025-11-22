import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/static/resources/sizes.dart';

class MaxWidthBox extends StatelessWidget {
  const MaxWidthBox({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Sizes.maxWidgetWidthConstraint,
        ),
        child: child,
      ),
    );
  }
}

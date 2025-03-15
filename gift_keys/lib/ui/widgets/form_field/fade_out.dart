import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';

class FadeBox extends StatelessWidget {
  const FadeBox({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;

    return LayoutBuilder(
      builder:
          (context, constraints) => OverflowBox(
            maxWidth: screenWidth,
            child: Opacity(
              opacity: _computeOpacity(constraints.maxWidth, screenWidth),
              child: child,
            ),
          ),
    );
  }

  double _computeOpacity(double maxWidth, double screenWidth) =>
      max(0, maxWidth + screenWidth - screenWidth) / screenWidth;
}

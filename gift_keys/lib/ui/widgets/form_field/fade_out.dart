import 'dart:math';

import 'package:flutter/material.dart';

class FadeBox extends StatelessWidget {
  const FadeBox({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.sizeOf(context).width;

    return LayoutBuilder(
      builder:
          (context, constraints) => OverflowBox(
            maxWidth: maxWidth,
            child: Opacity(
              opacity: _computeOpacity(constraints.maxWidth, maxWidth),
              child: child,
            ),
          ),
    );
  }

  double _computeOpacity(double maxWidth, double screenWidth) =>
      max(0, maxWidth + screenWidth - screenWidth) / screenWidth;
}

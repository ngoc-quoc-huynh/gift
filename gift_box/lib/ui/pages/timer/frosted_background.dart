import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';

class FrostedBackground extends StatelessWidget {
  const FrostedBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: ColoredBox(
          color: context.colorScheme.surface.withValues(alpha: 0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

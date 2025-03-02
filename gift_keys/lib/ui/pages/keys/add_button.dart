import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/router/routes.dart';

class KeyAddButton extends StatelessWidget {
  const KeyAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return LayoutBuilder(
      builder: (context, constraints) => OverflowBox(
        maxWidth: screenWidth,
        child: Opacity(
          opacity: _computeOpacity(constraints.maxWidth, screenWidth),
          child: ActionChip(
            onPressed: () => context.goRoute(Routes.addKeyPage),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(20),
            label: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.add, size: 50),
                ),
                const SizedBox(height: 10),
                Text(
                  Injector.instance.translations.pages.keys.add,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: primaryColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _computeOpacity(double maxWidth, double screenWidth) =>
      max(0, maxWidth + screenWidth - screenWidth) / screenWidth;
}

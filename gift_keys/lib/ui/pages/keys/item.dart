import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/ui/widgets/form_field/fade_out.dart';

class KeysItem extends StatelessWidget {
  const KeysItem({required this.giftKey, super.key});

  final GiftKey giftKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textColor = switch (theme.brightness) {
      Brightness.light => colorScheme.surface,
      Brightness.dark => colorScheme.inverseSurface,
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(giftKey.image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withValues(
              alpha: switch (theme.brightness) {
                Brightness.light => 0,
                Brightness.dark => 0.2,
              },
            ),
            BlendMode.darken,
          ),
        ),
      ),
      child: FadeBox(
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: ColoredBox(
                color: colorScheme.surface.withValues(alpha: 0.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        giftKey.name,
                        style: textTheme.displayLarge?.copyWith(
                          color: textColor,
                        ),
                      ),
                      Text(
                        giftKey.birthday.format(),
                        style: textTheme.displaySmall?.copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/form_field/fade_out.dart';

class KeysItem extends StatelessWidget {
  const KeysItem({required this.giftKeyMeta, super.key});

  final GiftKeyMeta giftKeyMeta;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => context.goRoute(
            Routes.keyPage,
            pathParameters: {'id': giftKeyMeta.id.toString()},
          ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(
              Injector.instance.fileApi.loadImage(giftKeyMeta.id),
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(
                alpha: switch (context.theme.brightness) {
                  Brightness.light => 0,
                  Brightness.dark => 0.2,
                },
              ),
              BlendMode.darken,
            ),
          ),
        ),
        child: _Body(name: giftKeyMeta.name, birthday: giftKeyMeta.birthday),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.name, required this.birthday});

  final String name;
  final DateTime birthday;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final brightness = theme.brightness;
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textColor = switch (brightness) {
      Brightness.light => colorScheme.surface,
      Brightness.dark => colorScheme.inverseSurface,
    };

    return FadeBox(
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
                      name,
                      style: textTheme.displayLarge?.copyWith(color: textColor),
                    ),
                    Text(
                      birthday.format(DateTimeFormat.normal),
                      style: textTheme.displaySmall?.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

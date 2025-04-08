import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/ui/pages/key_metas/item/image.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/form_field/fade_out.dart';
import 'package:gift_keys/ui/widgets/frosted_card.dart';

class KeyMetaItem extends StatelessWidget {
  const KeyMetaItem({required this.meta, super.key});

  final GiftKeyMeta meta;

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

    return InkWell(
      onTap:
          () => context.goRoute(
            Routes.keyPage,
            pathParameters: {'id': meta.id.toString()},
          ),
      child: KeyMetaImageBackground(
        id: meta.id,
        child: FadeBox(
          child: Center(
            child: FrostedCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    meta.name,
                    style: textTheme.displayLarge?.copyWith(color: textColor),
                  ),
                  Text(
                    meta.birthday.format(DateTimeFormat.normal),
                    style: textTheme.displaySmall?.copyWith(color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

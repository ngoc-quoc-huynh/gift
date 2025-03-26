import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/router/routes.dart';

class KeyMetasSettingsButton extends StatelessWidget {
  const KeyMetasSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () => context.pushRoute(Routes.settingsPage),
        tooltip: Injector.instance.translations.pages.keys.settings,
        icon: const Icon(Icons.settings),
      ),
    );
  }
}

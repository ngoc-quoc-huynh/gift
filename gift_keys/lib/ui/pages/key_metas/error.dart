import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/key_metas/settings_button.dart';

class KeyMetasErrorView extends StatelessWidget {
  const KeyMetasErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
              vertical: Sizes.verticalPadding,
            ),
            child: Center(
              child: Text(
                _translations.load,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
              ),
            ),
          ),
          const KeyMetasSettingsButton(),
        ],
      ),
    );
  }

  static TranslationsPagesKeysErrorEn get _translations =>
      Injector.instance.translations.pages.keys.error;
}

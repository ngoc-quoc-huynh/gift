import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/config.dart';
import 'package:gift_keys/static/resources/sizes.dart';

class KeyMetasErrorView extends StatelessWidget {
  const KeyMetasErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
        vertical: Sizes.verticalPadding,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              _translations.load,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            FilledButton(
              onPressed:
                  () => unawaited(
                    Injector.instance.nativeApi.launchUri(
                      Config.githubIssueUri,
                    ),
                  ),
              child: Text(_translations.button),
            ),
          ],
        ),
      ),
    );
  }

  static TranslationsPagesKeysErrorEn get _translations =>
      Injector.instance.translations.pages.keys.error;
}

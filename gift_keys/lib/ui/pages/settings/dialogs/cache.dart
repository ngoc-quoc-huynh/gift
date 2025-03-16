import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class SettingsCacheDialog extends StatelessWidget {
  const SettingsCacheDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final delete = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsCacheDialog(),
    );

    if (context.mounted && (delete ?? false)) {
      await Injector.instance.fileApi.clearCache();
      if (context.mounted) {
        CustomSnackBar.showSuccess(
          context,
          _translations.pages.settings.cacheUpdate,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: _titlePadding,
      contentPadding: _contentPadding,
      title: Text(_dialogTranslations.title),
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: Text(_dialogTranslations.content),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(_generalTranslations.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(_generalTranslations.ok),
        ),
      ],
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static TranslationsGeneralEn get _generalTranslations =>
      _translations.general;

  static TranslationsPagesSettingsDialogsCacheEn get _dialogTranslations =>
      _translations.pages.settings.dialogs.cache;

  static const _titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
  );

  static const _contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
}

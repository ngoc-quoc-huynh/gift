import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:go_router/go_router.dart';

class SettingsResetDialog extends StatelessWidget {
  const SettingsResetDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final reset = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsResetDialog(),
    );

    if (context.mounted && (reset ?? false)) {
      context.read<KeysBloc>().add(const KeysResetEvent());
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

  static TranslationsPagesSettingsDialogsResetEn get _dialogTranslations =>
      _translations.pages.settings.dialogs.reset;

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

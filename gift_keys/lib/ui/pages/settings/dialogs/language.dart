import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:go_router/go_router.dart';

class SettingsLanguageDialog extends StatelessWidget {
  const SettingsLanguageDialog({super.key});

  static Future<void> show(
    BuildContext context,
    LanguageOption currentOption,
  ) async {
    final option = await showDialog<LanguageOption>(
      context: context,
      useRootNavigator: false,
      builder:
          (context) => BlocProvider<LanguageOptionValueCubit>(
            create: (_) => LanguageOptionValueCubit(currentOption),
            child: const SettingsLanguageDialog(),
          ),
    );

    if (context.mounted && option != null) {
      context.read<LanguageOptionValueCubit>().update(option);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: _titlePadding,
      contentPadding: _contentPadding,
      title: Text(_dialogTranslations.title),
      content: BlocBuilder<LanguageOptionValueCubit, LanguageOption>(
        builder:
            (context, option) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<LanguageOption>(
                  value: LanguageOption.english,
                  groupValue: option,
                  title: Text(_dialogTranslations.english),
                  onChanged: (option) => _onChanged(context, option!),
                ),
                RadioListTile(
                  value: LanguageOption.german,
                  groupValue: option,
                  title: Text(_dialogTranslations.german),
                  onChanged: (option) => _onChanged(context, option!),
                ),
                RadioListTile(
                  value: LanguageOption.system,
                  groupValue: option,
                  title: Text(_dialogTranslations.device),
                  onChanged: (option) => _onChanged(context, option!),
                ),
              ],
            ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(_generalTranslations.cancel),
        ),
        TextButton(
          onPressed:
              () => context.pop(context.read<LanguageOptionValueCubit>().state),
          child: Text(_generalTranslations.ok),
        ),
      ],
    );
  }

  void _onChanged(BuildContext context, LanguageOption option) =>
      context.read<LanguageOptionValueCubit>().update(option);

  static Translations get _translations => Injector.instance.translations;

  static TranslationsGeneralEn get _generalTranslations =>
      _translations.general;

  static TranslationsPagesSettingsDialogsLanguageEn get _dialogTranslations =>
      _translations.pages.settings.dialogs.language;

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

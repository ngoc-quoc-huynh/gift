import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:go_router/go_router.dart';

class SettingsDesignDialog extends StatelessWidget {
  const SettingsDesignDialog({super.key});

  static Future<void> show(
    BuildContext context,
    ThemeMode currentThemeMode,
  ) async {
    final themeMode = await showDialog<ThemeMode>(
      context: context,
      useRootNavigator: false,
      builder:
          (context) => BlocProvider<ThemeModeValueCubit>(
            create: (_) => ThemeModeValueCubit(currentThemeMode),
            child: const SettingsDesignDialog(),
          ),
    );

    if (context.mounted && themeMode != null) {
      context.read<ThemeModeHydratedValueCubit>().update(themeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: _titlePadding,
      contentPadding: _contentPadding,
      title: Text(_dialogTranslations.title),
      content: BlocBuilder<ThemeModeValueCubit, ThemeMode>(
        builder:
            (context, themeMode) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  title: Text(_dialogTranslations.bright),
                  onChanged: (themeMode) => _onChanged(context, themeMode!),
                ),
                RadioListTile(
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  title: Text(_dialogTranslations.dark),
                  onChanged: (themeMode) => _onChanged(context, themeMode!),
                ),
                RadioListTile(
                  value: ThemeMode.system,
                  groupValue: themeMode,
                  title: Text(_dialogTranslations.device),
                  onChanged: (themeMode) => _onChanged(context, themeMode!),
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
              () => context.pop(context.read<ThemeModeValueCubit>().state),
          child: Text(_generalTranslations.ok),
        ),
      ],
    );
  }

  void _onChanged(BuildContext context, ThemeMode themeMode) =>
      context.read<ThemeModeValueCubit>().update(themeMode);

  static Translations get _translations => Injector.instance.translations;

  static TranslationsGeneralEn get _generalTranslations =>
      _translations.general;

  static TranslationsPagesSettingsDialogsDesignEn get _dialogTranslations =>
      _translations.pages.settings.dialogs.design;

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

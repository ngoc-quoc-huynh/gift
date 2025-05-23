import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';

class SettingsDesignDialog extends StatelessWidget {
  const SettingsDesignDialog({super.key});

  static Future<void> show(
    BuildContext context,
    ThemeMode currentThemeMode,
  ) async {
    final themeMode = await showDialog<ThemeMode>(
      context: context,
      useRootNavigator: false,
      builder: (context) => BlocProvider<ThemeModeValueCubit>(
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
    return CustomDialog.radio(
      title: _translations.title,
      options: [
        RadioDialogOption<ThemeMode>(
          value: ThemeMode.light,
          title: _translations.bright,
        ),
        RadioDialogOption(value: ThemeMode.dark, title: _translations.dark),
        RadioDialogOption(value: ThemeMode.system, title: _translations.device),
      ],
    );
  }

  static TranslationsPagesSettingsDialogsDesignEn get _translations =>
      Injector.instance.translations.pages.settings.dialogs.design;
}

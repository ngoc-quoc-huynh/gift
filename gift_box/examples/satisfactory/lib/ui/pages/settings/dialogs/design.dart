import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/dialog/radio/dialog.dart';
import 'package:gift_box/ui/widgets/dialog/radio/option.dart';

class SettingsDesignDialog extends StatelessWidget {
  const SettingsDesignDialog._(this._themeMode);

  final ThemeMode _themeMode;

  static Future<void> show(BuildContext context) async {
    final cubit = context.read<HydratedThemeModeCubit>();
    final themeMode = await showDialog<ThemeMode?>(
      context: context,
      useRootNavigator: false,
      builder: (_) => SettingsDesignDialog._(cubit.state),
    );

    if (context.mounted && themeMode != null) {
      cubit.update(themeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeModeCubit>(
      create: (_) => ThemeModeCubit(_themeMode),
      child: RadioDialog<ThemeMode>(
        title: _translations.title,
        options: [
          RadioDialogOption(
            title: _translations.light,
            value: ThemeMode.light,
          ),
          RadioDialogOption(
            title: _translations.dark,
            value: ThemeMode.dark,
          ),
          RadioDialogOption(
            title: _translations.system,
            value: ThemeMode.system,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesSettingsDesignEn get _translations =>
      Injector.instance.translations.pages.settings.design;
}

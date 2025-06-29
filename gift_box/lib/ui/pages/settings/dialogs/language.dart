import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/dialog/radio/dialog.dart';
import 'package:gift_box/ui/widgets/dialog/radio/option.dart';

class SettingsLanguageDialog extends StatelessWidget {
  const SettingsLanguageDialog._(this._locale);

  final TranslationLocalePreference _locale;

  static Future<void> show(BuildContext context) async {
    final cubit = context.read<HydratedTranslationLocalePreferenceCubit>();
    final locale = await showDialog<TranslationLocalePreference>(
      context: context,
      useRootNavigator: false,
      builder: (_) => SettingsLanguageDialog._(cubit.state),
    );

    if (context.mounted && locale != null) {
      cubit.update(locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TranslationLocalePreferenceCubit>(
      create: (_) => TranslationLocalePreferenceCubit(_locale),
      child: RadioDialog<TranslationLocalePreference>(
        title: _translations.title,
        options: [
          RadioDialogOption(
            title: _translations.german,
            value: TranslationLocalePreference.german,
          ),
          RadioDialogOption(
            title: _translations.english,
            value: TranslationLocalePreference.english,
          ),
          RadioDialogOption(
            title: _translations.system,
            value: TranslationLocalePreference.system,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesSettingsLanguageEn get _translations =>
      Injector.instance.translations.pages.settings.language;
}

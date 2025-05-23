import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';

class SettingsLanguageDialog extends StatelessWidget {
  const SettingsLanguageDialog({super.key});

  static Future<void> show(
    BuildContext context,
    LanguageOption currentOption,
  ) async {
    final option = await showDialog<LanguageOption>(
      context: context,
      useRootNavigator: false,
      builder: (_) => BlocProvider<LanguageOptionValueCubit>(
        create: (_) => LanguageOptionValueCubit(currentOption),
        child: const SettingsLanguageDialog(),
      ),
    );

    if (context.mounted && option != null) {
      context.read<LanguageOptionHydratedValueCubit>().update(option);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog.radio(
      title: _translations.title,
      options: [
        RadioDialogOption(
          value: LanguageOption.english,
          title: _translations.english,
        ),
        RadioDialogOption(
          value: LanguageOption.german,
          title: _translations.german,
        ),
        RadioDialogOption(
          value: LanguageOption.system,
          title: _translations.device,
        ),
      ],
    );
  }

  static TranslationsPagesSettingsDialogsLanguageEn get _translations =>
      Injector.instance.translations.pages.settings.dialogs.language;
}

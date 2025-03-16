import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/settings/app_version.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/design.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/language.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_translations.appBar)),
      bottomNavigationBar: const SettingsAppVersion(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
          vertical: Sizes.verticalPadding,
        ),
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  BlocListener<ThemeModeHydratedValueCubit, ThemeMode>(
                    listener: _onThemeModeChanged,
                    child: ListTile(
                      leading: const Icon(Icons.brightness_6_rounded),
                      title: Text(_translations.design),
                      trailing: const Icon(Icons.chevron_right),
                      onTap:
                          () => unawaited(
                            SettingsDesignDialog.show(
                              context,
                              context.read<ThemeModeHydratedValueCubit>().state,
                            ),
                          ),
                    ),
                  ),
                  const Divider(indent: 10, endIndent: 10),
                  BlocListener<
                    LanguageOptionHydratedValueCubit,
                    LanguageOption
                  >(
                    listener: _onLanguageOptionChanged,
                    child: ListTile(
                      leading: const Icon(Icons.flag_outlined),
                      title: Text(_translations.language),
                      trailing: const Icon(Icons.chevron_right),
                      onTap:
                          () => unawaited(
                            SettingsLanguageDialog.show(
                              context,
                              context
                                  .read<LanguageOptionHydratedValueCubit>()
                                  .state,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.restart_alt),
                title: Text(_translations.reset),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.library_books_outlined),
                title: Text(_translations.license),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLanguageOptionChanged(BuildContext context, _) =>
      CustomSnackBar.showSuccess(context, _translations.languageUpdate);

  void _onThemeModeChanged(BuildContext context, _) =>
      CustomSnackBar.showSuccess(context, _translations.designUpdate);

  static TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

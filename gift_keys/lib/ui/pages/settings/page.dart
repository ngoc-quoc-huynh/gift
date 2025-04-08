import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/pages/settings/app_version.dart';
import 'package:gift_keys/ui/pages/settings/card.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/cache.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/design.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/feedback.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/language.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/reset.dart';
import 'package:gift_keys/ui/pages/settings/item.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/responsive_box.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_settingsTranslations.appBar)),
      bottomNavigationBar: const SettingsAppVersion(),
      body: Center(
        child: ResponsiveBox(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
              vertical: Sizes.verticalPadding,
            ),
            children: [
              SettingsCard(
                children: [
                  BlocListener<ThemeModeHydratedValueCubit, ThemeMode>(
                    listener: _onThemeModeChanged,
                    child: SettingsItem(
                      icon: Icons.brightness_6_rounded,
                      title: _settingsTranslations.design,
                      onTap:
                          () => unawaited(
                            SettingsDesignDialog.show(
                              context,
                              context.read<ThemeModeHydratedValueCubit>().state,
                            ),
                          ),
                    ),
                  ),
                  BlocListener<
                    LanguageOptionHydratedValueCubit,
                    LanguageOption
                  >(
                    listener: _onLanguageOptionChanged,
                    child: SettingsItem(
                      icon: Icons.flag_outlined,
                      title: _settingsTranslations.language,
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
              const SizedBox(height: 10),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.cached_outlined,
                    title: _settingsTranslations.cache,
                    onTap: () => unawaited(SettingsCacheDialog.show(context)),
                  ),
                  BlocListener<KeyMetasBloc, KeyMetasState>(
                    listener: _onKeysStateChanged,
                    child: SettingsItem(
                      icon: Icons.restart_alt,
                      title: _settingsTranslations.reset,
                      onTap: () => unawaited(SettingsResetDialog.show(context)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.feedback_outlined,
                    title: _settingsTranslations.feedback,
                    onTap:
                        () => unawaited(SettingsFeedbackDialog.show(context)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SettingsCard(
                children: [
                  SettingsItem(
                    icon: Icons.library_books_outlined,
                    title: _settingsTranslations.license,
                    onTap: () => context.pushRoute(Routes.licensePage),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLanguageOptionChanged(BuildContext context, _) =>
      CustomSnackBar.showSuccess(context, _settingsTranslations.languageUpdate);

  void _onThemeModeChanged(BuildContext context, _) =>
      CustomSnackBar.showSuccess(context, _settingsTranslations.designUpdate);

  void _onKeysStateChanged(BuildContext context, KeyMetasState state) =>
      switch (state) {
        KeyMetasLoadOnSuccess() => CustomSnackBar.showSuccess(
          context,
          _settingsTranslations.resetUpdate,
        ),
        KeyMetasResetOnFailure() => CustomSnackBar.showError(
          context,
          _translations.general.error,
        ),
        _ => null,
      };

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesSettingsEn get _settingsTranslations =>
      _translations.pages.settings;
}

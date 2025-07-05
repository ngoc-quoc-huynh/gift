import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/music_tape/bloc.dart';
import 'package:gift_box/domain/blocs/purchased_items/bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/pages/settings/app_version.dart';
import 'package:gift_box/ui/pages/settings/dialogs/design.dart';
import 'package:gift_box/ui/pages/settings/dialogs/feedback.dart';
import 'package:gift_box/ui/pages/settings/dialogs/language.dart';
import 'package:gift_box/ui/pages/settings/item.dart';
import 'package:gift_box/ui/pages/settings/section.dart';
import 'package:gift_box/ui/widgets/loading_indicator.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationLocaleCubit, TranslationLocale>(
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(_translations.appBar),
        ),
        bottomNavigationBar: const SettingsAppVersion(),
        body: BlocProvider<PurchasedItemsBloc>(
          create: (_) =>
              PurchasedItemsBloc()..add(const PurchasedItemsInitializeEvent()),
          child: BlocBuilder<PurchasedItemsBloc, PurchasedItemsState>(
            builder: (context, state) => switch (state) {
              PurchasedItemsLoadInProgress() => const LoadingIndicator(),
              PurchasedItemsLoadOnSuccess(:final ids) => _Body(ids),
            },
          ),
        ),
      ),
    );
  }

  TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

class _Body extends StatelessWidget {
  const _Body(this.ids);

  final Set<ShopItemId> ids;

  @override
  Widget build(BuildContext context) {
    final isDesignModeUnlocked = ids.contains(ShopItemId.darkMode);
    final isLanguageUnlocked = ids.contains(ShopItemId.germanDrive);
    final isMusicModeUnlocked = ids.contains(ShopItemId.musicTape);

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
        vertical: Sizes.verticalPadding,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SettingsSection(
            title: _translations.section1,
            items: [
              BlocBuilder<HydratedThemeModeCubit, ThemeMode>(
                builder: (context, themeMode) => SettingsItem(
                  icon: Icons.palette_outlined,
                  iconColor: Colors.deepOrange,
                  title: _translations.design.label,
                  subtitle: switch (themeMode) {
                    ThemeMode.dark => _translations.design.dark,
                    ThemeMode.light => _translations.design.light,
                    ThemeMode.system => _translations.design.system,
                  },
                  onPressed: () => SettingsDesignDialog.show(context),
                  enabled: isDesignModeUnlocked,
                ),
              ),
              BlocBuilder<
                HydratedTranslationLocalePreferenceCubit,
                TranslationLocalePreference
              >(
                builder: (context, locale) => SettingsItem(
                  icon: Icons.language_outlined,
                  iconColor: Colors.blue,
                  title: _translations.language.label,
                  subtitle: switch (locale) {
                    TranslationLocalePreference.english =>
                      _translations.language.english,
                    TranslationLocalePreference.german =>
                      _translations.language.german,
                    TranslationLocalePreference.system =>
                      _translations.language.system,
                  },
                  onPressed: () => SettingsLanguageDialog.show(context),
                  enabled: isLanguageUnlocked,
                ),
              ),
              BlocBuilder<MusicTapeBloc, bool>(
                builder: (context, isEnabled) => SettingsItem(
                  icon: Icons.music_note_outlined,
                  iconColor: Colors.green,
                  title: _translations.music.label,
                  subtitle: switch (isEnabled) {
                    false => _translations.music.disabled,
                    true => _translations.music.enabled,
                  },
                  enabled: isMusicModeUnlocked,
                  trailing: Switch(
                    value: isEnabled,
                    onChanged: switch (isMusicModeUnlocked) {
                      false => null,
                      true => (isEnabled) => _onMusicSwitchChanged(
                        context,
                        isEnabled,
                      ),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        SettingsSection(
          title: _translations.section2,
          items: [
            SettingsItem(
              icon: Icons.feedback_outlined,
              iconColor: Colors.orange,
              title: _translations.feedback.label,
              subtitle: _translations.feedback.subtitle,
              onPressed: () => SettingsFeedbackDialog.show(context),
            ),
            SettingsItem(
              icon: Icons.description_outlined,
              iconColor: Colors.grey,
              title: _translations.license.label,
              onPressed: () => context.pushRoute(AppRoute.license),
            ),
          ],
        ),
      ],
    );
  }

  void _onMusicSwitchChanged(BuildContext context, bool isEnabled) =>
      context.read<MusicTapeBloc>().add(
        switch (isEnabled) {
          false => const MusicTapeStopEvent(),
          true => const MusicTapePlayEvent(),
        },
      );

  TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

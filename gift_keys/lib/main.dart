import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:gift_keys/ui/router/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setupDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return BlocProvider<LanguageOptionValueCubit>(
      create: (_) => LanguageOptionValueCubit(LanguageOption.system),
      child: BlocConsumer<LanguageOptionValueCubit, LanguageOption>(
        listener: _onLanguageOptionChanged,
        builder:
            (context, language) => MaterialApp.router(
              title: Injector.instance.translations.appName,
              theme: CustomTheme.lightTheme(textTheme),
              darkTheme: CustomTheme.darkTheme(textTheme),
              locale: _getLocaleByLanguageOption(language),
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              routerConfig: GoRouterConfig.routes,
            ),
      ),
    );
  }

  Locale _getLocaleByLanguageOption(LanguageOption language) =>
      switch (language) {
        LanguageOption.english => const Locale('en'),
        LanguageOption.german => const Locale('de'),
        LanguageOption.system => PlatformDispatcher.instance.locale,
      };

  void _onLanguageOptionChanged(BuildContext _, LanguageOption option) =>
      switch (option) {
        LanguageOption.german => _updateTranslations(AppLocale.de),
        LanguageOption.system when Platform.localeName.startsWith('de') =>
          _updateTranslations(AppLocale.de),
        LanguageOption.english ||
        LanguageOption.system => _updateTranslations(AppLocale.en),
      };

  void _updateTranslations(AppLocale appLocale) =>
      Injector.instance
        // ignore: discarded_futures, the method is synchronously called.
        ..unregister<Translations>()
        ..registerLazySingleton<Translations>(() => appLocale.buildSync());
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';

typedef TranslationLocaleBuilder =
    Widget Function(BuildContext, TranslationLocale);

class TranslationsProvider extends StatelessWidget {
  const TranslationsProvider({
    required this.localePreference,
    required this.builder,
    super.key,
  });

  final TranslationLocalePreference localePreference;
  final TranslationLocaleBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TranslationLocaleCubit>(
      create: (_) => TranslationLocaleCubit(resolveLocale(localePreference)),
      child: _Body(builder),
    );
  }

  static TranslationLocale resolveLocale(
    TranslationLocalePreference localePreference,
  ) => switch (localePreference) {
    TranslationLocalePreference.german => TranslationLocale.german,
    TranslationLocalePreference.english => TranslationLocale.english,
    TranslationLocalePreference.system => Injector.instance.nativeApi.locale,
  };
}

class _Body extends StatefulWidget {
  const _Body(this.builder);

  final TranslationLocaleBuilder builder;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (context.read<HydratedTranslationLocalePreferenceCubit>().state ==
        TranslationLocalePreference.system) {
      context.read<TranslationLocaleCubit>().update(
        Injector.instance.nativeApi.locale,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      HydratedTranslationLocalePreferenceCubit,
      TranslationLocalePreference
    >(
      listener: _onTranslationLocalePreferenceChanged,
      child: BlocBuilder<TranslationLocaleCubit, TranslationLocale>(
        builder: (context, locale) => widget.builder.call(context, locale),
      ),
    );
  }

  void _onTranslationLocalePreferenceChanged(
    BuildContext context,
    TranslationLocalePreference localePreference,
  ) => context.read<TranslationLocaleCubit>().update(
    TranslationsProvider.resolveLocale(localePreference),
  );
}

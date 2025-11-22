part of '../cubit.dart';

final class TranslationLocaleCubit extends ValueCubit<TranslationLocale> {
  TranslationLocaleCubit(TranslationLocale initialState) : super(initialState) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _resolveTranslations(initialState),
    );
  }

  @override
  void update(TranslationLocale newState) {
    if (state == newState) {
      return;
    }

    Injector.instance
      // ignore: discarded_futures, since this is not a future and we cannot use unawaited.
      ..unregister<Translations>()
      ..registerLazySingleton<Translations>(
        () => _resolveTranslations(newState),
      );

    return super.update(newState);
  }

  Translations _resolveTranslations(TranslationLocale locale) =>
      switch (locale) {
        TranslationLocale.german => AppLocale.de,
        TranslationLocale.english => AppLocale.en,
      }.buildSync();
}

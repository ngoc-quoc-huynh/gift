enum TranslationLocalePreference {
  german('de'),
  english('en'),
  system(null)
  ;

  const TranslationLocalePreference(this.code);

  final String? code;
}

enum TranslationLocale {
  german,
  english,
}

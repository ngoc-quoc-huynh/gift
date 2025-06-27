enum TranslationLocale {
  german('de'),
  english('en'),
  system(null);

  const TranslationLocale(this.code);

  final String? code;
}

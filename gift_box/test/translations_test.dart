import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  test('All locales should be supported by Flutter.', () {
    for (final locale in AppLocale.values) {
      expect(kMaterialSupportedLanguages, contains(locale.languageCode));
    }
  });
}

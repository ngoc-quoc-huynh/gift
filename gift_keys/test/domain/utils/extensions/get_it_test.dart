import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/injector.dart';

void main() {
  test('returns Translations.', () {
    Injector.instance.registerSingleton<Translations>(AppLocale.en.buildSync());
    addTearDown(Injector.instance.unregister<Translations>);

    expect(Injector.instance.translations, isA<Translations>());
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/injector.dart';

import '../../../mocks.dart';

void main() {
  test('returns Logger.', () {
    Injector.instance.registerSingleton<Logger>(MockLogger());
    addTearDown(Injector.instance.unregister<Logger>);

    expect(
      Injector.instance.logger,
      isA<Logger>(),
    );
  });

  test('returns LoggerApi.', () {
    Injector.instance.registerSingleton<LoggerApi>(MockLoggerApi());
    addTearDown(Injector.instance.unregister<LoggerApi>);

    expect(
      Injector.instance.loggerApi,
      isA<LoggerApi>(),
    );
  });

  test('returns Translations.', () {
    Injector.instance.registerSingleton<Translations>(AppLocale.en.buildSync());
    addTearDown(Injector.instance.unregister<Translations>);

    expect(
      Injector.instance.translations,
      isA<Translations>(),
    );
  });
}

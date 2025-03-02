import 'package:get_it/get_it.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/infrastructure/repositories/file.dart';
import 'package:gift_keys/infrastructure/repositories/logger.dart';
import 'package:gift_keys/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';

export 'package:gift_keys/domain/utils/extensions/get_it.dart';
export 'package:gift_keys/static/i18n/translations.g.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static void setupDependencies() =>
      instance
        ..registerLazySingleton<FileApi>(FileRepository.new)
        ..registerLazySingleton<Logger>(Logger.new)
        ..registerLazySingleton<LoggerApi>(LoggerRepository.new)
        ..registerLazySingleton<Translations>(_createTranslations);

  static Translations _createTranslations() => AppLocale.en.buildSync();
}

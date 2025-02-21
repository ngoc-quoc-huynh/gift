import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/infrastructure/repositories/logger.dart';
import 'package:gift_box/infrastructure/repositories/nfc.dart';
import 'package:gift_box/static/config.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';
import 'package:nfc_manager/nfc_manager.dart';

export 'package:gift_box/domain/utils/extensions/get_it.dart';
export 'package:gift_box/static/i18n/translations.g.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static void setupDependencies() => instance
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<LoggerApi>(LoggerRepository.new)
    ..registerLazySingleton<NfcApi>(NfcRepository.new)
    ..registerLazySingleton<Translations>(_createTranslations)
    ..registerLazySingleton<Random>(Random.new)
    ..registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
      Timer.periodic,
    )
    ..registerLazySingleton<DateTime>(
      () => DateTime(2025),
      instanceName: 'birthday',
    )
    ..registerLazySingleton<Uint8List>(
      () => Config.aid.toUint8List(isHex: true),
      instanceName: 'aid',
    )
    ..registerLazySingleton<Uint8List>(
      () => Config.pin.toHexString().toUint8List(),
      instanceName: 'pin',
    );
  static Translations _createTranslations() => AppLocale.en.buildSync();
}

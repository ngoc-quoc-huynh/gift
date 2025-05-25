import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/infrastructure/repositories/asset.dart';
import 'package:gift_box/infrastructure/repositories/awesome_shop.dart';
import 'package:gift_box/infrastructure/repositories/logger.dart';
import 'package:gift_box/infrastructure/repositories/nfc.dart';
import 'package:gift_box/static/config.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:path_provider/path_provider.dart';

export 'package:gift_box/domain/utils/extensions/get_it.dart';
export 'package:gift_box/static/i18n/translations.g.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    instance
      ..registerLazySingleton<AssetApi>(AssetRepository.new)
      ..registerLazySingleton<AwesomeShopApi>(AwesomeShopRepository.new)
      ..registerLazySingleton<Logger>(Logger.new)
      ..registerLazySingleton<LoggerApi>(
        () => LoggerRepository(
          Logger(
            printer: PrettyPrinter(stackTraceBeginIndex: 2, methodCount: 4),
          ),
        ),
      )
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

    final appDir = await getApplicationDocumentsDirectory();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(appDir.path),
    );
  }

  static Translations _createTranslations() => AppLocale.en.buildSync();
}

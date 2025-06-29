import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/native.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/infrastructure/repositories/awesome_shop.dart';
import 'package:gift_box/infrastructure/repositories/logger.dart';
import 'package:gift_box/infrastructure/repositories/native.dart';
import 'package:gift_box/infrastructure/repositories/nfc.dart';
import 'package:gift_box/static/config.dart';
import 'package:hive_ce/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

export 'package:gift_box/domain/utils/extensions/get_it.dart';
export 'package:gift_box/static/i18n/translations.g.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    final hiveBox = await _initHive();

    instance
      ..registerFactory<AudioPlayer>(AudioPlayer.new)
      ..registerLazySingleton<AwesomeShopApi>(
        () => AwesomeShopRepository(hiveBox),
      )
      ..registerLazySingleton<Logger>(Logger.new)
      ..registerLazySingleton<LoggerApi>(
        () => LoggerRepository(
          Logger(
            printer: PrettyPrinter(stackTraceBeginIndex: 2, methodCount: 4),
          ),
        ),
      )
      ..registerLazySingleton<NativeApi>(
        () => NativeRepository(WidgetsBinding.instance),
      )
      ..registerLazySingleton<NfcApi>(NfcRepository.new)
      ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
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
  }

  static Future<Box<bool>> _initHive() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);

    final [
      hiveBox as Box<bool>,
      hiveStorage as HydratedStorage,
    ] = await Future.wait(
      [
        Hive.openBox<bool>('awesome_shop_items'),
        HydratedStorage.build(
          storageDirectory: HydratedStorageDirectory(appDir.path),
        ),
      ],
    );
    HydratedBloc.storage = hiveStorage;

    return hiveBox;
  }
}

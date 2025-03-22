import 'dart:io' show Platform;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:get_it/get_it.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/domain/utils/extensions/get_it.dart';
import 'package:gift_keys/infrastructure/repositories/file.dart';
import 'package:gift_keys/infrastructure/repositories/logger.dart';
import 'package:gift_keys/infrastructure/repositories/native.dart';
import 'package:gift_keys/infrastructure/repositories/nfc.dart';
import 'package:gift_keys/infrastructure/repositories/sqlite_async.dart';
import 'package:gift_keys/static/i18n/translations.g.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

export 'package:gift_keys/domain/utils/extensions/get_it.dart';
export 'package:gift_keys/static/i18n/translations.g.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static Future<void> setupDependencies() async {
    final (appDir, tmpDir) =
        await (
          getApplicationDocumentsDirectory(),
          getTemporaryDirectory(),
        ).wait;
    const fileSystem = LocalFileSystem();

    instance
      ..registerSingleton<Directory>(
        fileSystem.directory(appDir.path),
        instanceName: 'appDir',
      )
      ..registerSingleton<Directory>(
        fileSystem.directory(tmpDir.path),
        instanceName: 'tmpDir',
      )
      ..registerLazySingleton<FileApi>(FileRepository.new)
      ..registerSingleton<FileSystem>(fileSystem)
      ..registerLazySingleton<LocalDatabaseApi>(SqliteAsyncRepository.new)
      ..registerLazySingleton<LoggerApi>(
        () => LoggerRepository(
          Logger(
            printer: PrettyPrinter(stackTraceBeginIndex: 2, methodCount: 4),
          ),
        ),
      )
      ..registerLazySingleton<NativeApi>(NativeRepository.new)
      ..registerLazySingleton<NfcApi>(NfcRepository.new)
      ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
      ..registerLazySingleton<Translations>(_createTranslations);
    await instance.allReady();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(instance.appDir.path),
    );
  }

  static Translations _createTranslations() =>
      switch (Platform.localeName) {
        'de_DE' => AppLocale.de,
        _ => AppLocale.en,
      }.buildSync();
}

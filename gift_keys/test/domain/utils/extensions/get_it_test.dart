import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/injector.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../mocks.dart';

void main() {
  test('returns Application Directory.', () {
    final appDir = MockDirectory();
    Injector.instance.registerSingleton<Directory>(
      appDir,
      instanceName: 'appDir',
    );
    addTearDown(
      () async =>
          Injector.instance.unregister<Directory>(instanceName: 'appDir'),
    );

    expect(Injector.instance.appDir, appDir);
  });

  test('returns Temporary Directory.', () {
    final tmpDir = MockDirectory();
    Injector.instance.registerSingleton<Directory>(
      tmpDir,
      instanceName: 'tmpDir',
    );
    addTearDown(
      () async =>
          Injector.instance.unregister<Directory>(instanceName: 'tmpDir'),
    );

    expect(Injector.instance.tmpDir, tmpDir);
  });

  test('returns FileApi.', () {
    final fileApi = MockFileApi();
    Injector.instance.registerSingleton<FileApi>(fileApi);
    addTearDown(Injector.instance.unregister<FileApi>);

    expect(Injector.instance.fileApi, fileApi);
  });

  test('returns FileSystem.', () {
    final fileSystem = MemoryFileSystem();
    Injector.instance.registerSingleton<FileSystem>(fileSystem);
    addTearDown(Injector.instance.unregister<FileSystem>);

    expect(Injector.instance.fileSystem, fileSystem);
  });

  test('returns LocalDatabaseApi.', () {
    final localDatabaseApi = MockLocalDatabaseApi();
    Injector.instance.registerSingleton<LocalDatabaseApi>(localDatabaseApi);
    addTearDown(Injector.instance.unregister<LocalDatabaseApi>);

    expect(Injector.instance.localDatabaseApi, localDatabaseApi);
  });

  test('returns LoggerApi.', () {
    final loggerApi = MockLoggerApi();
    Injector.instance.registerSingleton<LoggerApi>(loggerApi);
    addTearDown(Injector.instance.unregister<LoggerApi>);

    expect(Injector.instance.loggerApi, loggerApi);
  });

  test('returns NativeApi.', () {
    final nativeApi = MockNativeApi();
    Injector.instance.registerSingleton<NativeApi>(nativeApi);
    addTearDown(Injector.instance.unregister<NativeApi>);

    expect(Injector.instance.nativeApi, nativeApi);
  });

  test('returns NfcApi.', () {
    final nfcApi = MockNfcApi();
    Injector.instance.registerSingleton<NfcApi>(nfcApi);
    addTearDown(Injector.instance.unregister<NfcApi>);

    expect(Injector.instance.nfcApi, nfcApi);
  });

  test('returns PackageInfo.', () async {
    PackageInfo.setMockInitialValues(
      appName: 'appName',
      packageName: 'packageName',
      version: 'version',
      buildNumber: 'buildNumber',
      buildSignature: 'buildSignature',
    );
    final packageInfo = await PackageInfo.fromPlatform();
    Injector.instance.registerSingleton<PackageInfo>(packageInfo);
    addTearDown(Injector.instance.unregister<PackageInfo>);

    expect(Injector.instance.packageInfo, packageInfo);
  });

  test('returns Translations.', () {
    final translations = AppLocale.en.buildSync();
    Injector.instance.registerSingleton<Translations>(translations);
    addTearDown(Injector.instance.unregister<Translations>);

    expect(Injector.instance.translations, translations);
  });
}

import 'package:file/file.dart';
import 'package:get_it/get_it.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/static/i18n/translations.g.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension GetItExtension on GetIt {
  Directory get appDir => get<Directory>(instanceName: 'appDir');

  Directory get tmpDir => get<Directory>(instanceName: 'tmpDir');

  FileApi get fileApi => get<FileApi>();

  FileSystem get fileSystem => get<FileSystem>();

  LocalDatabaseApi get localDatabaseApi => get<LocalDatabaseApi>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NativeApi get nativeApi => get<NativeApi>();

  NfcApi get nfcApi => get<NfcApi>();

  PackageInfo get packageInfo => get<PackageInfo>();

  Translations get translations => get<Translations>();
}

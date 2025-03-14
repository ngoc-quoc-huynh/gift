import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:gift_keys/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';

extension GetItExtension on GetIt {
  Directory get appDir => get<Directory>(instanceName: 'appDir');

  FileApi get fileApi => get<FileApi>();

  LocalDatabaseApi get localDatabaseApi => get<LocalDatabaseApi>();

  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NfcApi get nfcApi => get<NfcApi>();

  Translations get translations => get<Translations>();
}

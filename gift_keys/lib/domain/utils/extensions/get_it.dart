import 'package:get_it/get_it.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';

extension GetItExtension on GetIt {
  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  Translations get translations => get<Translations>();
}

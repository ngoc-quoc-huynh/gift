import 'dart:async';
import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';

extension GetItExtension on GetIt {
  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  Random get random => get<Random>();

  Timer periodicTimer(
    Duration duration,
    void Function(Timer timer) callback,
  ) =>
      get(param1: duration, param2: callback);

  Translations get translations => get<Translations>();

  void registerPeriodicTimer() =>
      registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
        Timer.periodic,
      );
}

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:logger/logger.dart';

extension GetItExtension on GetIt {
  Uint8List get aid => get<Uint8List>(instanceName: 'aid');

  AssetApi get assetApi => get<AssetApi>();

  DateTime get birthday => get<DateTime>(instanceName: 'birthday');

  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NfcApi get nfcApi => get<NfcApi>();

  Uint8List get pin => get<Uint8List>(instanceName: 'pin');

  Random get random => get<Random>();

  Timer periodicTimer(Duration duration, void Function(Timer timer) callback) =>
      get(param1: duration, param2: callback);

  Translations get translations => get<Translations>();
}

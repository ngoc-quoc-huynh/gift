import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/native.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:gift_box/static/i18n/translations.g.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension GetItExtension on GetIt {
  Uint8List get aid => get<Uint8List>(instanceName: 'aid');

  AudioPlayer get audioPlayer => get<AudioPlayer>();

  AssetApi get assetApi => get<AssetApi>();

  AwesomeShopApi get awesomeShopApi => get<AwesomeShopApi>();

  DateTime get birthday => get<DateTime>(instanceName: 'birthday');

  Logger get logger => get<Logger>();

  LoggerApi get loggerApi => get<LoggerApi>();

  NativeApi get nativeApi => get<NativeApi>();

  NfcApi get nfcApi => get<NfcApi>();

  PackageInfo get packageInfo => get<PackageInfo>();

  Uint8List get pin => get<Uint8List>(instanceName: 'pin');

  Random get random => get<Random>();

  Timer periodicTimer(Duration duration, void Function(Timer timer) callback) =>
      get(param1: duration, param2: callback);

  Translations get translations => get<Translations>();
}

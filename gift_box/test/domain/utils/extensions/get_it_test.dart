import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/interfaces/asset.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/injector.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  test('returns aid.', () {
    final aid = Uint8List(0);
    Injector.instance.registerAid(aid);
    addTearDown(Injector.instance.unregisterAid);

    expectList(Injector.instance.aid, aid);
  });

  test('returns AudioPlayer.', () {
    final audioPlayer = MockAudioPlayer();
    Injector.instance.registerSingleton<AudioPlayer>(audioPlayer);
    addTearDown(Injector.instance.unregister<AudioPlayer>);

    expect(Injector.instance.audioPlayer, audioPlayer);
  });

  test('returns AssetApi.', () {
    final assetApi = MockAssetApi();
    Injector.instance.registerSingleton<AssetApi>(assetApi);
    addTearDown(Injector.instance.unregister<AssetApi>);

    expect(Injector.instance.assetApi, assetApi);
  });

  test('returns birthday.', () {
    final birthday = DateTime(2025);
    Injector.instance.registerBirthday(birthday);
    addTearDown(Injector.instance.unregisterBirthday);

    expect(Injector.instance.birthday, birthday);
  });

  test('returns Logger.', () {
    final logger = MockLogger();
    Injector.instance.registerSingleton<Logger>(logger);
    addTearDown(Injector.instance.unregister<Logger>);

    expect(Injector.instance.logger, logger);
  });

  test('returns LoggerApi.', () {
    final loggerApi = MockLoggerApi();
    Injector.instance.registerSingleton<LoggerApi>(loggerApi);
    addTearDown(Injector.instance.unregister<LoggerApi>);

    expect(Injector.instance.loggerApi, loggerApi);
  });

  test('returns periodic timer correctly.', () {
    Injector.instance
        .registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
          Timer.periodic,
        );
    final periodicTimer = Injector.instance.periodicTimer(Duration.zero, (_) {
      return;
    });
    addTearDown(periodicTimer.cancel);

    expect(periodicTimer, isA<Timer>());
  });

  test('returns pin.', () {
    final pin = Uint8List(0);
    Injector.instance.registerPin(pin);
    addTearDown(Injector.instance.unregisterPin);

    expectList(Injector.instance.pin, pin);
  });

  test('returns Random.', () {
    final random = Random();
    Injector.instance.registerSingleton<Random>(random);
    addTearDown(Injector.instance.unregister<Random>);

    expect(Injector.instance.random, random);
  });

  test('returns Translations.', () {
    final translations = AppLocale.en.buildSync();
    Injector.instance.registerSingleton<Translations>(translations);
    addTearDown(Injector.instance.unregister<Translations>);

    expect(Injector.instance.translations, translations);
  });
}

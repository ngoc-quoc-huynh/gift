import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final pageConstraints = BoxConstraints.tight(const Size(360, 640));
final widgetConstraints = BoxConstraints.tight(const Size.square(500));

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

extension GetItTestExtension on GetIt {
  void registerAid(Uint8List aid) => registerLazySingleton<Uint8List>(
        () => aid,
        instanceName: 'aid',
      );

  void registerBirthday(DateTime dateTime) => registerLazySingleton<DateTime>(
        () => dateTime,
        instanceName: 'birthday',
      );

  void registerPin(Uint8List pin) => registerLazySingleton<Uint8List>(
        () => pin,
        instanceName: 'pin',
      );

  Future<void> unregisterAid() async =>
      unregister<Uint8List>(instanceName: 'aid');

  Future<void> unregisterBirthday() async =>
      unregister<DateTime>(instanceName: 'birthday');

  Future<void> unregisterPin() async =>
      unregister<Uint8List>(instanceName: 'pin');

  void registerPeriodicTimer() =>
      registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
        Timer.periodic,
      );
}

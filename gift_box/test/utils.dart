import 'dart:async';

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
  void registerBirthday(DateTime dateTime) => registerLazySingleton<DateTime>(
        () => dateTime,
        instanceName: 'birthday',
      );

  Future<void> unregisterBirthday() async =>
      unregister<DateTime>(instanceName: 'birthday');

  void registerPeriodicTimer() =>
      registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
        Timer.periodic,
      );
}

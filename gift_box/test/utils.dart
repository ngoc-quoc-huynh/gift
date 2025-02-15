import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

extension GetItTestExtension on GetIt {
  void registerBirthday(DateTime dateTime) => registerLazySingleton<DateTime>(
        () => dateTime,
        instanceName: 'birthday',
      );

  void registerPeriodicTimer() =>
      registerFactoryParam<Timer, Duration, void Function(Timer timer)>(
        Timer.periodic,
      );
}

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_satisfactory/domain/utils/extensions/list.dart';
import 'package:gift_box_satisfactory/injector.dart';

import '../../../utils.dart';

void main() {
  group('shuffleSeeded', () {
    test('returns correctly.', () {
      Injector.instance.registerSingleton<Random>(Random(0));
      addTearDown(Injector.instance.unregister<Random>);

      expectList([1, 2, 3]..shuffleSeeded(), [3, 2, 1]);
    });
  });
}

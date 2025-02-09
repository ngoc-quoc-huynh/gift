import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';

void main() {
  test(
    'returns initial state correctly.',
    () => expect(ValueCubit(0).state, 0),
  );

  group('update', () {
    blocTest<ValueCubit<int>, int>(
      'emits new state.',
      build: () => ValueCubit(0),
      act: (cubit) => cubit.update(1),
      expect: () => [1],
    );
  });
}

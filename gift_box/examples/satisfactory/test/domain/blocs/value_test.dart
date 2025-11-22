import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';

void main() {
  group('BoolCubit', () {
    test(
      'initial state is false.',
      () => expect(BoolCubit(false).state, false),
    );

    blocTest<BoolCubit, bool>(
      'emits true when update is called.',
      build: () => BoolCubit(false),
      act: (cubit) => cubit.update(true),
      expect: () => const [true],
    );
  });
}

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/ui/widgets/key/builder.dart';

import '../../../mocks.dart';

void main() {
  testWidgets('throws assertion error when state is not success.', (
    tester,
  ) async {
    final bloc = MockKeyBloc();
    whenListen(
      bloc,
      const Stream<KeyState>.empty(),
      initialState: const KeyLoadInProgress(),
    );

    await tester.pumpWidget(
      BlocProvider<KeyBloc>(
        create: (_) => bloc,
        child: KeyPageBuilder(builder: (_) => const SizedBox.shrink()),
      ),
    );

    expect(
      tester.takeException(),
      isA<AssertionError>().having(
        (e) => e.message,
        'message',
        'At this point, the key should be loaded.',
      ),
    );
  });
}

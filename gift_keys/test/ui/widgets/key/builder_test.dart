import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/ui/widgets/key/builder.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    final bloc = MockKeyBloc();
    whenListen(
      bloc,
      const Stream<KeyState>.empty(),
      initialState: KeyLoadOnSuccess(
        GiftKey(
          id: 1,
          name: 'Name',
          birthday: DateTime.utc(2025),
          aid: 'F000000001',
          password: '1234',
        ),
      ),
    );
    final widget = BlocProvider<KeyBloc>(
      create: (_) => bloc,
      child: KeyPageBuilder(builder: (state) => Text(state.toString())),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('builder', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

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

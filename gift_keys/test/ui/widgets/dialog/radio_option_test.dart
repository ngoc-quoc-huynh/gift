import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  const size = Size(250, 50);
  testGolden(
    'renders selected correctly.',
    (tester) async {
      final cubit = MockValueCubit<int>();
      whenListen(cubit, const Stream<int>.empty(), initialState: 0);
      final widget = BlocProvider<ValueCubit<int>>(
        create: (_) => cubit,
        child: const RadioDialogOption(title: 'Option 0', value: 0),
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('radio_option_selected', find.byWidget(widget));
    },
    surfaceSize: size,
  );

  testGolden(
    'renders unselected correctly.',
    (tester) async {
      final cubit = MockValueCubit<int>();
      whenListen(cubit, const Stream<int>.empty(), initialState: 0);
      final widget = BlocProvider<ValueCubit<int>>(
        create: (_) => cubit,
        child: const RadioDialogOption(title: 'Option 1', value: 1),
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('radio_option_unselected', find.byWidget(widget));
    },
    surfaceSize: size,
  );
}

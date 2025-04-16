import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final date = DateTime(2025);

  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    final cubit = MockValueCubit<DateTime>();
    whenListen(cubit, const Stream<DateTime>.empty(), initialState: date);

    await withClock(Clock.fixed(date), () async {
      final widget = BlocProvider<DateTimeValueCubit>(
        create: (_) => cubit,
        child: DateFormField(labelText: 'Date'),
      );
      await tester.pumpGoldenWidget(widget);
      await tester.tap(find.byWidget(widget));
      await tester.pumpAndSettle();
    });

    await expectGoldenFile('date', find.byType(MaterialApp));
  });

  testWidgets('submits correctly.', (tester) async {
    final cubit = MockValueCubit<DateTime?>();
    // ignore: close_sinks, otherwise the test will freeze. See https://github.com/dart-lang/tools/issues/2074
    final controller = StreamController<DateTime?>();
    // addTearDown(controller.close);

    whenListen(cubit, const Stream<DateTime>.empty());
    when(() => cubit.update(date)).thenAnswer((_) => controller.add(date));

    await withClock(Clock.fixed(date), () async {
      final widget = MaterialApp(
        home: Material(
          child: BlocProvider<DateTimeValueCubit>(
            create: (_) => cubit,
            child: DateFormField(labelText: 'Date'),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byWidget(widget));
      await tester.pump();
    });

    expect(find.byType(DatePickerDialog), findsOneWidget);
    final dataCell = find.descendant(
      of: find.byType(DatePickerDialog),
      matching: find.text('1'),
    );
    expect(dataCell, findsOneWidget);
    await tester.tap(dataCell);
    await tester.pump();
    await tester.tap(find.text('OK'));
    await tester.pump();

    // Verify cubit state is updated
    verify(() => cubit.update(date));
  });
}

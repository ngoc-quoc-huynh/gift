import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';
import 'package:go_router/go_router.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  const size = Size(350, 300);

  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders alert correctly.', (tester) async {
    final widget = CustomDialog.alert(
      title: 'Title',
      content: const Text('Content'),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(result: () => true),
      ],
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('dialog_alert', find.byWidget(widget));
  }, surfaceSize: size);

  testGolden('renders normal correctly.', (tester) async {
    final widget = CustomDialog.normal(
      title: 'Title',
      content: const Text('Content'),
      action: AlertDialogAction.confirm(result: () => true),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('dialog_normal', find.byWidget(widget));
  }, surfaceSize: size);

  group('radio', () {
    testGolden('renders correctly.', (tester) async {
      final cubit = MockValueCubit<int>();
      whenListen(cubit, const Stream<int>.empty(), initialState: 1);
      final widget = BlocProvider<ValueCubit<int>>(
        create: (_) => cubit,
        child: CustomDialog.radio(
          title: 'Title',
          options: const [
            RadioDialogOption(title: 'Option 0', value: 0),
            RadioDialogOption(title: 'Option 1', value: 1),
          ],
        ),
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('dialog_radio', find.byWidget(widget));
    }, surfaceSize: size);

    testWidgets('changes value correctly.', (tester) async {
      final cubit = MockValueCubit<int>();
      whenListen(cubit, const Stream<int>.empty(), initialState: 0);

      final widget = MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, _) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final result = await showDialog<int>(
                    context: context,
                    builder:
                        (context) => BlocProvider<ValueCubit<int>>(
                          create: (_) => cubit,
                          child: CustomDialog.radio(
                            title: 'Title',
                            options: const [
                              RadioDialogOption(title: 'Option 0', value: 0),
                            ],
                          ),
                        ),
                  );
                  expect(result, 0);
                });
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      final button = find.byType(TextButton);
      expect(button, findsNWidgets(2));
      await tester.tap(button.last);
      await tester.pumpAndSettle();

      expect(button, findsNothing);
    });
  });
}

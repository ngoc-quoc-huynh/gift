import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';
import 'package:material_ui/material_ui.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  group('radio', () {
    testWidgets('changes value correctly.', (tester) async {
      final cubit = MockValueCubit<int>();
      whenListen(cubit, const Stream<int>.empty(), initialState: 0);

      final widget = TestGoRouter(
        onTestSetup: (context) =>
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final result = await showDialog<int>(
                context: context,
                builder: (context) => BlocProvider<ValueCubit<int>>(
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
            }),
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

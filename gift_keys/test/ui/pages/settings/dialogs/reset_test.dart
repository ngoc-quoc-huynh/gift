import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/reset.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  setUpAll(
    () => Injector.instance.registerSingleton<Translations>(
      AppLocale.en.buildSync(),
    ),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    const widget = SettingsResetDialog();
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('reset', find.byWidget(widget));
  }, surfaceSize: const Size(500, 300));

  testWidgets('show returns correctly.', (tester) async {
    final bloc = MockKeyMetasBloc();
    whenListen(
      bloc,
      const Stream<KeyMetasState>.empty(),
      initialState: const KeyMetasLoadOnSuccess([]),
    );

    final widget = BlocProvider<KeyMetasBloc>(
      create: (_) => bloc,
      child: TestGoRouter(
        onTestSetup:
            (context) => WidgetsBinding.instance.addPostFrameCallback(
              (_) => SettingsResetDialog.show(context),
            ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byType(TextButton).last);

    expect(bloc.state, const KeyMetasLoadOnSuccess([]));
    verify(() => bloc.add(const KeyMetasResetEvent())).called(1);
  });
}

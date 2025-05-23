import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/design.dart';
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
    final cubit = MockValueCubit<ThemeMode>();
    whenListen(
      cubit,
      const Stream<ThemeMode>.empty(),
      initialState: ThemeMode.light,
    );

    final widget = BlocProvider<ThemeModeValueCubit>(
      create: (_) => cubit,
      child: const SettingsDesignDialog(),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('design', find.byWidget(widget));
  }, surfaceSize: const Size(500, 400));

  testWidgets('show returns correctly.', (tester) async {
    final cubit = MockThemeModeHydratedValueCubit();
    whenListen(
      cubit,
      const Stream<ThemeMode>.empty(),
      initialState: ThemeMode.light,
    );
    when(cubit.close).thenAnswer((_) => Future.value());

    final widget = BlocProvider<ThemeModeHydratedValueCubit>(
      create: (_) => cubit,
      child: TestGoRouter(
        onTestSetup: (context) => WidgetsBinding.instance.addPostFrameCallback(
          (_) => SettingsDesignDialog.show(context, ThemeMode.light),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byType(TextButton).last);

    expect(cubit.state, ThemeMode.light);
    verify(() => cubit.update(ThemeMode.light)).called(1);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/language.dart';
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

  testGolden(
    'renders correctly.',
    (tester) async {
      final cubit = MockValueCubit<LanguageOption>();
      whenListen(
        cubit,
        const Stream<LanguageOption>.empty(),
        initialState: LanguageOption.english,
      );

      final widget = BlocProvider<LanguageOptionValueCubit>(
        create: (_) => cubit,
        child: const SettingsLanguageDialog(),
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('language', find.byWidget(widget));
    },
    surfaceSize: const Size(500, 400),
  );

  testWidgets('show returns correctly.', (tester) async {
    final cubit = MockLanguageOptionHydratedValueCubit();
    whenListen(
      cubit,
      const Stream<LanguageOption>.empty(),
      initialState: LanguageOption.english,
    );
    when(cubit.close).thenAnswer((_) => Future.value());

    final widget = BlocProvider<LanguageOptionHydratedValueCubit>(
      create: (_) => cubit,
      child: TestGoRouter(
        onTestSetup: (context) => WidgetsBinding.instance.addPostFrameCallback(
          (_) => SettingsLanguageDialog.show(context, LanguageOption.english),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pump();
    await tester.tap(find.byType(TextButton).last);

    expect(cubit.state, LanguageOption.english);
    verify(() => cubit.update(LanguageOption.english)).called(1);
  });
}

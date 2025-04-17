import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/domain/models/language.dart';
import 'package:gift_keys/domain/utils/extensions/theme_data.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:gift_keys/ui/pages/license/page.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/cache.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/design.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/feedback.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/language.dart';
import 'package:gift_keys/ui/pages/settings/dialogs/reset.dart';
import 'package:gift_keys/ui/pages/settings/page.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final packageInfo = MockPackageInfo();
  when(() => packageInfo.version).thenReturn('1.0.0');
  final themeModeCubit = MockThemeModeHydratedValueCubit();
  when(themeModeCubit.close).thenAnswer((_) => Future.value());
  final languageOptionCubit = MockLanguageOptionHydratedValueCubit();
  when(languageOptionCubit.close).thenAnswer((_) => Future.value());
  final keyMetasBloc = MockKeyMetasBloc();
  final widget = MultiBlocProvider(
    providers: [
      BlocProvider<ThemeModeHydratedValueCubit>(create: (_) => themeModeCubit),
      BlocProvider<LanguageOptionHydratedValueCubit>(
        create: (_) => languageOptionCubit,
      ),
      BlocProvider<KeyMetasBloc>(create: (_) => keyMetasBloc),
    ],
    child: const SettingsPage(),
  );

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<PackageInfo>(packageInfo)
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    whenListen(
      themeModeCubit,
      const Stream<ThemeMode>.empty(),
      initialState: ThemeMode.light,
    );
    whenListen(
      languageOptionCubit,
      const Stream<LanguageOption>.empty(),
      initialState: LanguageOption.english,
    );
    whenListen(
      keyMetasBloc,
      const Stream<KeyMetasState>.empty(),
      initialState: const KeyMetasLoadOnSuccess([]),
    );

    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('page', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

  group('items', () {
    final theme = CustomTheme.lightTheme(const TextTheme());
    final app = MaterialApp.router(
      theme: theme,
      routerConfig: GoRouter(
        routes: [GoRoute(path: '/', builder: (context, state) => widget)],
      ),
    );
    whenListen(
      themeModeCubit,
      const Stream<ThemeMode>.empty(),
      initialState: ThemeMode.light,
    );
    whenListen(
      languageOptionCubit,
      const Stream<LanguageOption>.empty(),
      initialState: LanguageOption.english,
    );
    whenListen(
      keyMetasBloc,
      const Stream<KeyMetasState>.empty(),
      initialState: const KeyMetasLoadOnSuccess([]),
    );

    testWidgets('shows SettingsDesignDialog correctly.', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.brightness_6_rounded));
      await tester.pump();

      expect(find.byType(SettingsDesignDialog), findsOneWidget);
    });

    testWidgets('shows SettingsLanguageDialog correctly.', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.flag_outlined));
      await tester.pump();

      expect(find.byType(SettingsLanguageDialog), findsOneWidget);
    });

    testWidgets('shows SettingsCacheDialog correctly.', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.cached_outlined));
      await tester.pump();

      expect(find.byType(SettingsCacheDialog), findsOneWidget);
    });

    testWidgets('shows SettingsResetDialog correctly.', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.restart_alt));
      await tester.pump();

      expect(find.byType(SettingsResetDialog), findsOneWidget);
    });

    testWidgets('shows SettingsFeedbackDialog correctly.', (tester) async {
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.feedback_outlined));
      await tester.pump();

      expect(find.byType(SettingsFeedbackDialog), findsOneWidget);
    });

    testWidgets('shows CustomLicensePage correctly.', (tester) async {
      final app = MaterialApp.router(
        theme: theme,
        routerConfig: GoRouter(
          routes: [
            GoRoute(path: '/', builder: (context, state) => widget),
            GoRoute(
              name: Routes.licensePage(),
              path: '/license',
              builder: (context, state) => const CustomLicensePage(),
            ),
          ],
        ),
      );
      await tester.pumpWidget(app);
      await tester.tap(find.byIcon(Icons.library_books_outlined));
      await tester.pumpAndSettle();

      expect(find.byType(CustomLicensePage), findsOneWidget);
    });
  });

  group('SnackBars', () {
    final theme = CustomTheme.lightTheme(const TextTheme());
    final app = MaterialApp(theme: theme, home: widget);

    testWidgets('shows success snack bar when language changes.', (
      tester,
    ) async {
      whenListen(
        themeModeCubit,
        const Stream<ThemeMode>.empty(),
        initialState: ThemeMode.light,
      );
      whenListen(
        languageOptionCubit,
        Stream.value(LanguageOption.german),
        initialState: LanguageOption.english,
      );
      whenListen(
        keyMetasBloc,
        const Stream<KeyMetasState>.empty(),
        initialState: const KeyMetasLoadOnSuccess([]),
      );

      await tester.pumpWidget(app);
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.customColors.success);
    });

    testWidgets('shows success snack bar when theme mode changes.', (
      tester,
    ) async {
      whenListen(
        themeModeCubit,
        Stream.value(ThemeMode.dark),
        initialState: ThemeMode.light,
      );
      whenListen(
        languageOptionCubit,
        const Stream<LanguageOption>.empty(),
        initialState: LanguageOption.english,
      );
      whenListen(
        keyMetasBloc,
        const Stream<KeyMetasState>.empty(),
        initialState: const KeyMetasLoadOnSuccess([]),
      );

      await tester.pumpWidget(app);
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.customColors.success);
    });

    testWidgets('shows success snack bar when keys state changes.', (
      tester,
    ) async {
      whenListen(
        themeModeCubit,
        const Stream<ThemeMode>.empty(),
        initialState: ThemeMode.light,
      );
      whenListen(
        languageOptionCubit,
        const Stream<LanguageOption>.empty(),
        initialState: LanguageOption.english,
      );
      whenListen(
        keyMetasBloc,
        Stream.value(const KeyMetasLoadOnSuccess([])),
        initialState: KeyMetasLoadOnSuccess([
          GiftKeyMeta(id: 1, name: 'Name', birthday: DateTime(2025)),
        ]),
      );

      await tester.pumpWidget(app);
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.customColors.success);
    });

    testWidgets('shows error snack bar when keys state changes.', (
      tester,
    ) async {
      whenListen(
        themeModeCubit,
        const Stream<ThemeMode>.empty(),
        initialState: ThemeMode.light,
      );
      whenListen(
        languageOptionCubit,
        const Stream<LanguageOption>.empty(),
        initialState: LanguageOption.english,
      );
      whenListen(
        keyMetasBloc,
        Stream.value(const KeyMetasResetOnFailure([])),
        initialState: const KeyMetasLoadOnSuccess([]),
      );

      await tester.pumpWidget(app);
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.colorScheme.error);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:gift_keys/ui/pages/add_key/page.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:gift_keys/ui/widgets/form_field/image/button.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final fileApi = MockFileApi();
  final localDatabaseApi = MockLocalDatabaseApi();
  final nativeApi = MockNativeApi();

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<FileApi>(fileApi)
          ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
          ..registerSingleton<NativeApi>(nativeApi)
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    const widget = AddKeyPage();
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('page', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

  group('Submit', () {
    const aid = 'F000000001';
    const password = '1234';
    final birthday = DateTime(2025);
    const name = 'Name';
    const id = 1;
    final giftKey = GiftKeyMeta(id: id, name: name, birthday: birthday);
    final image = MemoryFileSystem().file('test.png')..createSync();
    final compressedImage = MemoryFileSystem().file('test.webp')..createSync();
    final theme = CustomTheme.lightTheme(const TextTheme());
    const screenWidth = 800;

    testWidgets('returns correctly after success.', (tester) async {
      when(fileApi.pickImageFromGallery).thenAnswer((_) async => image);
      when(
        () => nativeApi.compressImage(image.path, screenWidth),
      ).thenAnswer((_) async => compressedImage);
      when(
        () => localDatabaseApi.saveKey(
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).thenAnswer((_) async => giftKey);
      when(
        () => fileApi.moveFileToAppDir(compressedImage.path, id),
      ).thenAnswer((_) => Future.value());

      final bloc = MockKeyMetasBloc();
      whenListen(
        bloc,
        Stream.value(KeyMetasLoadOnSuccess([giftKey])),
        initialState: const KeyMetasLoadOnSuccess([]),
      );

      final goRouter = GoRouter(
        initialLocation: '/add-key',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(),
            routes: [
              GoRoute(path: 'add-key', builder: (_, _) => const AddKeyPage()),
            ],
          ),
        ],
      );

      final textFormFields = find.byType(CustomTextFormField);
      await withClock(Clock.fixed(DateTime(2025)), () async {
        final widget = BlocProvider<KeyMetasBloc>(
          create: (_) => bloc,
          child: MaterialApp.router(theme: theme, routerConfig: goRouter),
        );
        await tester.pumpWidget(widget);
        await tester.tap(find.byType(ImagePickerButton));
        await tester.pump();

        await tester.enterText(textFormFields.first, name);

        await tester.tap(find.byType(DateFormField));
        await tester.pump();
      });

      await tester.tap(
        find.descendant(
          of: find.byType(DatePickerDialog),
          matching: find.text('1'),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();

      await tester.enterText(textFormFields.at(1), aid);
      await tester.enterText(textFormFields.at(2), password);

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(goRouter.canPop(), false);
      verify(fileApi.pickImageFromGallery).called(1);
      verify(() => nativeApi.compressImage(image.path, screenWidth)).called(1);
      verify(
        () => localDatabaseApi.saveKey(
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).called(1);
      verify(
        () => fileApi.moveFileToAppDir(compressedImage.path, id),
      ).called(1);
      verify(() => bloc.add(KeyMetasAddEvent(giftKey))).called(1);
    });

    testWidgets('shows snack bar on error.', (tester) async {
      when(fileApi.pickImageFromGallery).thenAnswer((_) async => image);
      when(
        () => nativeApi.compressImage(image.path, screenWidth),
      ).thenAnswer((_) async => compressedImage);
      when(
        () => localDatabaseApi.saveKey(
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).thenThrow(const LocalDatabaseException());

      final textFormFields = find.byType(CustomTextFormField);
      await withClock(Clock.fixed(DateTime(2025)), () async {
        final widget = MaterialApp(theme: theme, home: const AddKeyPage());
        await tester.pumpWidget(widget);

        await tester.tap(find.byType(ImagePickerButton).first);
        await tester.pump();

        await tester.enterText(textFormFields.first, name);

        await tester.tap(find.byType(DateFormField));
        await tester.pump();
      });

      await tester.tap(
        find.descendant(
          of: find.byType(DatePickerDialog),
          matching: find.text('1'),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('OK'));
      await tester.pump();

      await tester.enterText(textFormFields.at(1), aid);
      await tester.enterText(textFormFields.at(2), password);

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.colorScheme.error);

      verify(fileApi.pickImageFromGallery).called(1);
      verify(() => nativeApi.compressImage(image.path, any())).called(1);
      verify(
        () => localDatabaseApi.saveKey(
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).called(1);
      verifyNever(() => fileApi.moveFileToAppDir(compressedImage.path, id));
    });
  });
}

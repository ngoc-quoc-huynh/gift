import 'package:bloc_test/bloc_test.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/theme.dart';
import 'package:gift_keys/ui/pages/edit_key/page.dart';
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
    when(
      () => fileApi.loadImage(1),
    ).thenReturn(MemoryFileSystem().file('test.webp')..createSync());

    final widget = EditKeyPage(
      giftKey: GiftKey(
        id: 1,
        name: 'Name',
        birthday: DateTime(2025),
        aid: 'F000000001',
        password: '1234',
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('page', find.byWidget(widget));
    verify(() => fileApi.loadImage(1)).called(1);
  }, surfaceSize: pageSurfaceSize);

  group('Submit', () {
    const aid = 'F000000001';
    const password = '1234';
    final birthday = DateTime(2025);
    const name = 'Name';
    const id = 1;
    final giftKey = GiftKey(
      id: id,
      name: name,
      birthday: birthday,
      aid: aid,
      password: password,
    );
    final giftKeyMeta = GiftKeyMeta(id: id, name: name, birthday: birthday);
    final image = MemoryFileSystem().file('test.webp')..createSync();
    final theme = CustomTheme.lightTheme(const TextTheme());

    testWidgets('returns correctly after success.', (tester) async {
      when(() => fileApi.loadImage(id)).thenReturn(image);
      when(
        () => localDatabaseApi.updateKey(
          id: id,
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).thenAnswer((_) async => giftKeyMeta);
      when(
        () => fileApi.moveFileToAppDir(image.path, id),
      ).thenAnswer((_) => Future.value());

      final keyMetasBloc = MockKeyMetasBloc();
      whenListen(
        keyMetasBloc,
        const Stream<KeyMetasState>.empty(),
        initialState: KeyMetasLoadOnSuccess([giftKeyMeta]),
      );
      final keyBloc = MockKeyBloc();
      whenListen(
        keyBloc,
        const Stream<KeyState>.empty(),
        initialState: KeyLoadOnSuccess(giftKey),
      );
      final nfcDiscoveryBloc = MockNfcDiscoveryBloc();
      whenListen(
        nfcDiscoveryBloc,
        const Stream<NfcDiscoveryState>.empty(),
        initialState: const NfcDiscoveryLoadInProgress(),
      );

      final goRouter = GoRouter(
        initialLocation: '/edit-key',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(),
            routes: [
              GoRoute(
                path: 'edit-key',
                builder: (_, _) => EditKeyPage(giftKey: giftKey),
              ),
            ],
          ),
        ],
      );

      final widget = MultiBlocProvider(
        providers: [
          BlocProvider<KeyMetasBloc>(create: (_) => keyMetasBloc),
          BlocProvider<KeyBloc>(create: (_) => keyBloc),
          BlocProvider<NfcDiscoveryBloc>(create: (_) => nfcDiscoveryBloc),
        ],
        child: MaterialApp.router(theme: theme, routerConfig: goRouter),
      );
      await tester.pumpWidget(widget);

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(goRouter.canPop(), false);
      verify(() => fileApi.loadImage(id)).called(1);
      verify(
        () => localDatabaseApi.updateKey(
          id: id,
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).called(1);
      verify(() => fileApi.moveFileToAppDir(image.path, id)).called(1);
      verify(
        () => keyMetasBloc.add(KeyMetasUpdateEvent(giftKeyMeta)),
      ).called(1);
      verify(() => keyBloc.add(const KeyInitializeEvent())).called(1);
      verify(
        () => nfcDiscoveryBloc.add(const NfcDiscoveryResumeEvent()),
      ).called(1);
    });

    testWidgets('shows snack bar on error.', (tester) async {
      when(() => fileApi.loadImage(id)).thenReturn(image);
      when(
        () => localDatabaseApi.updateKey(
          id: id,
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).thenThrow(const LocalDatabaseException());

      final widget = MaterialApp(
        theme: theme,
        home: EditKeyPage(giftKey: giftKey),
      );
      await tester.pumpWidget(widget);

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);
      final snackBarWidget = tester.widget<SnackBar>(snackBar);
      expect(snackBarWidget.backgroundColor, theme.colorScheme.error);

      verify(() => fileApi.loadImage(id)).called(1);
      verify(
        () => localDatabaseApi.updateKey(
          id: id,
          name: name,
          birthday: birthday,
          aid: aid,
          password: password,
        ),
      ).called(1);
      verifyNever(() => fileApi.moveFileToAppDir(image.path, id));
    });
  });
}

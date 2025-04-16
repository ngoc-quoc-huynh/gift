import 'package:bloc_test/bloc_test.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page/page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  final fileApi = MockFileApi();
  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<FileApi>(fileApi)
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    final bloc = MockKeyFormBloc();
    whenListen(
      bloc,
      const Stream<KeyFormState>.empty(),
      initialState: const KeyFormInitial(),
    );

    final widget = BlocProvider<KeyFormBloc>(
      create: (_) => bloc,
      child: FormFieldPage(
        title: 'Title',
        buttonTitle: 'Button',
        onSubmitted: (_, _, _, _, _) {
          return;
        },
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('page', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

  // ignore: missing-test-assertion, verify is sufficient.
  testWidgets('loads image correctly if provided.', (tester) async {
    final bloc = MockKeyFormBloc();
    whenListen(
      bloc,
      const Stream<KeyFormState>.empty(),
      initialState: const KeyFormInitial(),
    );
    final file = MemoryFileSystem().file('test.png')..createSync();
    when(() => fileApi.loadImage(1)).thenReturn(file);

    final widget = MaterialApp(
      home: BlocProvider<KeyFormBloc>(
        create: (_) => bloc,
        child: FormFieldPage(
          title: 'Title',
          buttonTitle: 'Button',
          giftKey: GiftKey(
            id: 1,
            name: 'Name',
            birthday: DateTime(2025),
            aid: 'Aid',
            password: 'Password',
          ),
          onSubmitted: (_, _, _, _, _) {
            return;
          },
        ),
      ),
    );
    await tester.pumpWidget(widget);

    verify(() => fileApi.loadImage(1)).called(1);
  });
}

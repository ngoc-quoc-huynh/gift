import 'package:bloc_test/bloc_test.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page/body.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  setUpAll(
    () =>
        Injector.instance
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
    final fileCubit = MockValueCubit<File?>();
    whenListen(fileCubit, const Stream<File?>.empty());
    final dateCubit = MockValueCubit<DateTime?>();
    whenListen(dateCubit, const Stream<DateTime>.empty());

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<KeyFormBloc>(create: (_) => bloc),
        BlocProvider<FileValueCubit>(create: (_) => fileCubit),
        BlocProvider<DateTimeValueCubit>(create: (_) => dateCubit),
      ],
      child: FormFieldPageBody(
        buttonTitle: 'Button',
        giftKey: null,
        onSubmitted: (_, _, _, _, _) {
          return;
        },
      ),
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('body', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

  testGolden('renders validators correctly.', (tester) async {
    final bloc = MockKeyFormBloc();
    whenListen(
      bloc,
      const Stream<KeyFormState>.empty(),
      initialState: const KeyFormInitial(),
    );
    final fileCubit = MockValueCubit<File?>();
    whenListen(fileCubit, const Stream<File?>.empty());
    final dateCubit = MockValueCubit<DateTime?>();
    whenListen(dateCubit, const Stream<DateTime>.empty());

    final widget = MultiBlocProvider(
      providers: [
        BlocProvider<KeyFormBloc>(create: (_) => bloc),
        BlocProvider<FileValueCubit>(create: (_) => fileCubit),
        BlocProvider<DateTimeValueCubit>(create: (_) => dateCubit),
      ],
      child: Form(
        child: FormFieldPageBody(
          buttonTitle: 'Button',
          giftKey: null,
          onSubmitted: (_, _, _, _, _) {
            return;
          },
        ),
      ),
    );
    await tester.pumpGoldenWidget(widget);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    await expectGoldenFile('body_validators', find.byWidget(widget));
  }, surfaceSize: pageSurfaceSize);

  group('submit', () {
    final giftKey = GiftKey(
      id: 1,
      name: 'Name',
      birthday: DateTime(2025),
      aid: 'F000000001',
      password: '1234',
    );

    final bloc = MockKeyFormBloc();
    whenListen(
      bloc,
      const Stream<KeyFormState>.empty(),
      initialState: const KeyFormInitial(),
    );
    final fileCubit = MockValueCubit<File?>();
    final file = MemoryFileSystem().file('test.webp')..createSync();
    whenListen(fileCubit, const Stream<File?>.empty(), initialState: file);
    final dateCubit = MockValueCubit<DateTime?>();
    whenListen(
      dateCubit,
      const Stream<DateTime>.empty(),
      initialState: DateTime(2025),
    );

    String? resultImagePath;
    String? resultName;
    DateTime? resultBirthday;
    String? resultAid;
    String? resultPassword;

    final widget = MaterialApp(
      home: Material(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<KeyFormBloc>(create: (_) => bloc),
            BlocProvider<FileValueCubit>(create: (_) => fileCubit),
            BlocProvider<DateTimeValueCubit>(create: (_) => dateCubit),
          ],
          child: Form(
            child: FormFieldPageBody(
              buttonTitle: 'Button',
              giftKey: giftKey,
              onSubmitted: (imagePath, name, birthday, aid, password) {
                resultImagePath = imagePath;
                resultName = name;
                resultBirthday = birthday;
                resultAid = aid;
                resultPassword = password;
              },
            ),
          ),
        ),
      ),
    );

    setUp(() {
      resultImagePath = null;
      resultName = null;
      resultBirthday = null;
      resultAid = null;
      resultPassword = null;
    });

    testWidgets('text.done works correctly.', (tester) async {
      await tester.pumpWidget(widget);
      await tester.enterText(find.byType(CustomTextFormField).last, '1234');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      expect(resultImagePath, file.path);
      expect(resultName, giftKey.name);
      expect(resultBirthday, giftKey.birthday);
      expect(resultAid, giftKey.aid);
      expect(resultPassword, giftKey.password);
    });

    testWidgets('button works correctly.', (tester) async {
      await tester.pumpWidget(widget);
      await tester.tap(find.byType(FilledButton));

      expect(resultImagePath, file.path);
      expect(resultName, giftKey.name);
      expect(resultBirthday, giftKey.birthday);
      expect(resultAid, giftKey.aid);
      expect(resultPassword, giftKey.password);
    });
  });
}

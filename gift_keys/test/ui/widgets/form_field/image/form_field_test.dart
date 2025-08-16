import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/button.dart';
import 'package:gift_keys/ui/widgets/form_field/image/form_field.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  final fileApi = MockFileApi();
  final nativeApi = MockNativeApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileApi>(fileApi)
      ..registerSingleton<NativeApi>(nativeApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden(
    'renders correctly.',
    (tester) async {
      final cubit = MockValueCubit<File?>();
      whenListen(cubit, const Stream<File?>.empty());

      final widget = BlocProvider<FileValueCubit>(
        create: (_) => cubit,
        child: const ImagePickerFormField(initialValue: null),
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('form_field', find.byWidget(widget));
    },
    surfaceSize: const Size.square(180),
  );

  testGolden(
    'renders validator correctly.',
    (tester) async {
      final cubit = MockValueCubit<File?>();
      whenListen(cubit, const Stream<File?>.empty());

      final formKey = GlobalKey<FormState>();
      final widget = Form(
        key: formKey,
        child: BlocProvider<FileValueCubit>(
          create: (_) => cubit,
          child: const ImagePickerFormField(initialValue: null),
        ),
      );
      await tester.pumpGoldenWidget(widget);
      formKey.currentState!.validate();
      await tester.pump();

      await expectGoldenFile('form_field_validator', find.byWidget(widget));
    },
    surfaceSize: const Size(350, 180),
  );

  testWidgets('taps returns correctly.', (tester) async {
    final cubit = MockValueCubit<File?>();
    final controller = StreamController<File?>();
    addTearDown(controller.close);
    whenListen(cubit, controller.stream);
    final pickedImage = MemoryFileSystem().file('test.png')..createSync();
    when(fileApi.pickImageFromGallery).thenAnswer((_) async => pickedImage);
    final compressedImage = MemoryFileSystem().file('test.png')..createSync();
    when(() => nativeApi.compressImage(pickedImage.path, 800)).thenAnswer((
      _,
    ) async {
      controller.add(compressedImage);
      return compressedImage;
    });

    final widget = MaterialApp(
      home: BlocProvider<FileValueCubit>(
        create: (_) => cubit,
        child: const ImagePickerFormField(initialValue: null),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(ImagePickerButton));
    await tester.pump();

    expect(cubit.state, compressedImage);
    verify(() => cubit.update(compressedImage)).called(1);
  });
}

import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/avatar.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  const size = Size.square(100);

  final fileApi = MockFileApi();
  final nativeApi = MockNativeApi();

  setUpAll(() {
    Injector.instance
      ..registerSingleton<FileApi>(fileApi)
      ..registerSingleton<NativeApi>(nativeApi);
  });

  tearDownAll(Injector.instance.reset);

  group('selected', () {
    testGolden('renders correctly.', (tester) async {
      final file = MemoryFileSystem().file('test.png')..createSync();
      final widget = ImagePickerAvatar.selected(
        file: file,
        onImagePicked: (_) {
          return;
        },
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('avatar_selected', find.byWidget(widget));
    }, surfaceSize: size);

    testWidgets('taps returns correctly.', (tester) async {
      final file = MemoryFileSystem().file('test.png')..createSync();
      final newFile = MemoryFileSystem().file('new.png');
      when(fileApi.pickImageFromGallery).thenAnswer((_) async => newFile);
      when(
        () => nativeApi.compressImage(newFile.path, any()),
      ).thenAnswer((_) async => newFile);

      File? result;
      final widget = MaterialApp(
        home: ImagePickerAvatar.selected(
          file: file,
          onImagePicked: (image) => result = image,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pump();
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(result, newFile);
      verify(fileApi.pickImageFromGallery).called(1);
      verify(() => nativeApi.compressImage(newFile.path, any())).called(1);
    });

    // TODO: Add tests for didUpdateWidget
  });

  group('empty', () {
    testGolden('renders correctly.', (tester) async {
      final widget = ImagePickerAvatar.empty(
        onImagePicked: (_) {
          return;
        },
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('avatar_empty', find.byWidget(widget));
    }, surfaceSize: size);

    testWidgets('taps returns correctly.', (tester) async {
      final file = MemoryFileSystem().file('test.png');
      when(fileApi.pickImageFromGallery).thenAnswer((_) async => file);
      when(
        () => nativeApi.compressImage(file.path, any()),
      ).thenAnswer((_) async => file);

      File? result;
      final widget = MaterialApp(
        home: ImagePickerAvatar.empty(onImagePicked: (image) => result = image),
      );
      await tester.pumpWidget(widget);
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(result, file);
      verify(fileApi.pickImageFromGallery).called(1);
      verify(() => nativeApi.compressImage(file.path, any())).called(1);
    });
  });
}

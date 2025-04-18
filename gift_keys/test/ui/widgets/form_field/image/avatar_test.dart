import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/avatar.dart';

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
        onImagePicked: () {
          return;
        },
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('avatar_selected', find.byWidget(widget));
    }, surfaceSize: size);

    // TODO: Add tests for didUpdateWidget
  });

  group('empty', () {
    testGolden('renders correctly.', (tester) async {
      final widget = ImagePickerAvatar.empty(
        onImagePicked: () {
          return;
        },
      );
      await tester.pumpGoldenWidget(widget);

      await expectGoldenFile('avatar_empty', find.byWidget(widget));
    }, surfaceSize: size);
  });
}

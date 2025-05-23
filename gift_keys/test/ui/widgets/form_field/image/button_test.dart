import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/button.dart';

import '../../../../mocks.dart';
import '../../../../utils.dart';

void main() {
  final fileApi = MockFileApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<FileApi>(fileApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders correctly.', (tester) async {
    final widget = ImagePickerButton(
      onImagePicked: () {
        return;
      },
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('button', find.byWidget(widget));
  }, surfaceSize: const Size(170, 50));
}

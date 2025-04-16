import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/pages/edit_key/page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

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
}

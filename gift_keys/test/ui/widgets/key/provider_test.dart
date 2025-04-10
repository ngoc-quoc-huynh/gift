import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/key/provider.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();

  setUpAll(
    () =>
        Injector.instance
          ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
          ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(Injector.instance.reset);

  testGolden('renders KeyLoadInProgress correctly.', (tester) async {
    when(
      () => localDatabaseApi.loadKey(1),
    ).thenAnswer((_) => Completer<GiftKey>().future);
    const widget = KeyPageProvider(id: 1, child: SizedBox.shrink());
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();

    await expectGoldenFile('provider_loading', widget);
    verify(() => localDatabaseApi.loadKey(1)).called(1);
  }, surfaceSize: pageSurfaceSize);

  testGolden('renders KeyLoadOnFailure correctly.', (tester) async {
    when(
      () => localDatabaseApi.loadKey(1),
    ).thenThrow(const LocalDatabaseException());
    const widget = KeyPageProvider(id: 1, child: SizedBox.shrink());
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();

    await expectGoldenFile('provider_error', widget);
    verify(() => localDatabaseApi.loadKey(1)).called(1);
  }, surfaceSize: pageSurfaceSize);

  testGolden('renders KeyLoadOnSuccess correctly.', (tester) async {
    when(() => localDatabaseApi.loadKey(1)).thenAnswer(
      (_) async => GiftKey(
        id: 1,
        name: 'Name',
        birthday: DateTime.utc(2025),
        aid: 'F000000001',
        password: '1234',
      ),
    );
    const widget = KeyPageProvider(id: 1, child: Text('Success'));
    await tester.pumpGoldenWidget(widget);
    await tester.pumpAndSettle();

    await expectGoldenFile('provider_success', widget);
    verify(() => localDatabaseApi.loadKey(1)).called(1);
  }, surfaceSize: pageSurfaceSize);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/exceptions/base.dart';
import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/utils/mixins/logger.dart';
import 'package:gift_box/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

// ignore_for_file: missing-test-assertion, verify is sufficient.

void main() {
  const testClass = _TestClass();
  final loggerApi = MockLoggerApi();

  setUpAll(() => Injector.instance.registerSingleton<LoggerApi>(loggerApi));

  tearDownAll(() async => Injector.instance.unregister<LoggerApi>());

  group('logInfo', () {
    test('returns correctly.', () {
      when(() => loggerApi.logInfo('message')).thenReturn(null);
      testClass.logInfo('message');

      verify(() => loggerApi.logInfo('message')).called(1);
    });
  });

  group('logWarning', () {
    test('returns correctly.', () {
      when(() => loggerApi.logWarning('message')).thenReturn(null);
      testClass.logWarning('message');

      verify(() => loggerApi.logWarning('message')).called(1);
    });
  });

  group('logException', () {
    test('returns correctly.', () {
      final stackTrace = StackTrace.fromString('');
      when(
        () => loggerApi.logException(
          'message',
          exception: const UnknownException(),
          stackTrace: stackTrace,
        ),
      ).thenReturn(null);
      testClass.logException(
        'message',
        exception: const UnknownException(),
        stackTrace: stackTrace,
      );

      verify(
        () => loggerApi.logException(
          'message',
          exception: const UnknownException(),
          stackTrace: stackTrace,
        ),
      ).called(1);
    });
  });
}

final class _TestClass with LoggerMixin {
  const _TestClass();
}

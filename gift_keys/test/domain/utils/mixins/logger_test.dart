import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/exceptions/base.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:gift_keys/injector.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

// ignore_for_file: missing-test-assertion, verify is sufficient.

void main() {
  const testClass = _TestClass();
  final loggerApi = MockLoggerApi();

  setUpAll(
    () => Injector.instance.registerSingleton<LoggerApi>(loggerApi),
  );

  tearDownAll(
    () async => Injector.instance.unregister<LoggerApi>(),
  );

  group('logInfo', () {
    test('returns correctly.', () {
      final stackTrace = StackTrace.fromString('');
      when(
        () => loggerApi.logInfo(
          'methodName',
          'message',
          stackTrace: stackTrace,
        ),
      ).thenReturn(null);
      testClass.logInfo(
        'methodName',
        'message',
        stackTrace: stackTrace,
      );

      verify(
        () => loggerApi.logInfo(
          'methodName',
          'message',
          stackTrace: stackTrace,
        ),
      ).called(1);
    });
  });

  group('logWarning', () {
    test('returns correctly.', () {
      final stackTrace = StackTrace.fromString('');
      when(
        () => loggerApi.logWarning(
          'methodName',
          'message',
          stackTrace: stackTrace,
        ),
      ).thenReturn(null);
      testClass.logWarning(
        'methodName',
        'message',
        stackTrace: stackTrace,
      );

      verify(
        () => loggerApi.logWarning(
          'methodName',
          'message',
          stackTrace: stackTrace,
        ),
      ).called(1);
    });
  });

  group('logException', () {
    test('returns correctly.', () {
      final stackTrace = StackTrace.fromString('');
      when(
        () => loggerApi.logException(
          'methodName',
          exception: const UnknownException(),
          stackTrace: stackTrace,
        ),
      ).thenReturn(null);
      testClass.logException(
        'methodName',
        exception: const UnknownException(),
        stackTrace: stackTrace,
      );

      verify(
        () => loggerApi.logException(
          'methodName',
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

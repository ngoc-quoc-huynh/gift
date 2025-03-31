import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/exceptions/base.dart';
import 'package:gift_box/infrastructure/repositories/logger.dart';
import 'package:gift_box/injector.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

// ignore_for_file: missing-test-assertion, verify is sufficient.

void main() {
  final logger = MockLogger();
  const repository = LoggerRepository();

  setUpAll(() => Injector.instance.registerSingleton<Logger>(logger));

  tearDownAll(() async => Injector.instance.unregister<Logger>());

  group('logException', () {
    test('returns correctly without parameters.', () {
      repository.logException(
        'methodName',
        exception: const UnknownException(),
        stackTrace: StackTrace.empty,
      );

      verify(
        () => logger.e(
          '''
methodName
{}''',
          error: const UnknownException(),
          stackTrace: StackTrace.empty,
        ),
      );
    });

    test('returns correctly with parameters.', () {
      repository.logException(
        'methodName',
        exception: const UnknownException(),
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.e(
          '''
methodName
{
  "parameters": {
    "id": "id"
  }
}''',
          error: const UnknownException(),
          stackTrace: StackTrace.empty,
        ),
      );
    });
  });

  group('logInfo', () {
    test('returns correctly without parameters.', () {
      repository.logInfo('methodName', 'message', stackTrace: StackTrace.empty);
      verify(
        () => logger.i('''
methodName
{
  "message": "message"
}''', stackTrace: StackTrace.empty),
      );
    });

    test('returns correctly with parameters.', () {
      repository.logInfo(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.i('''
methodName
{
  "parameters": {
    "id": "id"
  },
  "message": "message"
}''', stackTrace: StackTrace.empty),
      );
    });
  });

  group('logWarning', () {
    test('returns correctly without parameters.', () {
      repository.logWarning(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
      );
      verify(
        () => logger.w('''
methodName
{
  "message": "message"
}''', stackTrace: StackTrace.empty),
      );
    });

    test('returns correctly with parameters.', () {
      repository.logWarning(
        'methodName',
        'message',
        stackTrace: StackTrace.empty,
        parameters: {'id': 'id'},
      );

      verify(
        () => logger.w('''
methodName
{
  "parameters": {
    "id": "id"
  },
  "message": "message"
}''', stackTrace: StackTrace.empty),
      );
    });
  });
}

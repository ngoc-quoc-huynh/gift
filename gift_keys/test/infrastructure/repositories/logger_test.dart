import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/exceptions/base.dart';
import 'package:gift_keys/infrastructure/repositories/logger.dart';
import 'package:gift_keys/injector.dart';
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
    test('returns correctly.', () {
      repository.logException(
        'message',
        exception: const UnknownException(),
        stackTrace: StackTrace.empty,
      );

      verify(
        () => logger.e(
          'message',
          error: const UnknownException(),
          stackTrace: StackTrace.empty,
        ),
      );
    });
  });

  group('logInfo', () {
    test('returns correctly.', () {
      repository.logInfo('message');
      verify(() => logger.i('message'));
    });
  });

  group('logWarning', () {
    test('returns correctly parameters.', () {
      repository.logWarning('message');
      verify(() => logger.w('message'));
    });
  });
}

import 'package:flutter/foundation.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:logger/logger.dart';

@immutable
final class LoggerRepository implements LoggerApi {
  const LoggerRepository(this._logger);

  final Logger _logger;

  @override
  void logException(
    String message, {
    required Exception exception,
    StackTrace? stackTrace,
  }) => _logger.e(message, error: exception, stackTrace: stackTrace);

  @override
  void logInfo(String message) => _logger.i(message);

  @override
  void logWarning(String message) => _logger.w(message);
}

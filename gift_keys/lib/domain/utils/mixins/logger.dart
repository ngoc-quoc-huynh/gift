import 'package:gift_keys/injector.dart';

mixin LoggerMixin {
  void logInfo(String message) => _loggerAPI.logInfo(message);

  void logWarning(String message) => _loggerAPI.logWarning(message);

  void logException(
    String message, {
    required Exception exception,
    StackTrace? stackTrace,
  }) => _loggerAPI.logException(
    message,
    exception: exception,
    stackTrace: stackTrace,
  );

  static final _loggerAPI = Injector.instance.loggerApi;
}

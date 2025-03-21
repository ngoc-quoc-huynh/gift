import 'package:gift_keys/injector.dart';

mixin LoggerMixin {
  void logInfo(String message) => _loggerAPI.logInfo(message);

  void logWarning(String message) => _loggerAPI.logWarning(message);

  void logException(
    String methodName, {
    required Exception exception,
    StackTrace? stackTrace,
  }) => _loggerAPI.logException(
    methodName,
    exception: exception,
    stackTrace: stackTrace,
  );

  static final _loggerAPI = Injector.instance.loggerApi;
}

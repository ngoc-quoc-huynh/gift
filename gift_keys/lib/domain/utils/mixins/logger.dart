import 'package:gift_keys/injector.dart';

mixin LoggerMixin {
  void logInfo(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) => _loggerAPI.logInfo(
    methodName,
    message,
    parameters: parameters,
    stackTrace: stackTrace,
  );

  void logWarning(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) => _loggerAPI.logWarning(
    methodName,
    message,
    parameters: parameters,
    stackTrace: stackTrace,
  );

  void logException(
    String methodName, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) => _loggerAPI.logException(
    methodName,
    exception: exception,
    stackTrace: stackTrace,
    parameters: parameters,
  );

  static final _loggerAPI = Injector.instance.loggerApi;
}

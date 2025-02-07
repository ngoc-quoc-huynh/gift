abstract interface class LoggerApi {
  const LoggerApi();

  void logInfo(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  });

  void logWarning(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  });

  void logException(
    String methodName, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  });
}

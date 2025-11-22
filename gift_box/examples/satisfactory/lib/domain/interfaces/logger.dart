abstract interface class LoggerApi {
  const LoggerApi();

  void logException(
    String message, {
    required Exception exception,
    StackTrace? stackTrace,
  });

  void logInfo(String message);

  void logWarning(String message);
}

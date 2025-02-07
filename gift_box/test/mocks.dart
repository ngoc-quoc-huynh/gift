import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gift_box/domain/interfaces/logger.dart';

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

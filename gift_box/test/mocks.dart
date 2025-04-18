import 'package:gift_box/domain/interfaces/logger.dart';
import 'package:gift_box/domain/interfaces/nfc.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNfcApi extends Mock implements NfcApi {}

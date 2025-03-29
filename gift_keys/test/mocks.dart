import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class MockImagePicker extends Mock implements ImagePicker {}

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNfcManager extends Mock implements NfcManager {}

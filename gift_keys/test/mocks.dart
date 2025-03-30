import 'package:file/file.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/interfaces/local_database.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/interfaces/nfc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nfc_manager/nfc_manager.dart';

final class MockDirectory extends Mock implements Directory {}

final class MockFileAPi extends Mock implements FileApi {}

final class MockImagePicker extends Mock implements ImagePicker {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNativeApi extends Mock implements NativeApi {}

final class MockNfcApi extends Mock implements NfcApi {}

final class MockNfcManager extends Mock implements NfcManager {}

final class MockStorage extends Mock implements Storage {}

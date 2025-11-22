import 'package:gift_box_satisfactory/domain/interfaces/logger.dart';
import 'package:gift_box_satisfactory/domain/interfaces/native.dart';
import 'package:gift_box_satisfactory/domain/interfaces/nfc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class MockAudioPlayer extends Mock implements AudioPlayer {}

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNativeApi extends Mock implements NativeApi {}

final class MockNfcApi extends Mock implements NfcApi {}

final class MockStorage extends Mock implements Storage {}

// ignore: avoid_implementing_value_types, for mocking
final class MockPackageInfo extends Mock implements PackageInfo {}

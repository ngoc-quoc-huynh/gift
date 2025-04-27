import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:file/file.dart';
import 'package:gift_keys/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
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
import 'package:package_info_plus/package_info_plus.dart';

final class MockDirectory extends Mock implements Directory {}

final class MockFileApi extends Mock implements FileApi {}

final class MockImagePicker extends Mock implements ImagePicker {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockLogger extends Mock implements Logger {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNativeApi extends Mock implements NativeApi {}

final class MockNfcApi extends Mock implements NfcApi {}

final class MockNfcManager extends Mock implements NfcManager {}

// ignore: avoid_implementing_value_types, for testing purpose.
final class MockPackageInfo extends Mock implements PackageInfo {}

final class MockStorage extends Mock implements Storage {}

final class MockStreamSubscription<T> extends Mock
    implements StreamSubscription<T> {}

final class MockKeyBloc extends MockBloc<KeyEvent, KeyState>
    with TestKeyBlocMixin {}

final class MockKeyFormBloc extends MockBloc<KeyFormEvent, KeyFormState>
    with TestKeyFormBlocMixin {}

final class MockKeyMetasBloc extends MockBloc<KeyMetasEvent, KeyMetasState>
    with TestKeyMetasBlocMixin {}

final class MockNfcDiscoveryBloc
    extends MockBloc<NfcDiscoveryEvent, NfcDiscoveryState>
    with TestNfcDiscoveryBlocMixin {}

final class MockValueCubit<T> extends MockCubit<T> with TestValueCubit<T> {}

final class MockLanguageOptionHydratedValueCubit extends Mock
    with TestLanguageOptionHydratedValueCubitMixin {}

final class MockThemeModeHydratedValueCubit extends Mock
    with TestThemeModeHydratedValueCubitMixin {}

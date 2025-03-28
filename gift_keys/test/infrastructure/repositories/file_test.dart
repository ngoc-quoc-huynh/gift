import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/interfaces/logger.dart';
import 'package:gift_keys/infrastructure/repositories/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart';

import '../../mocks.dart';

void main() {
  final fileSystem = MemoryFileSystem();
  final imagePicker = MockImagePicker();
  final loggerApi = MockLoggerApi();
  final repository = FileRepository(imagePicker);
  final appDir = fileSystem.directory('app');
  final tmpDir = fileSystem.directory('tmp');
  final imagesDir = fileSystem.directory(join(appDir.path, 'images'));

  setUpAll(() {
    Injector.instance
      ..registerSingleton<Directory>(appDir, instanceName: 'appDir')
      ..registerSingleton<Directory>(tmpDir, instanceName: 'tmpDir')
      ..registerSingleton<FileSystem>(fileSystem)
      ..registerSingleton<LoggerApi>(loggerApi);
    registerFallbackValue(PlatformException(code: 'code'));
    registerFallbackValue(StackTrace.empty);
  });

  tearDownAll(Injector.instance.reset);

  group('pickImageFromGallery', () {
    test('returns correctly when file is picked.', () async {
      final file = XFile(join(tmpDir.path, 'test.jpg'));
      when(
        () => imagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((_) async => file);
      final result = await repository.pickImageFromGallery();

      expect(result, isNotNull);
      expect(result!.path, file.path);

      final verifications = verifyInOrder([
        () => imagePicker.pickImage(source: ImageSource.gallery),
        () => loggerApi.logInfo(any()),
      ]);
      for (final verification in verifications) {
        verification.called(1);
      }
    });

    test('returns correctly when no file is picked.', () async {
      when(
        () => imagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((_) async => null);

      final result = await repository.pickImageFromGallery();

      expect(result, isNull);

      final verifications = verifyInOrder([
        () => imagePicker.pickImage(source: ImageSource.gallery),
        () => loggerApi.logInfo(any()),
      ]);
      for (final verification in verifications) {
        verification.called(1);
      }
    });

    test('returns correctly PlatformException is thrown.', () async {
      when(
        () => imagePicker.pickImage(source: ImageSource.gallery),
      ).thenThrow(PlatformException(code: 'code'));

      final result = await repository.pickImageFromGallery();

      expect(result, isNull);

      final verifications = verifyInOrder([
        () => imagePicker.pickImage(source: ImageSource.gallery),
        () => loggerApi.logException(
          any(),
          exception: any(named: 'exception'),
          stackTrace: any(named: 'stackTrace'),
        ),
      ]);
      for (final verification in verifications) {
        verification.called(1);
      }
    });
  });

  group('compressImage', () {
    // TODO: Check how to mock FlutterImageCompress.compressAndGetFile.
  });

  group('moveFileToAppDir', () {
    test('returns correctly when the paths are different.', () async {
      final file = fileSystem.file(join(tmpDir.path, '/test.webp'))
        ..createSync(recursive: true);
      addTearDown(() => appDir.delete(recursive: true));

      final result = await repository.moveFileToAppDir(file.path, 1);

      expect(result.path, join(imagesDir.path, '1.webp'));
      verify(() => loggerApi.logInfo(any())).called(2);
    });

    test('returns correctly when the paths are equal.', () async {
      final file = fileSystem.file(join(imagesDir.path, '1.webp'))
        ..createSync(recursive: true);
      final result = await repository.moveFileToAppDir(file.path, 1);

      expect(result.path, file.path);

      final verifications = verifyInOrder([
        () => loggerApi.logInfo(any()),
        () => loggerApi.logWarning(any()),
      ]);
      for (final verification in verifications) {
        verification.called(1);
      }
    });
  });

  group('loadImage', () {
    test('returns correctly', () {
      expect(repository.loadImage(1).path, join(imagesDir.path, '1.webp'));

      verify(() => loggerApi.logInfo(any())).called(1);
    });
  });

  group('deleteAllImages', () {
    test('returns correctly when directory exists.', () async {
      imagesDir.createSync(recursive: true);
      await expectLater(repository.deleteAllImages(), completes);

      verify(() => loggerApi.logInfo(any())).called(1);
    });

    test('returns correctly when directory does not exist.', () async {
      await expectLater(repository.deleteAllImages(), completes);

      verify(() => loggerApi.logWarning(any())).called(1);
    });
  });

  group('deleteImage', () {
    test('returns correctly when file exists.', () async {
      fileSystem
          .file(join(imagesDir.path, '1.webp'))
          .createSync(recursive: true);
      addTearDown(() => imagesDir.delete(recursive: true));

      await expectLater(repository.deleteImage(1), completes);

      verify(() => loggerApi.logInfo(any())).called(2);
    });

    test('returns correctly when file does not exist.', () async {
      await expectLater(repository.deleteImage(1), completes);

      final verifications = verifyInOrder([
        () => loggerApi.logInfo(any()),
        () => loggerApi.logWarning(any()),
      ]);
      for (final verification in verifications) {
        verification.called(1);
      }
    });
  });

  group('clearCache', () {
    test('returns correctly when tmp directory exists.', () async {
      tmpDir.createSync();
      await expectLater(repository.clearCache(), completes);

      verify(() => loggerApi.logInfo(any())).called(1);
    });

    test('returns correctly when tmp does not directory exist.', () async {
      await expectLater(repository.clearCache(), completes);

      verify(() => loggerApi.logWarning(any())).called(1);
    });
  });
}

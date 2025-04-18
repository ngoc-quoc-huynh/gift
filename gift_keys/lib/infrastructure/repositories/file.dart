import 'package:file/file.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final class FileRepository implements FileApi {
  const FileRepository(this._imagePicker);

  final ImagePicker _imagePicker;

  static final _appDir = Injector.instance.appDir;
  static final _fileSystem = Injector.instance.fileSystem;
  static final _imagesDir = _fileSystem.directory(join(_appDir.path, 'images'));
  static final _tmpDir = Injector.instance.tmpDir;
  static final _loggerApi = Injector.instance.loggerApi;

  @override
  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      final result = switch (pickedFile) {
        null => null,
        XFile(:final path) => _fileSystem.file(path),
      };
      _loggerApi.logInfo('Picked image from gallery: ${result?.path}');

      return result;
    } on PlatformException catch (e, stackTrace) {
      _loggerApi.logException(
        'Could not pick image from gallery.',
        exception: e,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  @override
  Future<void> moveFileToAppDir(String sourcePath, int id) async {
    final file = loadImage(id)..createSync(recursive: true);

    if (file.path != sourcePath) {
      await _fileSystem.file(sourcePath).rename(file.path);
      _loggerApi.logInfo('Moved file to app dir: ${file.path}');
    } else {
      _loggerApi.logWarning(
        'Source path $sourcePath does already exist in app directory, '
        'skipping movement.',
      );
    }
  }

  @override
  File loadImage(int id) {
    final path = join(_imagesDir.path, '$id.webp');
    _loggerApi.logInfo('Loaded image: $path');

    return _fileSystem.file(path);
  }

  @override
  Future<void> deleteAllImages() async {
    if (_imagesDir.existsSync()) {
      await _imagesDir.delete(recursive: true);

      _loggerApi.logInfo('Deleted all images.');
    } else {
      _loggerApi.logWarning('No image directory found, skipping deletion.');
    }
  }

  @override
  Future<void> deleteImage(int id) async {
    final file = loadImage(id);

    if (file.existsSync()) {
      await file.delete();
      _loggerApi.logInfo('Deleting image: ${file.path}');
    } else {
      _loggerApi.logWarning(
        'Image: ${file.path} not found, skipping deletion.',
      );
    }
  }

  @override
  Future<void> clearCache() async {
    widget.imageCache.clear();
    if (_tmpDir.existsSync()) {
      await _tmpDir.delete(recursive: true);
      _loggerApi.logInfo('Clearing cache.');
    } else {
      _loggerApi.logWarning(
        'Temporary directory not found, skipping deletion.',
      );
    }
  }
}

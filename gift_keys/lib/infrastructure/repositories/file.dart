import 'package:file/file.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:gift_keys/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final class FileRepository with LoggerMixin implements FileApi {
  const FileRepository(this._imagePicker);

  final ImagePicker _imagePicker;

  static final _appDir = Injector.instance.appDir;
  static final _fileSystem = Injector.instance.fileSystem;
  static final _imagesDir = _fileSystem.directory(join(_appDir.path, 'images'));
  static final _tmpDir = Injector.instance.tmpDir;
  static final _compressedPath = join(_tmpDir.path, 'compressed.webp');

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
      logInfo('Picked image from gallery: ${result?.path}');

      return result;
    } on PlatformException catch (e, stackTrace) {
      logException(
        'Could not pick image from gallery.',
        exception: e,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  @override
  Future<File?> compressImage(String path, int minWidth) async {
    try {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        path,
        _compressedPath,
        format: CompressFormat.webp,
        minWidth: minWidth,
        quality: 85,
      );
      final result = switch (compressedImage) {
        null => null,
        XFile(:final path) => _fileSystem.file(path),
      };
      logInfo('Compressed image: ${result?.path}');

      return result;
    } on PlatformException catch (e, stackTrace) {
      logException(
        'Could not compress image.',
        exception: e,
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  @override
  Future<File> moveFileToAppDir(String sourcePath, int id) async {
    final file = loadImage(id)..createSync(recursive: true);

    if (file.path != sourcePath) {
      await _fileSystem.file(sourcePath).rename(file.path);
      logInfo('Moved file to app dir: ${file.path}');
    } else {
      logWarning(
        'Source path $sourcePath does already exist in app directory, '
        'skipping movement.',
      );
    }

    return file;
  }

  @override
  File loadImage(int id) {
    final path = join(_imagesDir.path, '$id.webp');
    logInfo('Loaded image: $path');

    return _fileSystem.file(path);
  }

  @override
  Future<void> deleteAllImages() async {
    if (_imagesDir.existsSync()) {
      await _imagesDir.delete(recursive: true);

      logInfo('Deleted all images.');
    } else {
      logWarning('No image directory found, skipping deletion.');
    }
  }

  @override
  Future<void> deleteImage(int id) async {
    final file = loadImage(id);

    if (file.existsSync()) {
      await file.delete();
      logInfo('Deleting image: ${file.path}');
    } else {
      logWarning('Image: ${file.path} not found, skipping deletion.');
    }
  }

  @override
  Future<void> clearCache() async {
    widget.imageCache.clear();
    if (_tmpDir.existsSync()) {
      await _tmpDir.delete(recursive: true);
      logInfo('Clearing cache.');
    } else {
      logWarning('Temporary directory not found, skipping deletion.');
    }
  }
}

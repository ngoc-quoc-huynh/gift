import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final class FileRepository implements FileApi {
  const FileRepository();

  static final _instance = ImagePicker();
  static final _appDir = Injector.instance.appDir;
  static final _fileSystem = Injector.instance.fileSystem;
  static final _imagesDir = _fileSystem.directory(join(_appDir.path, 'images'));
  static final _tmpDir = Injector.instance.tmpDir;
  static final _compressedPath = join(_tmpDir.path, 'compressed.webp');

  @override
  Future<File?> pickImageFromGallery() async {
    final result = await _instance.pickImage(source: ImageSource.gallery);

    return switch (result) {
      null => null,
      XFile(:final path) => _fileSystem.file(path),
    };
  }

  @override
  Future<File?> compressImage(String path, int minWidth) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      _compressedPath,
      format: CompressFormat.webp,
      minWidth: minWidth,
      quality: 85,
    );

    return switch (result) {
      null => null,
      XFile(:final path) => _fileSystem.file(path),
    };
  }

  @override
  Future<File> moveFileToAppDir(String sourcePath, int id) {
    final file = loadImage(id)..createSync(recursive: true);

    return _fileSystem.file(sourcePath).rename(file.path);
  }

  @override
  File loadImage(int id) => _fileSystem.file(join(_imagesDir.path, '$id.webp'));

  @override
  Future<void> precacheImage(BuildContext context, int id) =>
      widget.precacheImage(FileImage(loadImage(id)), context);

  @override
  Future<void> precacheImages(BuildContext context, List<int> ids) =>
      Future.wait(ids.map((id) => precacheImage(context, id)));

  @override
  Future<void> deleteAllImages() async {
    if (_imagesDir.existsSync()) {
      await _imagesDir.delete(recursive: true);
    }
  }

  @override
  Future<void> deleteImage(int id) async {
    final file = loadImage(id);

    if (file.existsSync()) {
      await file.delete();
    }
  }

  @override
  Future<void> clearCache() async {
    widget.imageCache.clear();
    if (_tmpDir.existsSync()) {
      await _tmpDir.delete(recursive: true);
    }
  }
}

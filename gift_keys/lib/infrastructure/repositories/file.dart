import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:gift_keys/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final class FileRepository implements FileApi {
  const FileRepository();

  static final _instance = ImagePicker();
  static final _appDir = Injector.instance.appDir;

  @override
  Future<File?> pickImageFromGallery() async {
    final result = await _instance.pickImage(source: ImageSource.gallery);

    return switch (result) {
      null => null,
      XFile(:final path) => File(path),
    };
  }

  @override
  Future<File?> compressImage(String path, int minWidth) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      _buildCompressedImagePath(path),
      format: CompressFormat.webp,
      minWidth: minWidth,
      quality: 85,
    );

    return switch (result) {
      null => null,
      XFile(:final path) => File(path),
    };
  }

  @override
  Future<File> moveFileToAppDir(String sourcePath, String newName) {
    final file = loadImage(newName)..createSync(recursive: true);
    return File(sourcePath).copy(file.path);
  }

  @override
  File loadImage(String name) => File(join(_appDir.path, 'images', name));

  String _buildCompressedImagePath(String path) =>
      join(dirname(path), '${basenameWithoutExtension(path)}_compressed.webp');
}

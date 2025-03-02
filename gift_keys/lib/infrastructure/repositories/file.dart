import 'dart:io';

import 'package:gift_keys/domain/interfaces/file.dart';
import 'package:image_picker/image_picker.dart';

final class FileRepository implements FileApi {
  const FileRepository();

  static final _instance = ImagePicker();

  @override
  Future<File?> pickImageFromGallery() async {
    final result = await _instance.pickImage(source: ImageSource.gallery);
    return switch (result) {
      null => null,
      XFile(:final path) => File(path),
    };
  }
}

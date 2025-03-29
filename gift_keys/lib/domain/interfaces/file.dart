import 'package:file/file.dart';

abstract interface class FileApi {
  const FileApi();

  Future<File?> pickImageFromGallery();

  Future<File> moveFileToAppDir(String sourcePath, int id);

  File loadImage(int id);

  Future<void> deleteAllImages();

  Future<void> deleteImage(int id);

  Future<void> clearCache();
}

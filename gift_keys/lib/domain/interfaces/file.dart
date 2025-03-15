import 'dart:io';

// ignore: one_member_abstracts, for future extension.
abstract interface class FileApi {
  const FileApi();

  // TODO: Determine if we should XFile
  Future<File?> pickImageFromGallery();

  Future<File?> compressImage(String path, int minWidth);
}

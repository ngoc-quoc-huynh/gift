import 'dart:io';

// ignore: one_member_abstracts, for future extension.
abstract interface class FileApi {
  const FileApi();

  Future<File?> pickImageFromGallery();
}

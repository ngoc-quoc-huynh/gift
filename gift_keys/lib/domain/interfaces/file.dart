import 'dart:io';

import 'package:flutter/cupertino.dart';

// ignore: one_member_abstracts, for future extension.
abstract interface class FileApi {
  const FileApi();

  // TODO: Determine if we should XFile
  Future<File?> pickImageFromGallery();

  Future<File?> compressImage(String path, int minWidth);

  Future<File> moveFileToAppDir(String sourcePath, int id);

  File loadImage(int id);

  Future<void> precacheImage(BuildContext context, int id);

  Future<void> precacheImages(BuildContext context, List<int> ids);

  Future<void> deleteAllImages();

  Future<void> clearCache();
}

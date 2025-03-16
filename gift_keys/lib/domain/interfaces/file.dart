import 'dart:io';

import 'package:flutter/cupertino.dart';

// ignore: one_member_abstracts, for future extension.
abstract interface class FileApi {
  const FileApi();

  // TODO: Determine if we should XFile
  Future<File?> pickImageFromGallery();

  Future<File?> compressImage(String path, int minWidth);

  Future<File> moveFileToAppDir(String sourcePath, String name);

  File loadImage(String name);

  Future<void> precacheImage(BuildContext context, String image);

  Future<void> precacheImages(BuildContext context, List<String> images);

  Future<void> deleteAllImages();

  Future<void> clearCache();
}

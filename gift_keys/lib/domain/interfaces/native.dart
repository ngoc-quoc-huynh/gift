import 'package:file/file.dart';
import 'package:flutter/widgets.dart';

abstract interface class NativeApi {
  const NativeApi();

  Future<void> launchUri(Uri uri);

  Future<void> precacheImage(BuildContext context, File image);
}

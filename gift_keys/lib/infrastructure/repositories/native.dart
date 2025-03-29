import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' as widget;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:gift_keys/injector.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

final class NativeRepository with LoggerMixin implements NativeApi {
  const NativeRepository();

  static final _fileSystem = Injector.instance.fileSystem;
  static final _tmpDir = Injector.instance.tmpDir;
  static final _compressedPath = join(_tmpDir.path, 'compressed.webp');

  @override
  Future<void> launchUri(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    logInfo('Launched $uri');
  }

  @override
  Future<void> precacheImage(BuildContext context, File image) async {
    await widget.precacheImage(FileImage(image), context);

    logInfo('Precached image: ${image.path}');
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
}

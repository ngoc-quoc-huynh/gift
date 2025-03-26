import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';

sealed class ImagePickerAvatar extends StatefulWidget {
  const ImagePickerAvatar({required this.onImagePicked, super.key});

  const factory ImagePickerAvatar.selected({
    required File file,
    required ValueChanged<File> onImagePicked,
    Key? key,
  }) = _Selected;

  const factory ImagePickerAvatar.empty({
    required ValueChanged<File> onImagePicked,
    Key? key,
  }) = _Empty;

  final ValueChanged<File> onImagePicked;

  @protected
  static const radius = 50.0;

  static final _fileApi = Injector.instance.fileApi;

  @protected
  Future<void> onTap(double screenWidth) async {
    final file = await _fileApi.pickImageFromGallery();
    if (file == null) {
      return;
    }

    final compressedFile = await _fileApi.compressImage(
      file.path,
      screenWidth.toInt(),
    );
    if (compressedFile == null) {
      return;
    }

    onImagePicked(compressedFile);
  }
}

class _Selected extends ImagePickerAvatar {
  const _Selected({
    required this.file,
    required super.onImagePicked,
    super.key,
  });

  final File file;

  @override
  State<StatefulWidget> createState() => _SelectedState();
}

class _SelectedState extends State<_Selected> {
  late ImageProvider _imageProvider;
  late DateTime _lastModified;

  @override
  void initState() {
    super.initState();
    _lastModified = widget.file.lastModifiedSync();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageProvider = ResizeImage(
      FileImage(widget.file),
      width: _computeImageWidth(context),
    );
  }

  @override
  void didUpdateWidget(covariant _Selected oldWidget) {
    super.didUpdateWidget(oldWidget);
    final file = widget.file;
    if (file.existsSync()) {
      final newLastModified = file.lastModifiedSync();

      if (_lastModified != newLastModified) {
        unawaited(_imageProvider.evict());
        _imageProvider = ResizeImage(
          FileImage(file),
          width: _computeImageWidth(context),
        );
        _lastModified = newLastModified;
      }
    }
  }

  @override
  void dispose() {
    unawaited(_imageProvider.evict());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ImagePickerAvatar.radius,
      backgroundImage: _imageProvider,
      child: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => unawaited(widget.onTap(context.screenSize.width)),
        ),
      ),
    );
  }

  int _computeImageWidth(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return (ImagePickerAvatar.radius * 2 * devicePixelRatio).toInt();
  }
}

class _Empty extends ImagePickerAvatar {
  const _Empty({required super.onImagePicked, super.key});

  @override
  State<StatefulWidget> createState() => _EmptyState();
}

class _EmptyState extends State<_Empty> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: ImagePickerAvatar.radius,
          backgroundColor: context.colorScheme.primaryContainer,
          child: const Icon(Icons.image, size: 40),
        ),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: SizedBox(
            width: ImagePickerAvatar.radius * 2,
            height: ImagePickerAvatar.radius * 2,
            child: InkWell(
              onTap: () => unawaited(widget.onTap(context.screenSize.width)),
            ),
          ),
        ),
      ],
    );
  }
}

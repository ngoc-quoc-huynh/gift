import 'dart:async';

import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';

sealed class ImagePickerAvatar extends StatefulWidget {
  const ImagePickerAvatar({required this.onImagePicked, super.key});

  const factory ImagePickerAvatar.selected({
    required File file,
    required VoidCallback onImagePicked,
    Key? key,
  }) = _Selected;

  const factory ImagePickerAvatar.empty({
    required VoidCallback onImagePicked,
    Key? key,
  }) = _Empty;

  final VoidCallback onImagePicked;

  @protected
  static const radius = 50.0;
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
        child: InkWell(onTap: widget.onImagePicked),
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
            child: InkWell(onTap: widget.onImagePicked),
          ),
        ),
      ],
    );
  }
}

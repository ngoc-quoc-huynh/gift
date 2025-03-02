import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';

sealed class ImagePickerAvatar extends StatelessWidget {
  const ImagePickerAvatar({
    required this.onImagePicked,
    super.key,
  });
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
  static const _radius = 50.0;

  @protected
  Future<void> onTap() async {
    final file = await Injector.instance.fileApi.pickImageFromGallery();
    if (file != null) {
      onImagePicked.call(file);
    }
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
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: ImagePickerAvatar._radius,
      backgroundImage: FileImage(file),
      child: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}

class _Empty extends ImagePickerAvatar {
  const _Empty({
    required super.onImagePicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: ImagePickerAvatar._radius,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: const Icon(
            Icons.image,
            size: 40,
          ),
        ),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: SizedBox(
            width: ImagePickerAvatar._radius * 2,
            height: ImagePickerAvatar._radius * 2,
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}

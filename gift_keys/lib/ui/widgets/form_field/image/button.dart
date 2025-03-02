import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({
    required this.onImagePicked,
    super.key,
  });

  final ValueChanged<File> onImagePicked;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: Text(Injector.instance.translations.imagePickerFormField.add),
    );
  }

  Future<void> _onPressed() async {
    final file = await Injector.instance.fileApi.pickImageFromGallery();
    if (file != null) {
      onImagePicked.call(file);
    }
  }
}

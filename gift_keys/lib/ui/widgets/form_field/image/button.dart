import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({required this.onImagePicked, super.key});

  final VoidCallback onImagePicked;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onImagePicked,
      child: Text(Injector.instance.translations.widgets.form.image.add),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/avatar.dart';
import 'package:gift_keys/ui/widgets/form_field/image/button.dart';

class ImagePickerFormField extends FormField<File> {
  ImagePickerFormField({ValueChanged<File>? onPicked, super.key})
    : super(
        validator: _validator,
        builder: (field) {
          void onImagePicked(File image) {
            field.didChange(image);
            onPicked?.call(image);
          }

          return Column(
            children: [
              switch (field.value) {
                null => ImagePickerAvatar.empty(onImagePicked: onImagePicked),
                final file => ImagePickerAvatar.selected(
                  file: file,
                  onImagePicked: onImagePicked,
                ),
              },
              switch (field.errorText) {
                null => const SizedBox.shrink(),
                final errorText => Text(
                  errorText,
                  style: TextStyle(
                    color: Theme.of(field.context).colorScheme.error,
                  ),
                ),
              },
              ImagePickerButton(onImagePicked: onImagePicked),
            ],
          );
        },
      );

  static String? _validator(File? value) => switch (value) {
    null => Injector.instance.translations.imagePickerFormField.empty,
    File() => null,
  };
}

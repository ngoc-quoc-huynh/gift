import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/image/avatar.dart';
import 'package:gift_keys/ui/widgets/form_field/image/button.dart';

class ImagePickerFormField extends FormField<File> {
  const ImagePickerFormField({super.key})
    : super(validator: _validator, builder: _Body.new);

  static String? _validator(File? value) => switch (value) {
    null => Injector.instance.translations.widgets.form.image.validation,
    File() => null,
  };
}

class _Body extends StatefulWidget {
  const _Body(this.field);

  final FormFieldState<File?> field;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.field.didChange(context.read<FileValueCubit>().state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FileValueCubit, File?>(
          builder:
              (context, state) => switch (state) {
                null => ImagePickerAvatar.empty(onImagePicked: onImagePicked),
                final file => ImagePickerAvatar.selected(
                  file: file,
                  onImagePicked: onImagePicked,
                ),
              },
        ),
        switch (widget.field.errorText) {
          null => const SizedBox.shrink(),
          final errorText => Text(
            errorText,
            style: TextStyle(
              color: Theme.of(widget.field.context).colorScheme.error,
            ),
          ),
        },
        ImagePickerButton(onImagePicked: onImagePicked),
      ],
    );
  }

  void onImagePicked(File image) {
    widget.field.didChange(image);
    context.read<FileValueCubit>().update(image);
  }
}

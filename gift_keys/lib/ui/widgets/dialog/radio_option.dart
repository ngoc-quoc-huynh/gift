import 'package:flutter/material.dart';
import 'package:gift_keys/static/resources/sizes.dart';

class RadioDialogOption<T> extends StatelessWidget {
  const RadioDialogOption({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final T value;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
      ),
      title: Text(title),
      value: value,
    );
  }
}

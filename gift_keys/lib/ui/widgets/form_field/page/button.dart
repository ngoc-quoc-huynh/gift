import 'package:flutter/material.dart';

sealed class FormFieldSubmitButton extends StatelessWidget {
  const FormFieldSubmitButton({super.key});

  const factory FormFieldSubmitButton.loading() = _Loading;

  const factory FormFieldSubmitButton.normal({
    required String buttonTitle,
    required VoidCallback onPressed,
  }) = _Normal;
}

final class _Loading extends FormFieldSubmitButton {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const FilledButton(
      onPressed: null,
      child: CircularProgressIndicator(),
    );
  }
}

final class _Normal extends FormFieldSubmitButton {
  const _Normal({required this.buttonTitle, required this.onPressed});

  final String buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(buttonTitle));
  }
}

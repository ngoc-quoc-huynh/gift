import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.icon,
    required this.label,
    required this.textInputAction,
    required this.validator,
    this.autofillHints,
    this.controller,
    this.keyboardType,
    this.onSubmitted,
    super.key,
  });

  final IconData icon;
  final String label;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final TextInputType? keyboardType;
  final FormFieldValidator<String> validator;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: (_) => onSubmitted?.call(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}

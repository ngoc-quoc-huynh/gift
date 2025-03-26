import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Injector.instance.translations.general.error,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}

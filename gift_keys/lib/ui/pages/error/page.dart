import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/error_text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_translations.appBar)),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: ErrorText(text: _translations.content(url: url)),
      ),
    );
  }

  static TranslationsPagesErrorEn get _translations =>
      Injector.instance.translations.pages.error;
}

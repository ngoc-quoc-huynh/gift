import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/widgets/error_text.dart';
import 'package:gift_box/ui/widgets/responsive_box.dart';

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
        child: ResponsiveBox(
          child: ErrorText(text: _translations.content(url: url)),
        ),
      ),
    );
  }

  static TranslationsPagesErrorEn get _translations =>
      Injector.instance.translations.pages.error;
}

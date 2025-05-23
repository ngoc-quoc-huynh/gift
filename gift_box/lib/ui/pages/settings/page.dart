import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_translations.appBar)),
    );
  }

  TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

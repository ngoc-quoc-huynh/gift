import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
      // TODO: Add app icon
      // TODO: Add copyright
    );
  }

  static Translations get _translations => Injector.instance.translations;
}

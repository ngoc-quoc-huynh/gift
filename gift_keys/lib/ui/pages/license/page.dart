import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/assets.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
      applicationIcon: Image.asset(Assets.launcherIcon(), height: 75),
      applicationLegalese: _translations.pages.license.copyright,
    );
  }

  static Translations get _translations => Injector.instance.translations;
}

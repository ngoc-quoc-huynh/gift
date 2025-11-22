import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/domain/models/asset.dart';
import 'package:gift_box_satisfactory/injector.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
      applicationLegalese: _translations.pages.settings.license.legalese,
      applicationIcon: Image.asset(
        Asset.launcherIcon(),
        width: 75,
        height: 75,
      ),
    );
  }

  Translations get _translations => Injector.instance.translations;
}

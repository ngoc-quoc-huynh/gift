import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: Injector.instance.translations.appName,
      applicationVersion: Injector.instance.packageInfo.version,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: Sizes.verticalPadding),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(Injector.instance.packageInfo.version),
        ),
      ),
    );
  }
}

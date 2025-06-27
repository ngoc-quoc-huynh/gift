import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(Injector.instance.packageInfo.version),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/injector.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 20),
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

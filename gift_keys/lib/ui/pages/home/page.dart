import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Injector.instance.translations.appName),
      ),
    );
  }
}

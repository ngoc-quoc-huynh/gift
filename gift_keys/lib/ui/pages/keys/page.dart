import 'package:flutter/material.dart';
import 'package:gift_keys/ui/pages/keys/add_button.dart';

class KeysPage extends StatelessWidget {
  const KeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CarouselView(
        itemExtent: double.infinity,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(),
        enableSplash: false,
        itemSnapping: true,
        children: [
          KeyAddButton(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_box/ui/pages/gift/box.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GiftBox(),
      ),
    );
  }
}

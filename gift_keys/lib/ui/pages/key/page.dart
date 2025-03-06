import 'package:flutter/material.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gift')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(alignment: Alignment.topRight, child: KeyNfcStatus()),
          ],
        ),
      ),
    );
  }
}

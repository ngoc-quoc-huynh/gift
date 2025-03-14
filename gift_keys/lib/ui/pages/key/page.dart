import 'package:flutter/material.dart';
import 'package:gift_keys/ui/pages/key/key.dart';
import 'package:gift_keys/ui/pages/key/nfc_status.dart';

class KeyPage extends StatelessWidget {
  const KeyPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Key')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Align(alignment: Alignment.topRight, child: KeyNfcStatus()),
            const Spacer(),
            const RiveKey(),
            const SizedBox(height: 20),
            Text(
              'Quoc',
              style: textTheme.displayLarge?.copyWith(color: primaryColor),
            ),
            Text(
              '04.03.2025',
              style: textTheme.displaySmall?.copyWith(color: primaryColor),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

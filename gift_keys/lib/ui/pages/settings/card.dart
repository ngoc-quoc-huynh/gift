import 'package:flutter/material.dart';
import 'package:gift_keys/static/resources/sizes.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Sizes.maxWidgetWith),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            children: List<Widget>.generate(
              children.length * 2 - 1,
              (index) => switch (index.isEven) {
                true => children[index ~/ 2],
                false => const Divider(indent: 10, endIndent: 10),
              },
            ),
          ),
        ),
      ),
    );
  }
}

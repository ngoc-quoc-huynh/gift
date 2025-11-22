import 'package:flutter/material.dart';

class ResponsiveBox extends StatelessWidget {
  const ResponsiveBox({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: child,
    );
  }
}

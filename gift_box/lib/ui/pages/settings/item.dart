import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.enabled = true,
    this.subtitle,
    this.onPressed,
    this.trailing,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final bool enabled;
  final String? subtitle;
  final VoidCallback? onPressed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final (onPressed, iconAlpha) = switch (enabled) {
      false => (null, 0.3),
      true => (this.onPressed, 1.0),
    };

    return ListTile(
      leading: SizedBox.square(
        dimension: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(
            icon,
            color: iconColor.withValues(alpha: iconAlpha),
          ),
        ),
      ),
      title: Text(title),
      subtitle: switch (subtitle) {
        null => null,
        final subtitle => Text(subtitle),
      },
      trailing: trailing ?? const Icon(Icons.chevron_right),
      enabled: enabled,
      onTap: onPressed,
    );
  }
}

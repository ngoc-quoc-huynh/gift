import 'package:flutter/material.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/alert_dialog/action.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
    super.key,
  });

  final String title;
  final Widget content;
  final List<AlertDialogAction> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: _contentPadding,
      titlePadding: _titlePadding,
      title: Text(title),
      content: content,
      actions: actions,
    );
  }

  static const _titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
  );

  static const _contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
}

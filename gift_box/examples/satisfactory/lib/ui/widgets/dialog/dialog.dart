import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/static/resources/sizes.dart';
import 'package:gift_box_satisfactory/ui/widgets/dialog/action.dart';

sealed class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  const factory CustomDialog.alert({
    required String title,
    required Widget content,
    required List<AlertDialogAction> actions,
    Key? key,
  }) = _Alert;

  const factory CustomDialog.normal({
    required String title,
    required Widget content,
    required Widget action,
    Key? key,
  }) = _Normal;
}

class _Alert extends CustomDialog {
  const _Alert({
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
      title: Text(title),
      titlePadding: _titlePadding,
      content: content,
      contentPadding: _contentPadding,
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

class _Normal extends CustomDialog {
  const _Normal({
    required this.title,
    required this.content,
    required this.action,
    super.key,
  });

  final String title;
  final Widget content;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title),
          ),
          const CloseButton(),
        ],
      ),
      content: content,
      actionsAlignment: MainAxisAlignment.center,
      actions: [action],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';
import 'package:gift_keys/ui/widgets/dialog/radio_option.dart';
import 'package:gift_keys/ui/widgets/responsive_box.dart';

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

  static CustomDialog radio<T extends Object>({
    required String title,
    required List<RadioDialogOption<T>> options,
    Key? key,
  }) => _Radio<T>(title: title, options: options, key: key);

  @protected
  static const titlePadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    left: Sizes.horizontalPadding,
    right: Sizes.horizontalPadding,
  );

  @protected
  static const contentPadding = EdgeInsets.only(
    top: Sizes.verticalPadding,
    bottom: Sizes.verticalPadding / 2,
  );
}

final class _Alert extends CustomDialog {
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
      contentPadding: CustomDialog.contentPadding,
      titlePadding: CustomDialog.titlePadding,
      title: Text(title),
      content: ResponsiveBox(child: content),
      actions: actions,
    );
  }
}

final class _Normal extends CustomDialog {
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
      contentPadding: CustomDialog.contentPadding,
      titlePadding: CustomDialog.titlePadding,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), const CloseButton()],
      ),
      content: ResponsiveBox(child: content),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: context.dialogTheme.actionsPadding?.add(
        const EdgeInsets.only(bottom: Sizes.verticalPadding / 2),
      ),
      actions: [action],
    );
  }
}

final class _Radio<T extends Object> extends CustomDialog {
  const _Radio({required this.title, required this.options, super.key});

  final String title;
  final List<RadioDialogOption<T>> options;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: CustomDialog.contentPadding,
      titlePadding: CustomDialog.titlePadding,
      title: Text(title),
      content: ResponsiveBox(
        child: Column(mainAxisSize: MainAxisSize.min, children: options),
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(
          result: () => context.read<ValueCubit<T>>().state,
        ),
      ],
    );
  }
}

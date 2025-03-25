import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/domain/utils/extensions/theme_data.dart';

final class CustomSnackBar extends SnackBar {
  const CustomSnackBar({
    required super.content,
    required super.backgroundColor,
    super.key,
  }) : super(behavior: SnackBarBehavior.floating);

  static void showSuccess(BuildContext context, String text) => _show(
    context: context,
    text: text,
    color: context.theme.customColors.success,
  );

  static void showInfo(BuildContext context, String text) =>
      _show(context: context, text: text, color: context.colorScheme.primary);

  static void showError(BuildContext context, String text) =>
      _show(context: context, text: text, color: context.colorScheme.error);

  static void _show({
    required BuildContext context,
    required Color color,
    required String text,
  }) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          CustomSnackBar(content: Text(text), backgroundColor: color),
        );
}

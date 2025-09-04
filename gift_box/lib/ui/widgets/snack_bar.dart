import 'package:flutter/material.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/static/resources/sizes.dart';

final class CustomSnackBar extends SnackBar {
  const CustomSnackBar({
    required super.content,
    required super.backgroundColor,
    required super.width,
    super.key,
  }) : super(behavior: SnackBarBehavior.floating);

  static void showInfo(BuildContext context, String text) => _show(
    context: context,
    text: text,
    color: context.colorScheme.primary,
  );

  static void _show({
    required BuildContext context,
    required Color color,
    required String text,
  }) => ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      CustomSnackBar(
        content: Text(text),
        backgroundColor: color,
        width: switch (context.screenSize.width >=
            Sizes.maxWidgetWidthConstraint) {
          false => null,
          true => Sizes.maxWidgetWidthConstraint,
        },
      ),
    );
}

import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';
import 'package:go_router/go_router.dart';

sealed class AlertDialogAction extends StatelessWidget {
  const AlertDialogAction({
    super.key,
  });

  const factory AlertDialogAction.cancel({
    Key? key,
  }) = _Cancel;

  const factory AlertDialogAction.confirm({
    required Object Function() result,
    Key? key,
  }) = _Confirm;

  @protected
  TranslationsGeneralEn get translations =>
      Injector.instance.translations.general;
}

final class _Cancel extends AlertDialogAction {
  const _Cancel({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(),
      child: Text(translations.cancel),
    );
  }
}

final class _Confirm extends AlertDialogAction {
  const _Confirm({
    required this.result,
    super.key,
  });

  final Object Function() result;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(result.call()),
      child: Text(translations.confirm),
    );
  }
}

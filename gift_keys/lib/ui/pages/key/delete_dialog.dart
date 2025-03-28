import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';

class KeyDeleteDialog extends StatelessWidget {
  const KeyDeleteDialog({super.key});

  static Future<void> show(BuildContext context, int id) async {
    final reset = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const KeyDeleteDialog(),
    );

    if (context.mounted && (reset ?? false)) {
      context.read<KeyFormBloc>().add(KeyFormDeleteEvent(id: id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog.alert(
      title: _translations.title,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: Text(_translations.content),
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(result: () => true),
      ],
    );
  }

  static TranslationsPagesKeyDeleteDialogEn get _translations =>
      Injector.instance.translations.pages.key.deleteDialog;
}

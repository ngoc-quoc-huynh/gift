import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';

class SettingsResetDialog extends StatelessWidget {
  const SettingsResetDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final reset = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsResetDialog(),
    );

    if (context.mounted && (reset ?? false)) {
      context.read<KeyMetasBloc>().add(const KeyMetasResetEvent());
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

  static TranslationsPagesSettingsDialogsResetEn get _translations =>
      Injector.instance.translations.pages.settings.dialogs.reset;
}

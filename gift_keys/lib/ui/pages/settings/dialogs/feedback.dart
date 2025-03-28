import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/config.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:go_router/go_router.dart';

class SettingsFeedbackDialog extends StatelessWidget {
  const SettingsFeedbackDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final giveFeedback = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsFeedbackDialog(),
    );

    if (giveFeedback ?? false) {
      await Injector.instance.nativeApi.launchUri(Config.githubIssueUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog.normal(
      title: _translations.title,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: Text(_translations.content),
      ),
      action: FilledButton(
        onPressed: () => context.pop(true),
        child: Text(_translations.button),
      ),
    );
  }

  static TranslationsPagesSettingsDialogsFeedbackEn get _translations =>
      Injector.instance.translations.pages.settings.dialogs.feedback;
}

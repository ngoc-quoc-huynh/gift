import 'package:flutter/material.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/dialog/dialog.dart';

class SettingsFeedbackDialog extends StatelessWidget {
  const SettingsFeedbackDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    useRootNavigator: false,
    builder: (_) => const SettingsFeedbackDialog._(),
  );

  static final _feedbackUrl = Uri.https(
    'github.com',
    '/ngoc-quoc-huynh/gift/discussions',
  );

  @override
  Widget build(BuildContext context) {
    return CustomDialog.normal(
      title: _translations.title,
      content: Text(_translations.description),
      action: FilledButton(
        child: Text(_translations.button),
        onPressed: () => Injector.instance.nativeApi.openUrl(_feedbackUrl),
      ),
    );
  }

  static TranslationsPagesSettingsFeedbackEn get _translations =>
      Injector.instance.translations.pages.settings.feedback;
}

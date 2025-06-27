import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/ui/widgets/dialog/dialog.dart';

class SettingsFeedbackDialog extends StatelessWidget {
  const SettingsFeedbackDialog._();

  static Future<void> show(BuildContext context) async {
    final cubit = context.read<HydratedTranslationLocaleCubit>();
    final locale = await showDialog<TranslationLocale>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsFeedbackDialog._(),
    );

    if (context.mounted && locale != null) {
      cubit.update(locale);
    }
  }

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

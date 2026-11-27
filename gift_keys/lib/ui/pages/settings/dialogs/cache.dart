import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/dialog/alert_action.dart';
import 'package:gift_keys/ui/widgets/dialog/dialog.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';
import 'package:material_ui/material_ui.dart';

class SettingsCacheDialog extends StatelessWidget {
  const SettingsCacheDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final delete = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const SettingsCacheDialog(),
    );

    if (context.mounted && (delete ?? false)) {
      await Injector.instance.fileApi.clearCache();
      if (context.mounted) {
        CustomSnackBar.showSuccess(
          context,
          _translations.pages.settings.cacheUpdate,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog.alert(
      title: _dialogTranslations.title,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: Text(_dialogTranslations.content),
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(result: () => true),
      ],
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static Translations$pages$settings$dialogs$cache$en get _dialogTranslations =>
      _translations.pages.settings.dialogs.cache;
}

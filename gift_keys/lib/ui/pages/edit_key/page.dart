import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page.dart';

class EditKeyPage extends StatelessWidget {
  const EditKeyPage({required this.giftKey, super.key});

  final GiftKey giftKey;

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      onPopInvokedWithResult: (_, result) => _onPopInvoked(context, result),
      child: FormFieldPage(
        title: _translations.appBar,
        buttonTitle: _translations.update,
        giftKey: giftKey,
        onSubmitted:
            (imagePath, name, birthday, aid, password) =>
                context.read<KeyMetasBloc>().add(
                  KeyMetasUpdateEvent(
                    id: giftKey.id,
                    imagePath: imagePath,
                    name: name,
                    birthday: birthday,
                    aid: aid,
                    password: password,
                  ),
                ),
      ),
    );
  }

  void _onPopInvoked(BuildContext context, bool? result) {
    if (result != true) {
      context.read<NfcDiscoveryBloc>().add(const NfcDiscoveryResumeEvent());
    }
  }

  static TranslationsPagesEditKeyEn get _translations =>
      Injector.instance.translations.pages.editKey;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key/bloc.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/blocs/key_metas/bloc.dart';
import 'package:gift_keys/domain/blocs/nfc_discovery/bloc.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page/page.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class EditKeyPage extends StatelessWidget {
  const EditKeyPage({required this.giftKey, super.key});

  final GiftKey giftKey;

  @override
  Widget build(BuildContext context) {
    return PopScope<bool>(
      onPopInvokedWithResult: (_, result) => _onPopInvoked(context, result),
      child: BlocProvider<KeyFormBloc>(
        create: (_) => KeyFormBloc(),
        child: BlocListener<KeyFormBloc, KeyFormState>(
          listener: _onKeyFormStateChanged,
          child: Builder(
            builder:
                (context) => FormFieldPage(
                  title: _editKeyTranslations.appBar,
                  buttonTitle: _editKeyTranslations.update,
                  giftKey: giftKey,
                  onSubmitted:
                      (imagePath, name, birthday, aid, password) =>
                          context.read<KeyFormBloc>().add(
                            KeyFormUpdateEvent(
                              id: giftKey.id,
                              imagePath: imagePath,
                              name: name,
                              birthday: birthday,
                              aid: aid,
                              password: password,
                            ),
                          ),
                ),
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

  void _onKeyFormStateChanged(BuildContext context, KeyFormState state) =>
      switch (state) {
        KeyFormLoadOnSuccess(:final meta) =>
          context
            ..read<KeyMetasBloc>().add(KeyMetasUpdateEvent(meta))
            ..read<KeyBloc>().add(const KeyInitializeEvent())
            ..pop(),
        KeyFormLoadOnFailure() => CustomSnackBar.showError(
          context,
          _translations.general.error,
        ),
        _ => null,
      };

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesEditKeyEn get _editKeyTranslations =>
      _translations.pages.editKey;
}

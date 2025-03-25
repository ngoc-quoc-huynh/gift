import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page/page.dart';
import 'package:gift_keys/ui/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class AddKeyPage extends StatelessWidget {
  const AddKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KeyFormBloc>(
      create: (_) => KeyFormBloc(),
      child: BlocListener<KeyFormBloc, KeyFormState>(
        listener: _onKeyFormStateChanged,
        child: Builder(
          builder:
              (context) => FormFieldPage(
                title: _translations.appBar,
                buttonTitle: _translations.create,
                onSubmitted:
                    (imagePath, name, birthday, aid, password) =>
                        context.read<KeyFormBloc>().add(
                          KeyFormAddEvent(
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
    );
  }

  void _onKeyFormStateChanged(BuildContext context, KeyFormState state) =>
      switch (state) {
        KeyFormLoadOnSuccess(:final meta) =>
          context
            ..read<KeyMetasBloc>().add(KeyMetasAddEvent(meta))
            ..pop(),
        KeyFormLoadOnFailure() => CustomSnackBar.showError(
          context,
          Injector.instance.translations.general.error,
        ),
        _ => null,
      };

  static TranslationsPagesAddKeyEn get _translations =>
      Injector.instance.translations.pages.addKey;
}

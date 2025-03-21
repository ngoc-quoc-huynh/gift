import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page.dart';

class AddKeyPage extends StatelessWidget {
  const AddKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormFieldPage(
      title: Injector.instance.translations.pages.addKey.appBar,
      onSubmitted:
          (imagePath, name, birthday, aid, password) =>
              context.read<KeyMetasBloc>().add(
                KeyMetasAddEvent(
                  imagePath: imagePath,
                  name: name,
                  birthday: birthday,
                  aid: aid,
                  password: password,
                ),
              ),
    );
  }
}

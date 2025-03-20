import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/keys_meta/bloc.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:gift_keys/ui/widgets/form_field/image/form_field.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';
import 'package:go_router/go_router.dart';

class AddKeyPage extends StatelessWidget {
  const AddKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Injector.instance.translations.pages.addKey.appBar),
      ),
      body: const AutofillGroup(child: Form(child: _Body())),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _aidController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  late File _image;
  late DateTime _birthday;

  @override
  void dispose() {
    _aidController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
        vertical: Sizes.verticalPadding,
      ),
      children: [
        ImagePickerFormField(onPicked: (file) => _image = file),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: _nameController,
          icon: Icons.person,
          label: _translations.name.hint,
          autofillHints: const [AutofillHints.name],
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          validator: _nameValidator,
        ),
        const SizedBox(height: 10),
        DateFormField(
          onDateSelected: (date) => _birthday = date,
          labelText: _translations.birthday.hint,
          validator: _birthdayValidator,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: _aidController,
          label: _translations.aid.hint,
          icon: Icons.badge,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          validator: _aidValidator,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: _passwordController,
          label: _translations.password.hint,
          icon: Icons.lock,
          autofillHints: const [AutofillHints.newPassword],
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          validator: _passwordValidator,
          onSubmitted: () => _onCreatePressed(context),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => _onCreatePressed(context),
          child: const Text('Create'),
        ),
      ],
    );
  }

  String? _aidValidator(String? val) => switch (val) {
    null => _translations.aid.validation.empty,
    final val when val.isEmpty => _translations.aid.validation.empty,
    String() when !RegExp(r'^[0-9A-Fa-f]+$').hasMatch(val) =>
      _translations.aid.validation.hex,
    String() when val.length < 10 || val.length > 32 =>
      _translations.aid.validation.length,
    String() => null,
  };

  String? _birthdayValidator(DateTime? val) => switch (val) {
    null => _translations.birthday.validation,
    DateTime() => null,
  };

  String? _nameValidator(String? val) =>
      _emptyValidator(val, _translations.name.validation);

  String? _passwordValidator(String? val) => switch (val) {
    null => _translations.password.validation.empty,
    final val when val.isEmpty => _translations.password.validation.empty,

    String() when val.length < 4 => _translations.password.validation.length,
    String() => null,
  };

  String? _emptyValidator(String? val, String message) => switch (val) {
    null => message,
    final val when val.isEmpty => message,
    String() => null,
  };

  void _onCreatePressed(BuildContext context) {
    if (Form.of(context).validate()) {
      context
        ..read<KeyMetasBloc>().add(
          KeyMetasAddEvent(
            imagePath: _image.path,
            name: _nameController.text,
            birthday: _birthday,
            aid: _aidController.text,
            password: _passwordController.text,
          ),
        )
        ..pop();
    }
  }

  static TranslationsPagesAddKeyEn get _translations =>
      Injector.instance.translations.pages.addKey;
}

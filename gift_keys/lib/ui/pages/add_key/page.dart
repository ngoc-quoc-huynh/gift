import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:gift_keys/ui/widgets/form_field/image/form_field.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';

class AddKeyPage extends StatelessWidget {
  const AddKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Injector.instance.translations.pages.addKey.appBar),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: AutofillGroup(
          child: Form(
            child: _Body(),
          ),
        ),
      ),
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
  final _birthdayController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  late File _file;

  @override
  void dispose() {
    super.dispose();
    _aidController.dispose();
    _birthdayController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ImagePickerFormField(
          onPicked: (file) => _file = file,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: _nameController,
          icon: Icons.person,
          label: _translations.name.hint,
          autofillHints: const [AutofillHints.name],
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          validator: _nameValidator,
        ),
        const SizedBox(height: 10),
        DateFormField(
          controller: _birthdayController,
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

  String? _aidValidator(String? val) =>
      _emptyValidator(val, _translations.aid.validation);

  String? _birthdayValidator(DateTime? val) => switch (val) {
        null => _translations.birthday.validation,
        DateTime() => null,
      };

  String? _nameValidator(String? val) =>
      _emptyValidator(val, _translations.name.validation);

  String? _passwordValidator(String? val) =>
      _emptyValidator(val, _translations.password.validation);

  String? _emptyValidator(String? val, String message) => switch (val) {
        null => message,
        final val when val.isEmpty => message,
        String() => null,
      };

  void _onCreatePressed(BuildContext context) {
    if (Form.of(context).validate()) {
      // TODO: Add logic
      _file.path;
    }
  }

  static TranslationsPagesAddKeyEn get _translations =>
      Injector.instance.translations.pages.addKey;
}

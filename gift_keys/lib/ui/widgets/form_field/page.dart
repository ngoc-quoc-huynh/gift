import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:gift_keys/ui/widgets/form_field/image/form_field.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';
import 'package:go_router/go_router.dart';

typedef FormFieldSubmitCallback =
    void Function(
      String imagePath,
      String name,
      DateTime birthday,
      String aid,
      String password,
    );

class FormFieldPage extends StatelessWidget {
  const FormFieldPage({
    required this.title,
    required this.buttonTitle,
    required this.onSubmitted,
    this.giftKey,
    super.key,
  });

  final String title;
  final String buttonTitle;
  final GiftKey? giftKey;
  final FormFieldSubmitCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AutofillGroup(
        child: Form(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<DateTimeValueCubit>(
                create: (_) => DateTimeValueCubit(giftKey?.birthday),
              ),
              BlocProvider<FileValueCubit>(
                create: (_) => FileValueCubit(_loadInitialImage()),
              ),
            ],
            child: _Body(
              buttonTitle: buttonTitle,

              giftKey: giftKey,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ),
    );
  }

  File? _loadInitialImage() => switch (giftKey?.id) {
    null => null,
    final id => Injector.instance.fileApi.loadImage(id),
  };
}

class _Body extends StatefulWidget {
  const _Body({
    required this.buttonTitle,

    required this.giftKey,
    required this.onSubmitted,
  });

  final String buttonTitle;
  final GiftKey? giftKey;
  final FormFieldSubmitCallback onSubmitted;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController _aidController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _aidController = TextEditingController(text: _giftKey?.aid);
    _nameController = TextEditingController(text: _giftKey?.name);
    _passwordController = TextEditingController(text: _giftKey?.password);
  }

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
        const ImagePickerFormField(),
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
          onSubmitted: () => _onSubmitted(context),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => _onSubmitted(context),
          child: Text(widget.buttonTitle),
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

  void _onSubmitted(BuildContext context) {
    if (Form.of(context).validate()) {
      widget.onSubmitted(
        context.read<FileValueCubit>().state!.path,
        _nameController.text,
        context.read<DateTimeValueCubit>().state!,
        _aidController.text,
        _passwordController.text,
      );
      context.pop(true);
    }
  }

  GiftKey? get _giftKey => widget.giftKey;

  static TranslationsWidgetsFormEn get _translations =>
      Injector.instance.translations.widgets.form;
}

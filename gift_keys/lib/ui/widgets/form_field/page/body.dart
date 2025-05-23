import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/key_form/bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/form_validators.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/static/resources/sizes.dart';
import 'package:gift_keys/ui/widgets/form_field/date.dart';
import 'package:gift_keys/ui/widgets/form_field/image/form_field.dart';
import 'package:gift_keys/ui/widgets/form_field/page/button.dart';
import 'package:gift_keys/ui/widgets/form_field/page/page.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';

class FormFieldPageBody extends StatefulWidget {
  const FormFieldPageBody({
    required this.buttonTitle,
    required this.giftKey,
    required this.onSubmitted,
    super.key,
  });

  final String buttonTitle;
  final GiftKey? giftKey;
  final FormFieldSubmitCallback onSubmitted;

  @override
  State<FormFieldPageBody> createState() => _FormFieldPageBodyState();
}

class _FormFieldPageBodyState extends State<FormFieldPageBody> {
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
    return BlocSelector<KeyFormBloc, KeyFormState, bool>(
      selector: (state) => state is KeyFormLoadInProgress,
      builder: (context, isLoading) => PopScope(
        canPop: !isLoading,
        child: IgnorePointer(
          ignoring: isLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
              vertical: Sizes.verticalPadding,
            ),
            children: [
              ImagePickerFormField(
                initialValue: context.read<FileValueCubit>().state,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _nameController,
                icon: Icons.person,
                label: _translations.name.hint,
                autofillHints: const [AutofillHints.name],
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: FormValidators.validateName,
              ),
              const SizedBox(height: 10),
              DateFormField(
                labelText: _translations.birthday.hint,
                validator: FormValidators.validateBirthday,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _aidController,
                label: _translations.aid.hint,
                icon: Icons.badge,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.characters,
                validator: FormValidators.validateAid,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _passwordController,
                label: _translations.password.hint,
                icon: Icons.lock,
                autofillHints: const [AutofillHints.newPassword],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: FormValidators.validatePassword,
                onSubmitted: () => _onSubmitted(context),
              ),
              const SizedBox(height: 20),
              switch (isLoading) {
                true => const FormFieldSubmitButton.loading(),
                false => FormFieldSubmitButton.normal(
                  buttonTitle: widget.buttonTitle,
                  onPressed: () => _onSubmitted(context),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmitted(BuildContext context) {
    if (Form.of(context).validate()) {
      FocusScope.of(context).unfocus();
      widget.onSubmitted(
        context.read<FileValueCubit>().state!.path,
        _nameController.text,
        context.read<DateTimeValueCubit>().state!,
        _aidController.text,
        _passwordController.text,
      );
    }
  }

  GiftKey? get _giftKey => widget.giftKey;

  static TranslationsWidgetsFormEn get _translations =>
      Injector.instance.translations.widgets.form;
}

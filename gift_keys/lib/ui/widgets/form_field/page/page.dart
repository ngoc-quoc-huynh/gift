import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/widgets/form_field/page/body.dart';
import 'package:gift_keys/ui/widgets/responsive_box.dart';

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
      body: ResponsiveBox(
        child: AutofillGroup(
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
              child: FormFieldPageBody(
                buttonTitle: buttonTitle,
                giftKey: giftKey,
                onSubmitted: onSubmitted,
              ),
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

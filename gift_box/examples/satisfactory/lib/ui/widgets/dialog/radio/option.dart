import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/blocs/value/cubit.dart';
import 'package:gift_box_satisfactory/static/resources/sizes.dart';

class RadioDialogOption<T> extends StatelessWidget {
  const RadioDialogOption({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final T value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValueCubit<T>, T>(
      builder: (context, selectedOption) => RadioListTile<T>(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        title: Text(title),
        value: value,
      ),
    );
  }
}

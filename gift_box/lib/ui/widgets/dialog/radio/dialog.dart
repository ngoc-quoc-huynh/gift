import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/value/cubit.dart';
import 'package:gift_box/ui/widgets/dialog/action.dart';
import 'package:gift_box/ui/widgets/dialog/dialog.dart';
import 'package:gift_box/ui/widgets/dialog/radio/option.dart';

class RadioDialog<T extends Object> extends StatelessWidget {
  const RadioDialog({
    required this.title,
    required this.options,
    super.key,
  });

  final String title;
  final List<RadioDialogOption<T>> options;

  @override
  Widget build(BuildContext context) {
    return CustomDialog.alert(
      title: title,
      content: BlocBuilder<ValueCubit<T>, T>(
        builder: (context, option) => RadioGroup(
          groupValue: option,
          onChanged: (value) => context.read<ValueCubit<T>>().update(value!),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options,
          ),
        ),
      ),
      actions: [
        const AlertDialogAction.cancel(),
        AlertDialogAction.confirm(
          result: () => context.read<ValueCubit<T>>().state,
        ),
      ],
    );
  }
}

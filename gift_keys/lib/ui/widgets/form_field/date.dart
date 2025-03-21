import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/blocs/value/cubit.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({required String labelText, super.validator, super.key})
    : super(
        builder:
            (field) => _Body(
              field: field,
              labelText: labelText,
              onTap: () => _show(field, labelText),
            ),
      );

  static Future<void> _show(
    FormFieldState<DateTime> field,
    String labelText,
  ) async {
    final context = field.context;
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime(3000),
      fieldLabelText: labelText,
      locale: Injector.instance.translations.$meta.locale.flutterLocale,
    );

    if (context.mounted && date != null) {
      field.didChange(date);
      context.read<DateTimeValueCubit>().update(date);
    }
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.field,
    required this.labelText,
    required this.onTap,
  });

  final String labelText;
  final FormFieldState<DateTime> field;
  final VoidCallback onTap;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final date = context.read<DateTimeValueCubit>().state;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _onDateTimeChanged(context, date),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DateTimeValueCubit, DateTime?>(
      listener: _onDateTimeChanged,
      child: TextFormField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: const Icon(Icons.date_range),
          errorText: widget.field.errorText,
        ),
        onTap: widget.onTap,
      ),
    );
  }

  void _onDateTimeChanged(BuildContext _, DateTime? state) {
    widget.field.didChange(state);
    _controller.text = state?.format(DateTimeFormat.normal) ?? '';
  }
}

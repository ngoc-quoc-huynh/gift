import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    required String labelText,
    required ValueChanged<DateTime> onDateSelected,
    super.validator,
    super.key,
  }) : super(
         builder:
             (field) => _Body(
               errorText: field.errorText,
               labelText: labelText,
               onTap: () => _show(field, onDateSelected, labelText),
               value: field.value,
             ),
       );

  static Future<void> _show(
    FormFieldState<DateTime> field,
    ValueChanged<DateTime> onDateSelected,
    String labelText,
  ) async {
    final date = await showDatePicker(
      context: field.context,
      firstDate: DateTime(2025),
      lastDate: DateTime(3000),
      fieldLabelText: labelText,
      locale: Injector.instance.translations.$meta.locale.flutterLocale,
    );

    if (date != null) {
      field.didChange(date);
      onDateSelected.call(date);
    }
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.errorText,
    required this.labelText,
    required this.onTap,
    required this.value,
  });

  final DateTime? value;
  final String labelText;
  final String? errorText;
  final VoidCallback onTap;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && widget.value != null) {
      _onValueChanged();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: const Icon(Icons.date_range),
        errorText: widget.errorText,
      ),
      onTap: widget.onTap,
    );
  }

  void _onValueChanged() => WidgetsBinding.instance.addPostFrameCallback(
    (_) => _controller.text = widget.value!.format(DateTimeFormat.yMd),
  );
}

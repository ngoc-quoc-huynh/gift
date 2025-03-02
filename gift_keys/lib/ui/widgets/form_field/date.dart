import 'package:flutter/material.dart';
import 'package:gift_keys/injector.dart';
import 'package:intl/intl.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    required String labelText,
    TextEditingController? controller,
    super.validator,
    super.key,
  }) : super(
          builder: (field) => _Body(
            controller: controller,
            errorText: field.errorText,
            labelText: labelText,
            onTap: () => _show(field, labelText),
            value: field.value,
          ),
        );

  static Future<void> _show(
    FormFieldState<DateTime> field,
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
    }
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.controller,
    required this.errorText,
    required this.labelText,
    required this.onTap,
    required this.value,
  });

  final TextEditingController? controller;
  final DateTime? value;
  final String labelText;
  final String? errorText;
  final VoidCallback onTap;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = switch (widget.controller) {
      null => TextEditingController(),
      final controller => controller,
    };
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
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

  void _onValueChanged() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = DateFormat.yMd(
            Injector
                .instance.translations.$meta.locale.flutterLocale.countryCode,
          ).format(widget.value!);
        }
      });
}

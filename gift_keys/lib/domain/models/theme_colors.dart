import 'package:dynamic_color/dynamic_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomThemeColors extends ThemeExtension<CustomThemeColors>
    with EquatableMixin {
  const CustomThemeColors({this.success = Colors.green});

  final Color success;

  @override
  CustomThemeColors copyWith({Color? success, Color? warning}) =>
      CustomThemeColors(success: success ?? this.success);

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) =>
      switch (other) {
        CustomThemeColors() => CustomThemeColors(
          success: Color.lerp(success, other.success, t)!,
        ),
        _ => this,
      };

  CustomThemeColors harmonized(ColorScheme colorScheme) =>
      copyWith(success: success.harmonizeWith(colorScheme.primary));

  @override
  // ignore: list-all-equatable-fields, we need to compare the value of the colors.
  List<Object?> get props {
    int normalizeTo255(double component) => (component * 255).round();
    return [
      normalizeTo255(success.r),
      normalizeTo255(success.g),
      normalizeTo255(success.b),
      normalizeTo255(success.a),
      type,
    ];
  }
}

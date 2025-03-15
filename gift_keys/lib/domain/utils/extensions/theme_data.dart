import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/theme_colors.dart';

extension ThemeDataExtension on ThemeData {
  CustomThemeColors get customColors => extension<CustomThemeColors>()!;
}

import 'package:gift_keys/domain/models/theme_colors.dart';
import 'package:material_ui/material_ui.dart';

extension ThemeDataExtension on ThemeData {
  CustomThemeColors get customColors => extension<CustomThemeColors>()!;
}

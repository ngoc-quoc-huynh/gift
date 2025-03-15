import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/theme_colors.dart';

final class CustomTheme {
  const CustomTheme._();

  static ThemeData lightTheme(TextTheme textTheme) =>
      _themeData(Brightness.light, textTheme);

  static ThemeData darkTheme(TextTheme textTheme) =>
      _themeData(Brightness.dark, textTheme);

  static ThemeData _themeData(Brightness brightness, TextTheme textTheme) {
    final colorScheme = _colorScheme(brightness);
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      extensions: [const CustomThemeColors().harmonized(colorScheme)],
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: Map.fromEntries(
          TargetPlatform.values.map(
            (platform) =>
                MapEntry(platform, const FadeForwardsPageTransitionsBuilder()),
          ),
        ),
      ),
    );
  }

  static ColorScheme _colorScheme(Brightness brightness) =>
      ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: Colors.purple,
      ).harmonized();
}

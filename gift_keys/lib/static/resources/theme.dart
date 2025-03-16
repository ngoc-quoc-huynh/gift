import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gift_keys/domain/models/theme_colors.dart';
import 'package:gift_keys/static/resources/sizes.dart';

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
      dialogTheme: const DialogThemeData(
        actionsPadding: EdgeInsets.only(
          left: Sizes.horizontalPadding,
          right: Sizes.horizontalPadding,
          bottom: Sizes.verticalPadding / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
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
      // ignore: deprecated_member_use, since we want to use the updated version.
      progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }

  static ColorScheme _colorScheme(Brightness brightness) =>
      ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: Colors.purple,
      ).harmonized();
}

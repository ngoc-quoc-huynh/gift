import 'package:flutter/material.dart';

final class CustomTheme {
  const CustomTheme._();

  static final ThemeData light = ThemeData.light().copyWith(
    // ignore: deprecated_member_use, since we want to use the updated version.
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
  );
  static final ThemeData dark = ThemeData.dark().copyWith(
    // ignore: deprecated_member_use, since we want to use the updated version.
    progressIndicatorTheme: const ProgressIndicatorThemeData(year2023: false),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map.fromEntries(
        TargetPlatform.values.map(
          (platform) => MapEntry(
            platform,
            const FadeForwardsPageTransitionsBuilder(),
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:gift_box/static/resources/sizes.dart';

final class CustomTheme {
  const CustomTheme._();

  static final ThemeData light = ThemeData.light().copyWith(
    dialogTheme: const DialogThemeData(
      actionsPadding: EdgeInsets.only(
        left: Sizes.horizontalPadding,
        right: Sizes.horizontalPadding,
        bottom: Sizes.verticalPadding / 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
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
  );
  static final ThemeData dark = ThemeData.dark().copyWith(
    dialogTheme: const DialogThemeData(
      actionsPadding: EdgeInsets.only(
        left: Sizes.horizontalPadding,
        right: Sizes.horizontalPadding,
        bottom: Sizes.verticalPadding / 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
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
  );
}

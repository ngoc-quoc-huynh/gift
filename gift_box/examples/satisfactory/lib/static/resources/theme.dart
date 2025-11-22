import 'package:flutter/material.dart';
import 'package:gift_box_satisfactory/static/resources/colors.dart';
import 'package:gift_box_satisfactory/static/resources/sizes.dart';

final class CustomTheme {
  const CustomTheme._();

  static final light = _buildTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.orange,
    ),
    textTheme: _typography.white,
  );

  static final ThemeData dark = _buildTheme(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomColors.orange,
      brightness: Brightness.dark,
    ),
    textTheme: _typography.white.apply(),
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) => ThemeData(
    appBarTheme: const AppBarTheme(centerTitle: true),
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    dialogTheme: const DialogThemeData(
      actionsPadding: EdgeInsets.only(
        left: Sizes.horizontalPadding,
        right: Sizes.horizontalPadding,
        bottom: Sizes.verticalPadding / 2,
      ),
      constraints: BoxConstraints(
        minWidth: 280,
        maxWidth: Sizes.maxWidgetWidthConstraint,
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

  static final _typography = Typography.material2021();
}

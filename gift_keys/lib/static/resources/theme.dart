import 'package:flutter/material.dart';

final class CustomTheme {
  const CustomTheme._();

  static final ThemeData light = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
  static final ThemeData dark = ThemeData.dark().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}

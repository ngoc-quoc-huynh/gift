import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/theme_colors.dart';

void main() {
  group('CustomThemeColors', () {
    test('returns correct default colors.', () {
      const customThemeColors = CustomThemeColors();

      expect(customThemeColors.success, Colors.green);
    });
  });

  group('copyWith', () {
    test(
      'returns correctly if nothing is provided.',
      () => expect(
        const CustomThemeColors().copyWith(),
        const CustomThemeColors(),
      ),
    );

    test(
      'returns correctly if success is provided.',
      () => expect(
        const CustomThemeColors().copyWith(success: Colors.red),
        const CustomThemeColors(success: Colors.red),
      ),
    );
  });

  group('lerp', () {
    test(
      'returns same instance if other is null.',
      () => expect(
        const CustomThemeColors().lerp(null, 0),
        const CustomThemeColors(),
      ),
    );

    test(
      'returns original if lerp is 0.',
      () => expect(
        const CustomThemeColors().lerp(
          const CustomThemeColors(success: Colors.red),
          0,
        ),
        const CustomThemeColors(),
      ),
    );

    test(
      'returns interpolated if lerp is 0.5.',
      () => expect(
        const CustomThemeColors().lerp(
          const CustomThemeColors(success: Colors.red),
          0.5,
        ),
        const CustomThemeColors(success: Color(0xFFA07943)),
      ),
    );

    test(
      'returns other if lerp is 1.',
      () => expect(
        const CustomThemeColors().lerp(
          const CustomThemeColors(success: Colors.red),
          1,
        ),
        const CustomThemeColors(success: Colors.red),
      ),
    );
  });

  group('harmonized', () {
    test('harmonized modifies success color based on ColorScheme', () {
      const colorScheme = ColorScheme.dark();
      final harmonizedColors = const CustomThemeColors().harmonized(
        colorScheme,
      );

      expect(harmonizedColors.success, isNot(Colors.green));
      expect(
        harmonizedColors.success,
        Colors.green.harmonizeWith(colorScheme.primary),
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/theme_colors.dart';
import 'package:gift_keys/domain/utils/extensions/theme_data.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('customColors', () {
    test('returns correctly.', () {
      const customColors = CustomThemeColors();
      final themeData = ThemeData(extensions: const [customColors]);

      expect(themeData.customColors, customColors);
    });
  });
}

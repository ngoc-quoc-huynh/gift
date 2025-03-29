import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';

void main() {
  group('format', () {
    final dateTime = DateTime(2025, 1, 2);

    group('German locale', () {
      setUpAll(
        () => Injector.instance.registerSingleton(AppLocale.de.buildSync()),
      );

      tearDownAll(Injector.instance.reset);

      test('returns correctly.', () {
        expect(dateTime.format(DateTimeFormat.compact), '20250102');
        expect(dateTime.format(DateTimeFormat.normal), '02.01.2025');
        expect(dateTime.format(DateTimeFormat.dashSeparated), '2025-01-02');
      });
    });

    group('English locale', () {
      setUpAll(
        () => Injector.instance.registerSingleton(AppLocale.en.buildSync()),
      );

      tearDownAll(Injector.instance.reset);

      test('returns correctly.', () {
        expect(dateTime.format(DateTimeFormat.compact), '20250102');
        expect(dateTime.format(DateTimeFormat.normal), '01/02/2025');
        expect(dateTime.format(DateTimeFormat.dashSeparated), '2025-01-02');
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/utils/extensions/duration.dart';

void main() {
  group('toHHMMSS', () {
    test('formats leading zeroes correctly', () {
      expect(
        Duration.zero.toHHMMSS(),
        '00:00:00',
      );
      expect(
        const Duration(hours: 1, minutes: 1, seconds: 1).toHHMMSS(),
        '01:01:01',
      );
      expect(
        const Duration(hours: 11, minutes: 1, seconds: 1).toHHMMSS(),
        '11:01:01',
      );
      expect(
        const Duration(hours: 11, minutes: 11, seconds: 1).toHHMMSS(),
        '11:11:01',
      );
    });

    test('formats durations correctly', () {
      expect(
        const Duration(hours: 12, minutes: 34, seconds: 56).toHHMMSS(),
        '12:34:56',
      );
      expect(
        const Duration(
          hours: 100,
        ).toHHMMSS(),
        '100:00:00',
      );
      expect(const Duration(seconds: 60).toHHMMSS(), '00:01:00');
      expect(const Duration(minutes: 60).toHHMMSS(), '01:00:00');
      expect(const Duration(hours: 100).toHHMMSS(), '100:00:00');
    });
  });
}

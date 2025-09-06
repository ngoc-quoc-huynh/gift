import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/utils/extensions/duration.dart';

void main() {
  group('toDDHHMMSS', () {
    test('formats leading zeroes correctly', () {
      expect(Duration.zero.toDDHHMMSS(), '00:00:00:00');
      expect(
        const Duration(days: 1, hours: 1, minutes: 1, seconds: 1).toDDHHMMSS(),
        '01:01:01:01',
      );
      expect(
        const Duration(days: 11, hours: 1, minutes: 1, seconds: 1).toDDHHMMSS(),
        '11:01:01:01',
      );
      expect(
        const Duration(
          days: 11,
          hours: 11,
          minutes: 1,
          seconds: 1,
        ).toDDHHMMSS(),
        '11:11:01:01',
      );
    });

    test('formats durations correctly', () {
      expect(
        const Duration(hours: 12, minutes: 34, seconds: 56).toDDHHMMSS(),
        '00:12:34:56',
      );
      expect(const Duration(seconds: 1).toDDHHMMSS(), '00:00:00:01');
      expect(const Duration(seconds: 60).toDDHHMMSS(), '00:00:01:00');
      expect(const Duration(minutes: 1).toDDHHMMSS(), '00:00:01:00');
      expect(const Duration(minutes: 60).toDDHHMMSS(), '00:01:00:00');
      expect(const Duration(hours: 1).toDDHHMMSS(), '00:01:00:00');
      expect(const Duration(hours: 24).toDDHHMMSS(), '01:00:00:00');
      expect(const Duration(days: 1).toDDHHMMSS(), '01:00:00:00');
    });
  });
}

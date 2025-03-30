import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/route.dart';

void main() {
  group('call', () {
    test('returns name correctly.', () => expect(Route('page')(), 'page'));
  });
}

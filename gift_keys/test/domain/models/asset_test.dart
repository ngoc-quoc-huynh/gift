import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/domain/models/asset.dart';

void main() {
  group('call', () {
    test(
      'returns path correctly.',
      () => expect(Asset('test.webp')(), 'test.webp'),
    );
  });
}

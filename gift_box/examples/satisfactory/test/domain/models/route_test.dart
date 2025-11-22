import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/route.dart';

void main() {
  test(
    'call returns correctly.',
    () {
      for (final route in AppRoute.values) {
        expect(route(), route.name);
      }
    },
  );
}

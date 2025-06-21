import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/route.dart';

void main() {
  test(
    'call returns correctly.',
    () {
      expect(AppRoute.home(), AppRoute.home.name);
      expect(AppRoute.gift(), AppRoute.gift.name);
      expect(AppRoute.timer(), AppRoute.timer.name);
    },
  );
}

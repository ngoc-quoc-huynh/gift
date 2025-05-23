import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/route.dart';

void main() {
  test(
    'call returns correctly.',
    () {
      expect(AppRoute.awesomeShop(), AppRoute.awesomeShop.name);
      expect(AppRoute.awesomeShopCatalog(), AppRoute.awesomeShopCatalog.name);
      expect(AppRoute.awesomeSink(), AppRoute.awesomeSink.name);
      expect(AppRoute.gift(), AppRoute.gift.name);
      expect(AppRoute.settings(), AppRoute.settings.name);
      expect(AppRoute.timer(), AppRoute.timer.name);
    },
  );
}

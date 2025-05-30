import 'package:gift_box/domain/models/route.dart';

final class Routes {
  const Routes._();

  static final awesomeSink = Route('awesome-sink');
  static final awesomeShop = Route('awesome-shop');
  static final awesomeShopCustomizer = Route('awesome-shop-customizer');
  static final awesomeShopEquipment = Route('awesome-shop-equipment');
  static final awesomeShopSpecials = Route('awesome-shop-specials');
  static final awesomeShopCustomizerDetail = Route(
    'awesome-shop-customizer-detail',
  );
  static final awesomeShopEquipmentDetail = Route(
    'awesome-shop-equipment-detail',
  );
  static final awesomeShopSpecialsDetail = Route(
    'awesome-shop-specials-detail',
  );
  static final giftPage = Route('gift');
  static final timerPage = Route('timer');
  static final settingsPage = Route('settings');
}

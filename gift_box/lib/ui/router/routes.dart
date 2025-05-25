import 'package:gift_box/domain/models/route.dart';

final class Routes {
  const Routes._();

  static final awesomeSink = Route('awesome-sink');
  static final awesomeShop = Route('awesome-shop');
  static final awesomeShopCatalog = Route('awesome-shop-catalog');
  static final awesomeShopItem = Route('awesome-shop-item');
  static final giftPage = Route('gift');
  static final timerPage = Route('timer');
  static final settingsPage = Route('settings');
}

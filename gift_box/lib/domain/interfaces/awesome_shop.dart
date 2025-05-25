import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';

abstract interface class AwesomeShopApi {
  const AwesomeShopApi();

  List<AwesomeShopItemMeta> loadCustomizerMetas();

  List<AwesomeShopItemMeta> loadEquipmentMetas();

  List<AwesomeShopItemMeta> loadSpecialMetas();
}

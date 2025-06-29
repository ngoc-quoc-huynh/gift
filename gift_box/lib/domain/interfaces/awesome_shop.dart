import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_id.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';

abstract interface class AwesomeShopApi {
  const AwesomeShopApi();

  List<AwesomeShopItemMeta> loadCustomizerMetas();

  List<AwesomeShopItemMeta> loadEquipmentMetas();

  List<AwesomeShopItemMeta> loadSpecialMetas();

  AwesomeShopItem loadItem(String id);

  Future<void> buyItem(String id);

  AdaAudio loadAdaAudio(String id);

  List<AwesomeShopItemId> loadPurchasedItemIds();
}

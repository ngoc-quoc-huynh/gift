import 'dart:async';

import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/shop_item.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/domain/models/shop_item_meta.dart';

abstract interface class ShopApi {
  const ShopApi();

  FutureOr<List<ShopItemMeta>> loadCustomizerMetas();

  FutureOr<List<ShopItemMeta>> loadEquipmentMetas();

  FutureOr<List<ShopItemMeta>> loadSpecialMetas();

  FutureOr<ShopItem> loadItem(String id);

  Future<void> buyItem(String id);

  FutureOr<AdaAudio> loadAdaAudio(String id);

  FutureOr<Set<ShopItemId>> loadPurchasedItemIds();
}

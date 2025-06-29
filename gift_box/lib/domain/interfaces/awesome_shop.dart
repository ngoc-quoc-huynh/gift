import 'dart:async';

import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_id.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';

abstract interface class AwesomeShopApi {
  const AwesomeShopApi();

  FutureOr<List<AwesomeShopItemMeta>> loadCustomizerMetas();

  FutureOr<List<AwesomeShopItemMeta>> loadEquipmentMetas();

  FutureOr<List<AwesomeShopItemMeta>> loadSpecialMetas();

  FutureOr<AwesomeShopItem> loadItem(String id);

  Future<void> buyItem(String id);

  FutureOr<AdaAudio> loadAdaAudio(String id);

  FutureOr<List<AwesomeShopItemId>> loadPurchasedItemIds();
}

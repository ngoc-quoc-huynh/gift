import 'dart:async';

import 'package:gift_box/domain/interfaces/shop.dart';
import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/shop_item.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/domain/models/shop_item_meta.dart';
import 'package:gift_box/infrastructure/dtos/shop/id.dart';
import 'package:gift_box/infrastructure/dtos/shop/item.dart';
import 'package:gift_box/injector.dart';
import 'package:hive_ce/hive.dart';

final class LocalShopRepository implements ShopApi {
  const LocalShopRepository(this._box);

  final Box<bool> _box;

  @override
  FutureOr<List<ShopItemMeta>> loadCustomizerMetas() =>
      _loadMetas(_customizerKeys);

  @override
  FutureOr<List<ShopItemMeta>> loadEquipmentMetas() =>
      _loadMetas(_equipmentKeys);

  @override
  FutureOr<List<ShopItemMeta>> loadSpecialMetas() => _loadMetas(_specialKey);

  @override
  FutureOr<ShopItem> loadItem(String id) =>
      _rawItems[ShopItemKey.byId(id)]!.toItem();

  @override
  Future<void> buyItem(String id) => _box.put(id, true);

  @override
  FutureOr<AdaAudio> loadAdaAudio(String id) =>
      _rawItems[ShopItemKey.byId(id)]!.audio;

  @override
  FutureOr<List<ShopItemId>> loadPurchasedItemIds() => [
    for (final item in _rawItems.values)
      if (_box.containsKey(item.id)) ShopItemKey.byId(item.id).toDomain(),
  ];

  static final _rawItems = {
    ShopItemKey.ada: RawShopItem(
      id: ShopItemKey.ada.id,
      name: _translations.ada.name,
      description: _translations.ada.description,
      price: 2,
      asset: Asset.ada,
      metaHeight: 50,
      height: 100,
      audio: AdaAudio(
        Asset.adaAudio,
        [
          TranscriptSegment(_translations.ada.comment.first),
          TranscriptSegment(
            _translations.ada.comment[1],
            const Duration(milliseconds: 6000),
          ),
        ],
      ),
    ),
    ShopItemKey.coffeeCup: RawShopItem(
      id: ShopItemKey.coffeeCup.id,
      name: _translations.coffeeCup.name,
      description: _translations.coffeeCup.description,
      price: 1,
      asset: Asset.coffeeCup,
      metaHeight: 100,
      height: 175,
      audio: AdaAudio(
        Asset.coffeeCupAudio,
        [
          TranscriptSegment(_translations.coffeeCup.comment.first),
          TranscriptSegment(
            _translations.coffeeCup.comment[1],
            const Duration(milliseconds: 5500),
          ),
          TranscriptSegment(
            _translations.coffeeCup.comment[2],
            const Duration(milliseconds: 11000),
          ),
        ],
      ),
    ),
    ShopItemKey.darkMode: RawShopItem(
      id: ShopItemKey.darkMode.id,
      name: _translations.darkMode.name,
      description: _translations.darkMode.description,
      price: 1,
      asset: Asset.darkMode,
      metaHeight: 100,
      height: 150,
      audio: AdaAudio(
        Asset.darkModeAudio,
        [
          TranscriptSegment(_translations.darkMode.comment.first),
          TranscriptSegment(
            _translations.darkMode.comment[1],
            const Duration(milliseconds: 7000),
          ),
        ],
      ),
    ),
    ShopItemKey.germanDrive: RawShopItem(
      id: ShopItemKey.germanDrive.id,
      name: _translations.germanDrive.name,
      description: _translations.germanDrive.description,
      price: 1,
      asset: Asset.germanDrive,
      metaHeight: 100,
      height: 175,
      audio: AdaAudio(
        Asset.germanDriveAudio,
        [
          TranscriptSegment(_translations.germanDrive.comment.first),
          TranscriptSegment(
            _translations.germanDrive.comment[1],
            const Duration(milliseconds: 7600),
          ),
        ],
      ),
    ),

    ShopItemKey.reset: RawShopItem(
      id: ShopItemKey.reset.id,
      name: _translations.reset.name,
      description: _translations.reset.description,
      price: 3,
      asset: Asset.reset,
      metaHeight: 100,
      height: 150,
      audio: AdaAudio(
        Asset.resetAudio,
        [
          TranscriptSegment(_translations.reset.comment.first),
          TranscriptSegment(
            _translations.reset.comment[1],
            const Duration(milliseconds: 6500),
          ),
        ],
      ),
    ),
    ShopItemKey.musicTape: RawShopItem(
      id: ShopItemKey.musicTape.id,
      name: _translations.musicTape.name,
      description: _translations.musicTape.description,
      price: 2,
      asset: Asset.musicTape,
      metaHeight: 85,
      height: 150,
      audio: AdaAudio(
        Asset.musicTapeAudio,
        [
          TranscriptSegment(_translations.musicTape.comment.first),
          TranscriptSegment(
            _translations.musicTape.comment[1],
            const Duration(milliseconds: 6500),
          ),
        ],
      ),
    ),
  };

  static const _customizerKeys = [
    ShopItemKey.darkMode,
    ShopItemKey.germanDrive,
  ];

  static const _specialKey = [
    ShopItemKey.ada,
    ShopItemKey.reset,
    ShopItemKey.musicTape,
  ];

  static const _equipmentKeys = [ShopItemKey.coffeeCup];

  bool _loadIsItemPurchased(ShopItemKey key) => _box.get(key.id) ?? false;

  List<ShopItemMeta> _loadMetas(List<ShopItemKey> keys) => keys
      .map(
        (id) => _rawItems[id]!.toMeta(
          isPurchased: _loadIsItemPurchased(id),
        ),
      )
      .toList();

  static TranslationsPagesShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.shopCatalog.items;
}

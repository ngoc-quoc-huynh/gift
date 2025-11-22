import 'dart:async';

import 'package:gift_box_satisfactory/domain/interfaces/shop.dart';
import 'package:gift_box_satisfactory/domain/models/ada_audio.dart';
import 'package:gift_box_satisfactory/domain/models/asset.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_id.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_meta.dart';
import 'package:gift_box_satisfactory/infrastructure/dtos/shop/id.dart';
import 'package:gift_box_satisfactory/infrastructure/dtos/shop/item.dart';
import 'package:gift_box_satisfactory/injector.dart';
import 'package:hive_ce/hive.dart';

final class LocalShopRepository implements ShopApi {
  const LocalShopRepository(this._box);

  final Box<bool> _box;

  @override
  FutureOr<List<ShopItemMeta>> loadMetas() => ShopItemKey.values
      .map(
        (id) => _rawItems[id]!.toMeta(
          isPurchased: _loadIsItemPurchased(id),
        ),
      )
      .toList(growable: false);

  @override
  FutureOr<ShopItem> loadItem(String id) =>
      _rawItems[ShopItemKey.byId(id)]!.toItem();

  @override
  Future<void> buyItem(String id) => _box.put(id, true);

  @override
  FutureOr<AdaAudio> loadAdaAudio(String id) =>
      _rawItems[ShopItemKey.byId(id)]!.audio;

  @override
  FutureOr<Set<ShopItemId>> loadPurchasedItemIds() => {
    for (final item in _rawItems.values)
      if (_box.containsKey(item.id)) ShopItemKey.byId(item.id).toDomain(),
  };

  @override
  Future<void> resetPurchasedItems() => _box.deleteAll(
    [
      ShopItemKey.darkMode.id,
      ShopItemKey.germanDrive.id,
      ShopItemKey.reset.id,
      ShopItemKey.musicTape.id,
    ],
  );

  static Map<ShopItemKey, RawShopItem> get _rawItems {
    final coffeCupTranslations = _translations.coffeeCup;

    return {
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
        name: coffeCupTranslations.name,
        description: coffeCupTranslations.description,
        price: 1,
        asset: Asset.coffeeCup,
        metaHeight: 100,
        height: 175,
        audio: AdaAudio(
          Asset.coffeeCupAudio,
          [
            TranscriptSegment(coffeCupTranslations.comment.first),
            TranscriptSegment(
              coffeCupTranslations.comment[1],
              const Duration(milliseconds: 5500),
            ),
            TranscriptSegment(
              coffeCupTranslations.comment[2],
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
  }

  bool _loadIsItemPurchased(ShopItemKey key) => _box.get(key.id) ?? false;

  static TranslationsPagesShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.shopCatalog.items;
}

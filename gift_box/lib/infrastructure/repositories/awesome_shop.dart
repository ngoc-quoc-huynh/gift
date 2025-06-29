import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_id.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/infrastructure/dtos/awesome_shop/id.dart';
import 'package:gift_box/infrastructure/dtos/awesome_shop/item.dart';
import 'package:gift_box/injector.dart';
import 'package:hive_ce/hive.dart';

final class AwesomeShopRepository implements AwesomeShopApi {
  const AwesomeShopRepository(this._box);

  final Box<bool> _box;

  @override
  List<AwesomeShopItemMeta> loadCustomizerMetas() =>
      _loadMetas(_customizerKeys);

  @override
  List<AwesomeShopItemMeta> loadEquipmentMetas() => _loadMetas(_equipmentKeys);

  @override
  List<AwesomeShopItemMeta> loadSpecialMetas() => _loadMetas(_specialKey);

  @override
  AwesomeShopItem loadItem(String id) =>
      _rawItems[AwesomeShopItemKey.byId(id)]!.toItem();

  @override
  Future<void> buyItem(String id) => _box.put(id, true);

  @override
  AdaAudio loadAdaAudio(String id) =>
      _rawItems[AwesomeShopItemKey.byId(id)]!.audio;

  @override
  List<AwesomeShopItemId> loadPurchasedItemIds() => [
    for (final item in _rawItems.values)
      if (_box.containsKey(item.id))
        AwesomeShopItemKey.byId(item.id).toDomain(),
  ];

  static final _rawItems = {
    AwesomeShopItemKey.ada: RawAwesomeShopItem(
      id: AwesomeShopItemKey.ada.id,
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
    AwesomeShopItemKey.coffeeCup: RawAwesomeShopItem(
      id: AwesomeShopItemKey.coffeeCup.id,
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
    AwesomeShopItemKey.darkMode: RawAwesomeShopItem(
      id: AwesomeShopItemKey.darkMode.id,
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
    AwesomeShopItemKey.germanDrive: RawAwesomeShopItem(
      id: AwesomeShopItemKey.germanDrive.id,
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

    AwesomeShopItemKey.reset: RawAwesomeShopItem(
      id: AwesomeShopItemKey.reset.id,
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
    AwesomeShopItemKey.musicTape: RawAwesomeShopItem(
      id: AwesomeShopItemKey.musicTape.id,
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
    AwesomeShopItemKey.darkMode,
    AwesomeShopItemKey.germanDrive,
  ];

  static const _specialKey = [
    AwesomeShopItemKey.ada,
    AwesomeShopItemKey.reset,
    AwesomeShopItemKey.musicTape,
  ];

  static const _equipmentKeys = [AwesomeShopItemKey.coffeeCup];

  bool _loadIsItemPurchased(AwesomeShopItemKey key) =>
      _box.get(key.id) ?? false;

  List<AwesomeShopItemMeta> _loadMetas(List<AwesomeShopItemKey> keys) => keys
      .map(
        (id) => _rawItems[id]!.toMeta(
          isPurchased: _loadIsItemPurchased(id),
        ),
      )
      .toList();

  static TranslationsPagesAwesomeShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog.items;
}

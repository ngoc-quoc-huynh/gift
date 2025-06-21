import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
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

  static final _rawItems = {
    AwesomeShopItemKey.ada: RawAwesomeShopItem(
      id: AwesomeShopItemKey.ada.id,
      name: _translations.ada.name,
      description: _translations.ada.description,
      price: 2,
      asset: Asset.ada,
      metaHeight: 50,
      height: 100,
    ),
    AwesomeShopItemKey.darkMode: RawAwesomeShopItem(
      id: AwesomeShopItemKey.darkMode.id,
      name: _translations.darkMode.name,
      description: _translations.darkMode.description,
      price: 1,
      asset: Asset.darkMode,
      metaHeight: 100,
      height: 150,
    ),
    AwesomeShopItemKey.germanDrive: RawAwesomeShopItem(
      id: AwesomeShopItemKey.germanDrive.id,
      name: _translations.germanDrive.name,
      description: _translations.germanDrive.description,
      price: 1,
      asset: Asset.germanDrive,
      metaHeight: 100,
      height: 175,
    ),
    AwesomeShopItemKey.coffeeCup: RawAwesomeShopItem(
      id: AwesomeShopItemKey.coffeeCup.id,
      name: _translations.coffeeCup.name,
      description: _translations.coffeeCup.description,
      price: 1,
      asset: Asset.coffeeCup,
      metaHeight: 100,
      height: 175,
    ),
    AwesomeShopItemKey.memoryPurger: RawAwesomeShopItem(
      id: AwesomeShopItemKey.memoryPurger.id,
      name: _translations.memoryPurger.name,
      description: _translations.memoryPurger.description,
      price: 3,
      asset: Asset.reset,
      metaHeight: 100,
      height: 150,
    ),
    AwesomeShopItemKey.musicTape: RawAwesomeShopItem(
      id: AwesomeShopItemKey.musicTape.id,
      name: _translations.musicTape.name,
      description: _translations.musicTape.description,
      price: 2,
      asset: Asset.musicTape,
      metaHeight: 85,
      height: 150,
    ),
  };

  static const _customizerKeys = [
    AwesomeShopItemKey.darkMode,
    AwesomeShopItemKey.germanDrive,
  ];

  static const _specialKey = [
    AwesomeShopItemKey.ada,
    AwesomeShopItemKey.memoryPurger,
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

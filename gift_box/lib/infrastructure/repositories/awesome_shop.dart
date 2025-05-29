import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/infrastructure/dtos/awesome_shop/id.dart';
import 'package:gift_box/infrastructure/dtos/awesome_shop/item.dart';
import 'package:gift_box/injector.dart';

final class AwesomeShopRepository implements AwesomeShopApi {
  const AwesomeShopRepository();

  @override
  List<AwesomeShopItemMeta> loadCustomizerMetas() => [
    AwesomeShopItemId.darkMode,
    AwesomeShopItemId.germanDrive,
  ].map((id) => _rawItems[id]!.toMeta()).toList();

  @override
  List<AwesomeShopItemMeta> loadSpecialMetas() => [
    AwesomeShopItemId.ada,
    AwesomeShopItemId.memoryPurger,
    AwesomeShopItemId.musicTape,
  ].map((id) => _rawItems[id]!.toMeta()).toList();

  @override
  List<AwesomeShopItemMeta> loadEquipmentMetas() => [
    _rawItems[AwesomeShopItemId.ficsitCoffeeCup]!.toMeta(),
  ];

  @override
  AwesomeShopItem loadItem(String id) =>
      _rawItems[AwesomeShopItemId.byId(id)]!.toItem();

  static final _rawItems = {
    AwesomeShopItemId.ada: RawAwesomeShopItem(
      id: AwesomeShopItemId.ada.id,
      name: _translations.ada.name,
      description: _translations.ada.description,
      price: 2,
      asset: Asset.ada,
      metaHeight: 50,
      height: 100,
    ),
    AwesomeShopItemId.darkMode: RawAwesomeShopItem(
      id: AwesomeShopItemId.darkMode.id,
      name: _translations.darkMode.name,
      description: _translations.darkMode.description,
      price: 1,
      asset: Asset.darkMode,
      metaHeight: 100,
      height: 150,
    ),
    AwesomeShopItemId.germanDrive: RawAwesomeShopItem(
      id: AwesomeShopItemId.germanDrive.id,
      name: _translations.germanDrive.name,
      description: _translations.germanDrive.description,
      price: 1,
      asset: Asset.germanDrive,
      metaHeight: 100,
      height: 175,
    ),
    AwesomeShopItemId.ficsitCoffeeCup: RawAwesomeShopItem(
      id: AwesomeShopItemId.ficsitCoffeeCup.id,
      name: _translations.ficsitCoffeeCup.name,
      description: _translations.ficsitCoffeeCup.description,
      price: 1,
      asset: Asset.ficsitCoffeeCup,
      metaHeight: 100,
      height: 175,
    ),
    AwesomeShopItemId.memoryPurger: RawAwesomeShopItem(
      id: AwesomeShopItemId.memoryPurger.id,
      name: _translations.memoryPurger.name,
      description: _translations.memoryPurger.description,
      price: 3,
      asset: Asset.reset,
      metaHeight: 100,
      height: 150,
    ),
    AwesomeShopItemId.musicTape: RawAwesomeShopItem(
      id: AwesomeShopItemId.musicTape.id,
      name: _translations.musicTape.name,
      description: _translations.musicTape.description,
      price: 2,
      asset: Asset.musicTape,
      metaHeight: 85,
      height: 150,
    ),
  };

  static TranslationsPagesAwesomeShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog.items;
}

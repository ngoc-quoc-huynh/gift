import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/assets.dart';

final class AwesomeShopRepository implements AwesomeShopApi {
  const AwesomeShopRepository();

  @override
  List<AwesomeShopItemMeta> loadCustomizerMetas() => [
    AwesomeShopItemMeta(
      id: 'dark-mode',
      name: _translations.darkMode.name,
      price: 1,
      asset: Assets.darkMode,
      height: 100,
    ),
    AwesomeShopItemMeta(
      id: 'german-drive',
      name: _translations.germanDrive.name,
      price: 1,
      asset: Assets.hardDrive,
      height: 100,
    ),
  ];

  @override
  List<AwesomeShopItemMeta> loadSpecialMetas() => [
    AwesomeShopItemMeta(
      id: 'ada',
      name: _translations.ada.name,
      price: 2,
      asset: Assets.ada,
      height: 50,
    ),
    AwesomeShopItemMeta(
      id: 'music-tape',
      name: _translations.musicTape.name,
      price: 2,
      asset: Assets.musicTape,
      height: 85,
    ),
    AwesomeShopItemMeta(
      id: 'memory-purger-5000',
      name: _translations.memoryPurger.name,
      price: 3,
      asset: Assets.nobelisk,
      height: 100,
    ),
  ];

  @override
  List<AwesomeShopItemMeta> loadEquipmentMetas() => [
    AwesomeShopItemMeta(
      id: 'ficsit-coffee-cup',
      name: _translations.ficsitCoffeeCup.name,
      price: 1,
      asset: Assets.ficsitCoffeeCup,
      height: 100,
    ),
  ];

  @override
  AwesomeShopItem loadItem(String id) => switch (id) {
    'ada' => AwesomeShopItem(
      id: id,
      name: _translations.ada.name,
      description: _translations.ada.description,
      price: 2,
      asset: Assets.ada,
      height: 100,
    ),
    'music-tape' => AwesomeShopItem(
      id: id,
      name: _translations.musicTape.name,
      description: _translations.musicTape.description,
      price: 2,
      asset: Assets.musicTape,
      height: 150,
    ),
    'dark-mode' => AwesomeShopItem(
      id: id,
      name: _translations.darkMode.name,
      description: _translations.darkMode.description,
      price: 1,
      asset: Assets.darkMode,
      height: 150,
    ),
    'ficsit-coffee-cup' => AwesomeShopItem(
      id: id,
      name: _translations.ficsitCoffeeCup.name,
      description: _translations.ficsitCoffeeCup.description,
      price: 1,
      asset: Assets.ficsitCoffeeCup,
      height: 175,
    ),
    'german-drive' => AwesomeShopItem(
      id: id,
      name: _translations.germanDrive.name,
      description: _translations.germanDrive.description,
      price: 1,
      asset: Assets.hardDrive,
      height: 175,
    ),
    'memory-purger-5000' => AwesomeShopItem(
      id: id,
      name: _translations.memoryPurger.name,
      description: _translations.memoryPurger.description,
      price: 3,
      asset: Assets.nobelisk,
      height: 150,
    ),
    _ => throw ArgumentError.value(
      id,
      'AwesomeShopItem with this id does not exist.',
    ),
  };

  static TranslationsPagesAwesomeShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog.items;
}

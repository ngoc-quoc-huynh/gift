import 'package:gift_box/domain/interfaces/awesome_shop.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';
import 'package:gift_box/injector.dart';

final class AwesomeShopRepository implements AwesomeShopApi {
  const AwesomeShopRepository();

  @override
  List<AwesomeShopItemMeta> loadCustomizerMetas() => [
    AwesomeShopItemMeta(
      id: 'dark-mode',
      name: _translations.darkMode,
      price: 1,
      asset: Asset.darkMode,
      height: 100,
    ),
    AwesomeShopItemMeta(
      id: 'german-drive',
      name: _translations.germanDrive,
      price: 1,
      asset: Asset.germanDrive,
      height: 100,
    ),
  ];

  @override
  List<AwesomeShopItemMeta> loadSpecialMetas() => [
    AwesomeShopItemMeta(
      id: 'ada',
      name: _translations.ada,
      price: 2,
      asset: Asset.ada,
      height: 50,
    ),
    AwesomeShopItemMeta(
      id: 'absolute-ficsit-tape',
      name: _translations.absoluteFicsitTape,
      price: 2,
      asset: Asset.musicTape,
      height: 85,
    ),
    AwesomeShopItemMeta(
      id: 'memory-purger-5000',
      name: _translations.memoryPurger,
      price: 3,
      asset: Asset.reset,
      height: 100,
    ),
  ];

  @override
  List<AwesomeShopItemMeta> loadEquipmentMetas() => [
    AwesomeShopItemMeta(
      id: 'ficsit-coffee-cup',
      name: _translations.ficsitCoffeeCup,
      price: 1,
      asset: Asset.ficsitCoffeeCup,
      height: 100,
    ),
  ];

  static TranslationsPagesAwesomeShopCatalogItemsEn get _translations =>
      Injector.instance.translations.pages.awesomeShopCatalog.items;
}

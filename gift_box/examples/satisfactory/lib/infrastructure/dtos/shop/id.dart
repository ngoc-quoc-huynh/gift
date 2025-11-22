import 'package:gift_box/domain/models/shop_item_id.dart';

enum ShopItemKey {
  ada('ada'),
  darkMode('dark-mode'),
  germanDrive('german-drive'),
  coffeeCup('coffee-cup'),
  reset('reset'),
  musicTape('music-tape')
  ;

  const ShopItemKey(this.id);

  factory ShopItemKey.byId(String id) => switch (id) {
    'ada' => ada,
    'dark-mode' => darkMode,
    'german-drive' => germanDrive,
    'coffee-cup' => coffeeCup,
    'reset' => reset,
    'music-tape' => musicTape,
    String() => throw ArgumentError.value(
      id,
      'id',
      'No enum value with that id.',
    ),
  };

  final String id;

  ShopItemId toDomain() => switch (this) {
    ShopItemKey.ada => ShopItemId.ada,
    ShopItemKey.darkMode => ShopItemId.darkMode,
    ShopItemKey.germanDrive => ShopItemId.germanDrive,
    ShopItemKey.coffeeCup => ShopItemId.coffeeCup,
    ShopItemKey.reset => ShopItemId.reset,
    ShopItemKey.musicTape => ShopItemId.musicTape,
  };
}

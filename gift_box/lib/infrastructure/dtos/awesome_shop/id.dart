import 'package:gift_box/domain/models/awesome_shop_item_id.dart';

enum AwesomeShopItemKey {
  ada('ada'),
  darkMode('dark-mode'),
  germanDrive('german-drive'),
  coffeeCup('coffee-cup'),
  reset('reset'),
  musicTape('music-tape');

  const AwesomeShopItemKey(this.id);

  factory AwesomeShopItemKey.byId(String id) => switch (id) {
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

  AwesomeShopItemId toDomain() => switch (this) {
    AwesomeShopItemKey.ada => AwesomeShopItemId.ada,
    AwesomeShopItemKey.darkMode => AwesomeShopItemId.darkMode,
    AwesomeShopItemKey.germanDrive => AwesomeShopItemId.germanDrive,
    AwesomeShopItemKey.coffeeCup => AwesomeShopItemId.coffeeCup,
    AwesomeShopItemKey.reset => AwesomeShopItemId.reset,
    AwesomeShopItemKey.musicTape => AwesomeShopItemId.musicTape,
  };
}

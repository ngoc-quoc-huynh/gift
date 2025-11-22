enum ShopItemId {
  ada('ada'),
  darkMode('dark-mode'),
  germanDrive('german-drive'),
  coffeeCup('coffee-cup'),
  reset('reset'),
  musicTape('music-tape')
  ;

  const ShopItemId(this.id);

  factory ShopItemId.byId(String id) => switch (id) {
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
}

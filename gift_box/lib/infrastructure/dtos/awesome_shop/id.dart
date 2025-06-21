enum AwesomeShopItemKey {
  ada('ada'),
  darkMode('dark-mode'),
  germanDrive('german-drive'),
  coffeeCup('coffee-cup'),
  memoryPurger('memory-purger-500'),
  musicTape('music-tape');

  const AwesomeShopItemKey(this.id);

  factory AwesomeShopItemKey.byId(String id) => switch (id) {
    'ada' => ada,
    'dark-mode' => darkMode,
    'german-drive' => germanDrive,
    'coffee-cup' => coffeeCup,
    'memory-purger-500' => memoryPurger,
    'music-tape' => musicTape,
    String() => throw ArgumentError.value(
      id,
      'id',
      'No enum value with that id.',
    ),
  };

  final String id;
}

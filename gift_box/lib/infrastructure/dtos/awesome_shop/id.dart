enum AwesomeShopItemId {
  ada('ada'),
  darkMode('dark-mode'),
  germanDrive('german-drive'),
  ficsitCoffeeCup('ficsit-coffee-cup'),
  memoryPurger('memory-purger-500'),
  musicTape('music-tape');

  const AwesomeShopItemId(this.id);

  factory AwesomeShopItemId.byId(String id) => switch (id) {
    'ada' => ada,
    'dark-mode' => darkMode,
    'german-drive' => germanDrive,
    'ficsit-coffee-cup' => ficsitCoffeeCup,
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

import 'package:path/path.dart';

enum Asset {
  // Awesome shop items
  ada('awesome_shop/ada.webp'),
  coupon('awesome_shop/coupon.webp'),
  coffeeCup('awesome_shop/coffee_cup.webp'),
  darkMode('awesome_shop/dark_mode.webp'),
  germanDrive('awesome_shop/german_drive.webp'),
  musicTape('awesome_shop/music_tape.webp'),
  reset('awesome_shop/reset.webp'),

  // Rive files
  gift('rive/gift.riv')
  ,
  satisfactory('rive/satisfactory.riv');

  const Asset(this.path);

  final String path;

  static const _assetDir = 'assets';

  String call() => join(_assetDir, path);
}

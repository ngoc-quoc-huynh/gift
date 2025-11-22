import 'package:path/path.dart';

enum Asset {
  // ADA audios
  adaAudio('audios/ada/ada.mp3'),
  coffeeCupAudio('audios/ada/coffee_cup.mp3'),
  darkModeAudio('audios/ada/dark_mode.mp3'),
  germanDriveAudio('audios/ada/german_drive.mp3'),
  musicTapeAudio('audios/ada/music_tape.mp3'),
  resetAudio('audios/ada/reset.mp3'),

  // Awesome shop items
  ada('images/shop/ada.webp'),
  coupon('images/shop/coupon.webp'),
  coffeeCup('images/shop/coffee_cup.webp'),
  darkMode('images/shop/dark_mode.webp'),
  germanDrive('images/shop/german_drive.webp'),
  musicTape('images/shop/music_tape.webp'),
  reset('images/shop/reset.webp'),

  // Rive files
  gift('rive/gift.riv')
  ,
  satisfactory('rive/satisfactory.riv'),

  // Others
  launcherIcon('images/launcher_icon.webp');

  const Asset(this.path);

  final String path;

  static const _assetDir = 'assets';

  String call() => join(_assetDir, path);
}

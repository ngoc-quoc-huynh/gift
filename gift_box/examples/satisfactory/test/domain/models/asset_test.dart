import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/asset.dart';

void main() {
  test(
    'call returns correctly.',
    () {
      expect(Asset.adaAudio(), 'assets/audios/ada/ada.mp3');
      expect(Asset.coffeeCupAudio(), 'assets/audios/ada/coffee_cup.mp3');
      expect(Asset.darkModeAudio(), 'assets/audios/ada/dark_mode.mp3');
      expect(Asset.germanDriveAudio(), 'assets/audios/ada/german_drive.mp3');
      expect(Asset.musicTapeAudio(), 'assets/audios/ada/music_tape.mp3');
      expect(Asset.resetAudio(), 'assets/audios/ada/reset.mp3');
      expect(Asset.ada(), 'assets/images/shop/ada.webp');
      expect(Asset.coupon(), 'assets/images/shop/coupon.webp');
      expect(Asset.coffeeCup(), 'assets/images/shop/coffee_cup.webp');
      expect(Asset.darkMode(), 'assets/images/shop/dark_mode.webp');
      expect(Asset.germanDrive(), 'assets/images/shop/german_drive.webp');
      expect(Asset.musicTape(), 'assets/images/shop/music_tape.webp');
      expect(Asset.reset(), 'assets/images/shop/reset.webp');
      expect(Asset.gift(), 'assets/rive/gift.riv');
      expect(Asset.satisfactory(), 'assets/rive/satisfactory.riv');
    },
  );
}

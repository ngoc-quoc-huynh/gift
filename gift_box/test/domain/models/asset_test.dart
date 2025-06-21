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
      expect(Asset.ada(), 'assets/awesome_shop/ada.webp');
      expect(Asset.coupon(), 'assets/awesome_shop/coupon.webp');
      expect(Asset.coffeeCup(), 'assets/awesome_shop/coffee_cup.webp');
      expect(Asset.darkMode(), 'assets/awesome_shop/dark_mode.webp');
      expect(Asset.germanDrive(), 'assets/awesome_shop/german_drive.webp');
      expect(Asset.musicTape(), 'assets/awesome_shop/music_tape.webp');
      expect(Asset.reset(), 'assets/awesome_shop/reset.webp');
      expect(Asset.gift(), 'assets/rive/gift.riv');
      expect(Asset.satisfactory(), 'assets/rive/satisfactory.riv');
    },
  );
}

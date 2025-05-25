import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/asset.dart';

void main() {
  test(
    'call returns correctly.',
    () {
      expect(Asset.ada(), 'assets/awesome_shop/ada.webp');
      expect(Asset.ficsitCoupon(), 'assets/awesome_shop/ficsit_coupon.webp');
      expect(
        Asset.ficsitCoffeeCup(),
        'assets/awesome_shop/ficsit_coffee_cup.webp',
      );
      expect(Asset.darkMode(), 'assets/awesome_shop/dark_mode.webp');
      expect(Asset.germanDrive(), 'assets/awesome_shop/german_drive.webp');
      expect(Asset.musicTape(), 'assets/awesome_shop/music_tape.webp');
      expect(Asset.reset(), 'assets/awesome_shop/reset.webp');
      expect(Asset.gift(), 'assets/rive/gift.riv');
      expect(Asset.satisfactory(), 'assets/rive/satisfactory.riv');
    },
  );
}

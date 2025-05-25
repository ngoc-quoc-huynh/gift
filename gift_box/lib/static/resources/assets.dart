import 'package:gift_box/domain/models/asset.dart';

final class Assets {
  const Assets._();

  // Awesome shop items
  static final ada = Asset('assets/awesome_shop/ada.webp');
  static final ficsitCoupon = Asset('assets/awesome_shop/ficsit_coupon.webp');
  static final ficsitCoffeeCup = Asset(
    'assets/awesome_shop/ficsit_coffee_cup.webp',
  );
  static final darkMode = Asset('assets/awesome_shop/dark_mode.webp');
  static final hardDrive = Asset('assets/awesome_shop/hard_drive.webp');
  static final musicTape = Asset('assets/awesome_shop/music_tape.webp');
  static final nobelisk = Asset('assets/awesome_shop/nobelisk.webp');

  // Rive files
  static final gift = Asset('assets/rive/gift.riv');
  static final satisfactory = Asset('assets/rive/satisfactory.riv');

  // Carousel images
  static final images = [
    Asset('assets/images/example_1.webp'),
    Asset('assets/images/example_2.webp'),
    Asset('assets/images/example_3.webp'),
    Asset('assets/images/example_4.webp'),
    Asset('assets/images/example_5.webp'),
    Asset('assets/images/example_6.webp'),
  ];
}

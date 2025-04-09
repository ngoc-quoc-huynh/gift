import 'package:gift_box/domain/models/asset.dart';

final class Assets {
  const Assets._();

  static final gift = Asset('assets/gift.riv');

  static final images = [
    Asset('assets/images/example_1.webp'),
    Asset('assets/images/example_2.webp'),
    Asset('assets/images/example_3.webp'),
    Asset('assets/images/example_4.webp'),
    Asset('assets/images/example_5.webp'),
    Asset('assets/images/example_6.webp'),
  ];
}

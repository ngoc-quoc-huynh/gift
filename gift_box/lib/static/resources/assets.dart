import 'package:gift_box/domain/models/asset.dart';

final class Assets {
  const Assets._();

  static final gift = Asset('assets/gift.riv');

  static final example1 = Asset('assets/images/example_1.webp');
  static final example2 = Asset('assets/images/example_2.webp');
  static final example3 = Asset('assets/images/example_3.webp');
  static final example4 = Asset('assets/images/example_4.webp');
  static final example5 = Asset('assets/images/example_5.webp');
  static final example6 = Asset('assets/images/example_6.webp');

  static final items = [
    example1,
    example2,
    example3,
    example4,
    example5,
    example6,
  ];
}

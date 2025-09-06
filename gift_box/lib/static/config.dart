import 'package:gift_box/domain/models/skin.dart';

final class Config {
  const Config._();

  // TODO: Adjust skin color if needed.
  static const skin = Skin.red;

  static const name = 'Quoc';

  // TODO: Adjust birthday if needed.
  static final birthday = DateTime(2025, 10, 22);

  // TODO: Adjust AID if needed, this should match the apduservice.xml.
  static const aid = 'F000000001';

  // TODO: Adjust PIN if needed.
  static const pin = 'IiSM60oL%1uDbXTqGNYT';

  static const carouselAnimationDuration = Duration(milliseconds: 500);
  static const carouselImageDuration = Duration(seconds: 5);
}

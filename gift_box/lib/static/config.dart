final class Config {
  const Config._();

  // TODO: Adjust AID if needed, this should match the apduservice.xml.
  static const aid = 'F000000001';

  // TODO: Adjust PIN if needed.
  static const pin = '1234';

  static const carouselAnimationDuration = Duration(milliseconds: 500);
  static const carouselImageDuration = Duration(seconds: 5);
}

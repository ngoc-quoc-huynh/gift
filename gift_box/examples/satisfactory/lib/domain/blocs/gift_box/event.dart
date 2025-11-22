part of 'bloc.dart';

@immutable
sealed class GiftBoxEvent {
  const GiftBoxEvent();
}

final class GiftBoxInitializeEvent extends GiftBoxEvent {
  const GiftBoxInitializeEvent();
}

final class GiftBoxOpenCorrectEvent extends GiftBoxEvent {
  const GiftBoxOpenCorrectEvent();
}

final class GiftBoxOpenWrongEvent extends GiftBoxEvent {
  const GiftBoxOpenWrongEvent();
}

final class GiftBoxIdleEvent extends GiftBoxEvent {
  const GiftBoxIdleEvent();
}

part of 'bloc.dart';

@immutable
sealed class AwesomeShopItemEvent {
  const AwesomeShopItemEvent();
}

final class AwesomeShopItemInitializeEvent extends AwesomeShopItemEvent {
  const AwesomeShopItemInitializeEvent(this.id);

  final String id;
}

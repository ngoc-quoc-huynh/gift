part of 'bloc.dart';

@immutable
sealed class ShopItemEvent {
  const ShopItemEvent();
}

final class ShopItemInitializeEvent extends ShopItemEvent {
  const ShopItemInitializeEvent(this.id);

  final String id;
}

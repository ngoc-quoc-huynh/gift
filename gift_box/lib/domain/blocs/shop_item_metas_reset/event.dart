part of 'bloc.dart';

@immutable
sealed class ShopItemMetasResetEvent {
  const ShopItemMetasResetEvent();
}

final class ShopItemMetasResetInitializeEvent extends ShopItemMetasResetEvent {
  const ShopItemMetasResetInitializeEvent();
}

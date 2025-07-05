part of 'bloc.dart';

@immutable
sealed class ShopItemMetasEvent {
  const ShopItemMetasEvent();
}

final class ShopItemMetasInitializeEvent extends ShopItemMetasEvent {
  const ShopItemMetasInitializeEvent();
}

final class ShopItemMetasBuyEvent extends ShopItemMetasEvent {
  const ShopItemMetasBuyEvent(this.id);

  final String id;
}

final class ShopItemMetasResetEvent extends ShopItemMetasEvent {
  const ShopItemMetasResetEvent();
}

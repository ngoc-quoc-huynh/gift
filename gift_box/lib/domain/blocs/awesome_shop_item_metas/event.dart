part of 'bloc.dart';

@immutable
sealed class AwesomeShopItemMetasEvent {
  const AwesomeShopItemMetasEvent();
}

final class AwesomeShopItemMetasInitializeEvent
    extends AwesomeShopItemMetasEvent {
  const AwesomeShopItemMetasInitializeEvent();
}

final class AwesomeShopItemMetasBuyEvent extends AwesomeShopItemMetasEvent {
  const AwesomeShopItemMetasBuyEvent(this.id);

  final String id;
}

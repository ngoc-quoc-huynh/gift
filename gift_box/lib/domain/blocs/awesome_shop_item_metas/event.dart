part of 'bloc.dart';

@immutable
sealed class AwesomeShopItemMetasEvent {
  const AwesomeShopItemMetasEvent();
}

final class AwesomeShopItemMetasInitializeEvent
    extends AwesomeShopItemMetasEvent {
  const AwesomeShopItemMetasInitializeEvent();
}

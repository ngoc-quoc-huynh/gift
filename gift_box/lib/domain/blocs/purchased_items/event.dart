part of 'bloc.dart';

@immutable
sealed class PurchasedItemsEvent {
  const PurchasedItemsEvent();
}

final class PurchasedItemsInitializeEvent extends PurchasedItemsEvent {
  const PurchasedItemsInitializeEvent();
}

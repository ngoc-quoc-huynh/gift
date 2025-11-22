part of 'bloc.dart';

@immutable
sealed class PurchasedItemsState extends Equatable {
  const PurchasedItemsState();

  @override
  List<Object?> get props => [];
}

final class PurchasedItemsLoadInProgress extends PurchasedItemsState {
  const PurchasedItemsLoadInProgress();
}

final class PurchasedItemsLoadOnSuccess extends PurchasedItemsState {
  const PurchasedItemsLoadOnSuccess(this.ids);

  final Set<ShopItemId> ids;

  @override
  List<Object?> get props => [ids];
}

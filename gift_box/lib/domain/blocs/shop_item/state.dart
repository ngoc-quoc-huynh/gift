part of 'bloc.dart';

@immutable
sealed class ShopItemState extends Equatable {
  const ShopItemState();

  @override
  List<Object?> get props => [];
}

final class ShopItemLoadInProgress extends ShopItemState {
  const ShopItemLoadInProgress();
}

final class ShopItemLoadOnSuccess extends ShopItemState {
  const ShopItemLoadOnSuccess(this.item);

  final ShopItem item;

  @override
  List<Object?> get props => [item];
}

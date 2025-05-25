part of 'bloc.dart';

@immutable
sealed class AwesomeShopItemState extends Equatable {
  const AwesomeShopItemState();

  @override
  List<Object?> get props => [];
}

final class AwesomeShopItemLoadInProgress extends AwesomeShopItemState {
  const AwesomeShopItemLoadInProgress();
}

final class AwesomeShopItemLoadOnSuccess extends AwesomeShopItemState {
  const AwesomeShopItemLoadOnSuccess(this.item);

  final AwesomeShopItem item;

  @override
  List<Object?> get props => [item];
}

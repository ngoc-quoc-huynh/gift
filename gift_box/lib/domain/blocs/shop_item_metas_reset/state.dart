part of 'bloc.dart';

@immutable
sealed class ShopItemMetasResetState extends Equatable {
  const ShopItemMetasResetState();

  @override
  List<Object?> get props => [];
}

final class ShopItemMetasResetInProgress extends ShopItemMetasResetState {
  const ShopItemMetasResetInProgress();
}

final class ShopItemMetasResetOnSuccess extends ShopItemMetasResetState {
  const ShopItemMetasResetOnSuccess();
}

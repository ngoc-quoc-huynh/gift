part of 'bloc.dart';

@immutable
sealed class ShopItemMetasState extends Equatable {
  const ShopItemMetasState();

  @override
  List<Object?> get props => [];
}

final class ShopItemMetasLoadInProgress extends ShopItemMetasState {
  const ShopItemMetasLoadInProgress();
}

final class ShopItemMetasLoadOnSuccess extends ShopItemMetasState {
  const ShopItemMetasLoadOnSuccess(this.metas);

  final List<ShopItemMeta> metas;

  @override
  List<Object?> get props => [metas];
}

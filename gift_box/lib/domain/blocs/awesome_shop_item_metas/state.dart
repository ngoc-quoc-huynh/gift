part of 'bloc.dart';

@immutable
sealed class AwesomeShopItemMetasState extends Equatable {
  const AwesomeShopItemMetasState();

  @override
  List<Object?> get props => [];
}

final class AwesomeShopItemMetasLoadInProgress
    extends AwesomeShopItemMetasState {
  const AwesomeShopItemMetasLoadInProgress();
}

final class AwesomeShopItemMetasLoadOnSuccess
    extends AwesomeShopItemMetasState {
  const AwesomeShopItemMetasLoadOnSuccess(this.metas);

  final List<AwesomeShopItemMeta> metas;

  @override
  List<Object?> get props => [metas];
}

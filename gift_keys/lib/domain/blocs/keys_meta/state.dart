part of 'bloc.dart';

@immutable
sealed class KeyMetasState extends Equatable {
  const KeyMetasState();

  @override
  List<Object?> get props => [];
}

final class KeyMetasInitial extends KeyMetasState {
  const KeyMetasInitial();
}

sealed class KeyMetasOperationState extends KeyMetasState {
  const KeyMetasOperationState(this.metas);

  final List<GiftKeyMeta> metas;

  @override
  List<Object?> get props => [metas];
}

final class KeyMetasLoadInProgress extends KeyMetasOperationState {
  const KeyMetasLoadInProgress(super.metas);
}

base class KeyMetasLoadOnSuccess extends KeyMetasOperationState {
  const KeyMetasLoadOnSuccess(super.metas);
}

final class KeyMetasAddOnSuccess extends KeyMetasLoadOnSuccess {
  const KeyMetasAddOnSuccess(this.index, super.metas);

  final int index;

  @override
  List<Object?> get props => [index, ...super.props];
}

final class KeyMetasUpdateOnSuccess extends KeyMetasLoadOnSuccess {
  const KeyMetasUpdateOnSuccess(this.index, super.metas);

  final int index;

  @override
  List<Object?> get props => [index, ...super.props];
}

final class KeyMetasDeleteOnSuccess extends KeyMetasLoadOnSuccess {
  const KeyMetasDeleteOnSuccess(super.metas);
}

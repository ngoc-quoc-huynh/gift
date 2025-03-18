part of 'bloc.dart';

@immutable
sealed class KeyMetasState extends Equatable {
  const KeyMetasState();

  @override
  List<Object?> get props => [];
}

final class KeyMetasLoadInProgress extends KeyMetasState {
  const KeyMetasLoadInProgress();
}

base class KeyMetasLoadOnSuccess extends KeyMetasState {
  const KeyMetasLoadOnSuccess(this.metas);

  final List<GiftKeyMeta> metas;

  @override
  List<Object?> get props => [metas];
}

final class KeyMetasAddOnSuccess extends KeyMetasLoadOnSuccess {
  const KeyMetasAddOnSuccess(this.index, super.metas);

  final int index;

  @override
  List<Object?> get props => [index, ...super.props];
}

final class KeyMetasDeleteOnSuccess extends KeyMetasLoadOnSuccess {
  const KeyMetasDeleteOnSuccess(super.metas);
}

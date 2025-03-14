part of 'bloc.dart';

@immutable
sealed class KeysState extends Equatable {
  const KeysState();

  @override
  List<Object?> get props => [];
}

final class KeysLoadInProgress extends KeysState {
  const KeysLoadInProgress();
}

base class KeysLoadOnSuccess extends KeysState {
  const KeysLoadOnSuccess(this.keys);

  final List<GiftKey> keys;

  @override
  List<Object?> get props => [keys];
}

final class KeysAddOnSuccess extends KeysLoadOnSuccess {
  const KeysAddOnSuccess(this.index, super.keys);

  final int index;

  @override
  List<Object?> get props => [index, ...super.props];
}

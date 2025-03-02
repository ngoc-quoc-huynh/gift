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

final class KeysLoadOnSuccess extends KeysState {
  const KeysLoadOnSuccess(this.keys);

  final List<GiftKey> keys;

  @override
  List<Object?> get props => [keys];
}

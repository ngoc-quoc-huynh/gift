part of 'bloc.dart';

@immutable
sealed class KeyFormState extends Equatable {
  const KeyFormState();

  @override
  List<Object?> get props => [];
}

final class KeyFormInitial extends KeyFormState {
  const KeyFormInitial();
}

final class KeyFormLoadInProgress extends KeyFormState {
  const KeyFormLoadInProgress();
}

final class KeyFormLoadOnSuccess extends KeyFormState {
  const KeyFormLoadOnSuccess(this.meta);

  final GiftKeyMeta meta;

  @override
  List<Object?> get props => [meta];
}

final class KeyFormDeleteOnSuccess extends KeyFormState {
  const KeyFormDeleteOnSuccess(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

final class KeyFormLoadOnFailure extends KeyFormState {
  const KeyFormLoadOnFailure();
}

part of 'bloc.dart';

@immutable
sealed class KeyMetasEvent extends Equatable {
  const KeyMetasEvent();

  @override
  List<Object?> get props => [];
}

final class KeyMetasInitializeEvent extends KeyMetasEvent {
  const KeyMetasInitializeEvent();
}

final class KeyMetasAddEvent extends KeyMetasEvent {
  const KeyMetasAddEvent(this.meta);

  final GiftKeyMeta meta;

  @override
  List<Object?> get props => [meta];
}

final class KeyMetasResetEvent extends KeyMetasEvent {
  const KeyMetasResetEvent();
}

final class KeyMetasDeleteEvent extends KeyMetasEvent {
  const KeyMetasDeleteEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

final class KeyMetasUpdateEvent extends KeyMetasEvent {
  const KeyMetasUpdateEvent(this.meta);

  final GiftKeyMeta meta;

  @override
  List<Object?> get props => [meta];
}

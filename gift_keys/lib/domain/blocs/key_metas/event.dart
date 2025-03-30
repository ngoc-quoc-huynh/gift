part of 'bloc.dart';

@immutable
sealed class KeyMetasEvent {
  const KeyMetasEvent();
}

final class KeyMetasInitializeEvent extends KeyMetasEvent {
  const KeyMetasInitializeEvent();
}

final class KeyMetasAddEvent extends KeyMetasEvent {
  const KeyMetasAddEvent(this.meta);

  final GiftKeyMeta meta;
}

final class KeyMetasResetEvent extends KeyMetasEvent {
  const KeyMetasResetEvent();
}

final class KeyMetasDeleteEvent extends KeyMetasEvent {
  const KeyMetasDeleteEvent(this.id);

  final int id;
}

final class KeyMetasUpdateEvent extends KeyMetasEvent {
  const KeyMetasUpdateEvent(this.meta);

  final GiftKeyMeta meta;
}

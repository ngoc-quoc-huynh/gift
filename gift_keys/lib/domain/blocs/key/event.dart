part of 'bloc.dart';

@immutable
sealed class KeysEvent {
  const KeysEvent();
}

final class KeysInitializeEvent extends KeysEvent {
  const KeysInitializeEvent();
}

final class KeysAddEvent extends KeysEvent {
  const KeysAddEvent(this.key);

  final GiftKey key;
}

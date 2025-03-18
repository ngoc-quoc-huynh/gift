part of 'bloc.dart';

@immutable
sealed class KeysEvent {
  const KeysEvent();
}

final class KeysInitializeEvent extends KeysEvent {
  const KeysInitializeEvent();
}

final class KeysAddEvent extends KeysEvent {
  const KeysAddEvent({
    required this.imagePath,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final String imagePath;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;
}

final class KeysResetEvent extends KeysEvent {
  const KeysResetEvent();
}

final class KeysDeleteEvent extends KeysEvent {
  const KeysDeleteEvent(this.id);

  final int id;
}

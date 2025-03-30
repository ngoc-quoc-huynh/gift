part of 'bloc.dart';

@immutable
sealed class KeyFormEvent {
  const KeyFormEvent();
}

final class KeyFormAddEvent extends KeyFormEvent {
  const KeyFormAddEvent({
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

final class KeyFormUpdateEvent extends KeyFormEvent {
  const KeyFormUpdateEvent({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final int id;
  final String imagePath;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;
}

final class KeyFormDeleteEvent extends KeyFormEvent {
  const KeyFormDeleteEvent(this.id);

  final int id;
}

part of 'bloc.dart';

@immutable
sealed class KeyFormEvent {
  const KeyFormEvent({
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

final class KeyFormAddEvent extends KeyFormEvent {
  const KeyFormAddEvent({
    required super.imagePath,
    required super.name,
    required super.birthday,
    required super.aid,
    required super.password,
  });
}

final class KeyFormUpdateEvent extends KeyFormEvent {
  const KeyFormUpdateEvent({
    required this.id,
    required super.imagePath,
    required super.name,
    required super.birthday,
    required super.aid,
    required super.password,
  });

  final int id;
}

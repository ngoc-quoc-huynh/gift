part of 'bloc.dart';

@immutable
sealed class KeyMetasEvent {
  const KeyMetasEvent();
}

final class KeyMetasInitializeEvent extends KeyMetasEvent {
  const KeyMetasInitializeEvent();
}

final class KeyMetasAddEvent extends KeyMetasEvent {
  const KeyMetasAddEvent({
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

final class KeyMetasResetEvent extends KeyMetasEvent {
  const KeyMetasResetEvent();
}

final class KeyMetasDeleteEvent extends KeyMetasEvent {
  const KeyMetasDeleteEvent(this.id);

  final int id;
}

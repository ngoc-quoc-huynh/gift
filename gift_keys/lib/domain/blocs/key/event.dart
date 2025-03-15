part of 'bloc.dart';

@immutable
sealed class KeyEvent {
  const KeyEvent();
}

final class KeyInitializeEvent extends KeyEvent {
  const KeyInitializeEvent();
}

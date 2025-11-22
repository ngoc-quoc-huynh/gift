part of 'bloc.dart';

@immutable
sealed class ImagesEvent {
  const ImagesEvent();
}

final class ImagesInitializeEvent extends ImagesEvent {
  const ImagesInitializeEvent();
}

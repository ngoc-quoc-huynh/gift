part of 'bloc.dart';

@immutable
sealed class AdaAudioEvent {
  const AdaAudioEvent();
}

final class AdaAudioInitializeEvent extends AdaAudioEvent {
  const AdaAudioInitializeEvent(this.id);

  final String id;
}

final class AdaAudioPlayEvent extends AdaAudioEvent {
  const AdaAudioPlayEvent();
}

final class AdaAudioMonitorPlayerStateEvent extends AdaAudioEvent {
  const AdaAudioMonitorPlayerStateEvent();
}

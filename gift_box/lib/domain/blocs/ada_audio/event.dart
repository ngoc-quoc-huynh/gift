part of 'bloc.dart';

@immutable
sealed class AdaAudioEvent {
  const AdaAudioEvent();
}

final class AdaAudioPlayUnlockEvent extends AdaAudioEvent {
  const AdaAudioPlayUnlockEvent(this.id);

  final String id;
}

final class AdaAudioPlayMainEvent extends AdaAudioEvent {
  const AdaAudioPlayMainEvent();
}

final class AdaAudioUpdateTranscript extends AdaAudioEvent {
  const AdaAudioUpdateTranscript(this.text);

  final String text;
}

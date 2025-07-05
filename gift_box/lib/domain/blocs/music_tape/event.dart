part of 'bloc.dart';

@immutable
sealed class MusicTapeEvent {
  const MusicTapeEvent();
}

final class MusicTapeInitializeEvent extends MusicTapeEvent {
  const MusicTapeInitializeEvent();
}

final class MusicTapePlayEvent extends MusicTapeEvent {
  const MusicTapePlayEvent();
}

final class MusicTapeStopEvent extends MusicTapeEvent {
  const MusicTapeStopEvent();
}

final class MusicTapeDuckVolumeEvent extends MusicTapeEvent {
  const MusicTapeDuckVolumeEvent({required this.isDucked});

  final bool isDucked;
}

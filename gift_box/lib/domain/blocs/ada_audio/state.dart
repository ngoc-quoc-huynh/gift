part of 'bloc.dart';

@immutable
sealed class AdaAudioState extends Equatable {
  const AdaAudioState();

  @override
  List<Object?> get props => [];
}

final class AdaAudioLoadInProgress extends AdaAudioState {
  const AdaAudioLoadInProgress();
}

final class AdaAudioLoadOnSuccess extends AdaAudioState {
  const AdaAudioLoadOnSuccess({
    required this.text,
    required this.audio,
  });

  final String text;
  final AdaAudio audio;

  AdaAudioLoadOnSuccess copyWith({
    String? text,
    AdaAudio? audio,
  }) => AdaAudioLoadOnSuccess(
    text: text ?? this.text,
    audio: audio ?? this.audio,
  );

  @override
  List<Object?> get props => [text, audio];
}

final class AdaAudioLoadOnComplete extends AdaAudioState {
  const AdaAudioLoadOnComplete();
}

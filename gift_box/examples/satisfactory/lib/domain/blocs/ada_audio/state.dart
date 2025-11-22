part of 'bloc.dart';

@immutable
sealed class AdaAudioState extends Equatable {
  const AdaAudioState();

  @override
  List<Object?> get props => [];
}

final class AdaAudioIdle extends AdaAudioState {
  const AdaAudioIdle();
}

final class AdaAudioPlaying extends AdaAudioState {
  const AdaAudioPlaying(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

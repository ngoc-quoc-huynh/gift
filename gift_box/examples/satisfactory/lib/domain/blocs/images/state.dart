part of 'bloc.dart';

@immutable
sealed class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object?> get props => [];
}

final class ImagesLoadInProgress extends ImagesState {
  const ImagesLoadInProgress();
}

final class ImagesLoadOnSuccess extends ImagesState {
  const ImagesLoadOnSuccess(this.paths);

  final List<String> paths;

  @override
  List<Object?> get props => [paths];
}

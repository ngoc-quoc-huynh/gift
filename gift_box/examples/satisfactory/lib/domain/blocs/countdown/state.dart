part of 'cubit.dart';

@immutable
sealed class CountdownState extends Equatable {
  const CountdownState();

  @override
  List<Object?> get props => [];
}

final class CountdownLoadInProgress extends CountdownState {
  const CountdownLoadInProgress();
}

final class CountdownRunning extends CountdownState {
  const CountdownRunning(this.remainingTime);

  final Duration remainingTime;

  @override
  List<Object?> get props => [remainingTime];
}

final class CountdownFinished extends CountdownState {
  const CountdownFinished();
}

part of 'bloc.dart';

@immutable
sealed class KeyState extends Equatable {
  const KeyState();

  @override
  List<Object?> get props => [];
}

final class KeyLoadInProgress extends KeyState {
  const KeyLoadInProgress();
}

final class KeyLoadOnSuccess extends KeyState {
  const KeyLoadOnSuccess(this.giftKey);

  final GiftKey giftKey;

  @override
  List<Object?> get props => [giftKey];
}

final class KeyLoadOnFailure extends KeyState {
  const KeyLoadOnFailure();
}

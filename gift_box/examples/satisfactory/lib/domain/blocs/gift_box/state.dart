part of 'bloc.dart';

@immutable
sealed class GiftBoxState extends Equatable {
  const GiftBoxState();

  @override
  List<Object?> get props => [];
}

final class GiftBoxIdle extends GiftBoxState {
  const GiftBoxIdle();
}

final class GiftBoxOpenOnSuccess extends GiftBoxState {
  const GiftBoxOpenOnSuccess();
}

final class GiftBoxOpenOnFailure extends GiftBoxState {
  const GiftBoxOpenOnFailure();
}

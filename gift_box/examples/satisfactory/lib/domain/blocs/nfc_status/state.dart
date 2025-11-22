part of 'bloc.dart';

@immutable
sealed class NfcStatusState extends Equatable {
  const NfcStatusState();

  @override
  List<Object?> get props => [];
}

final class NfcStatusLoadInProgress extends NfcStatusState {
  const NfcStatusLoadInProgress();
}

final class NfcStatusLoadOnSuccess extends NfcStatusState {
  const NfcStatusLoadOnSuccess({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

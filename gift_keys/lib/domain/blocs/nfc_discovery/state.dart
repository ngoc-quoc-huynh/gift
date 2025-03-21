part of 'bloc.dart';

@immutable
sealed class NfcDiscoveryState extends Equatable {
  const NfcDiscoveryState();

  @override
  List<Object?> get props => [];
}

final class NfcDiscoveryLoadInProgress extends NfcDiscoveryState {
  const NfcDiscoveryLoadInProgress();
}

final class NfcDiscoveryConnectInProgress extends NfcDiscoveryState {
  const NfcDiscoveryConnectInProgress(this.aid, this.password);

  final String aid;
  final String password;

  @override
  List<Object?> get props => [aid, password];
}

final class NfcDiscoveryConnectOnSuccess extends NfcDiscoveryConnectInProgress {
  const NfcDiscoveryConnectOnSuccess(super.aid, super.password);
}

final class NfcDiscoveryConnectOnFailure extends NfcDiscoveryConnectInProgress {
  const NfcDiscoveryConnectOnFailure(super.aid, super.password);
}

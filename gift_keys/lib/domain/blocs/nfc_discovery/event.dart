part of 'bloc.dart';

@immutable
sealed class NfcDiscoveryEvent {
  const NfcDiscoveryEvent();
}

final class NfcDiscoveryInitializeEvent extends NfcDiscoveryEvent {
  const NfcDiscoveryInitializeEvent({
    required this.aid,
    required this.password,
  });

  final String aid;
  final String password;
}

final class NfcDiscoverySendCommandEvent extends NfcDiscoveryEvent {
  const NfcDiscoverySendCommandEvent();
}

final class NfcDiscoveryPauseEvent extends NfcDiscoveryEvent {
  const NfcDiscoveryPauseEvent();
}

final class NfcDiscoveryResumeEvent extends NfcDiscoveryEvent {
  const NfcDiscoveryResumeEvent();
}

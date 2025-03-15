part of 'bloc.dart';

@immutable
sealed class NfcDiscoveryEvent {
  const NfcDiscoveryEvent();
}

final class NfcDiscoveryInitializeEvent extends NfcDiscoveryEvent {
  const NfcDiscoveryInitializeEvent();
}

final class NfcDiscoverySendCommandEvent extends NfcDiscoveryEvent {
  const NfcDiscoverySendCommandEvent();
}

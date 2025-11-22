part of 'bloc.dart';

@immutable
sealed class NfcStatusEvent {
  const NfcStatusEvent();
}

final class NfcStatusCheckEvent extends NfcStatusEvent {
  const NfcStatusCheckEvent();
}

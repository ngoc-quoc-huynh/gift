import 'package:equatable/equatable.dart';

sealed class NfcCommand extends Equatable {
  const NfcCommand(this.data);

  final String data;

  @override
  List<Object?> get props => [data];
}

final class SelectAidCommand extends NfcCommand {
  const SelectAidCommand(super.data);
}

final class VerifyPinCommand extends NfcCommand {
  const VerifyPinCommand(super.data);
}

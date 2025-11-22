import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/injector.dart';

part 'event.dart';
part 'state.dart';

final class NfcStatusBloc extends Bloc<NfcStatusEvent, NfcStatusState> {
  NfcStatusBloc() : super(const NfcStatusLoadInProgress()) {
    on<NfcStatusCheckEvent>(_onNfcStatusCheckEvent, transformer: droppable());
  }

  static final _nfcApi = Injector.instance.nfcApi;

  Future<void> _onNfcStatusCheckEvent(
    NfcStatusCheckEvent event,
    Emitter<NfcStatusState> emit,
  ) async => emit(NfcStatusLoadOnSuccess(isEnabled: await _nfcApi.isEnabled()));
}

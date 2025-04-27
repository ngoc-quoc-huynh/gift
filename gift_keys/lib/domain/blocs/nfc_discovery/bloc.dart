import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

@visibleForTesting
base mixin TestNfcDiscoveryBlocMixin implements NfcDiscoveryBloc {}

final class NfcDiscoveryBloc
    extends Bloc<NfcDiscoveryEvent, NfcDiscoveryState> {
  NfcDiscoveryBloc() : super(const NfcDiscoveryLoadInProgress()) {
    on<NfcDiscoveryInitializeEvent>(
      _onNfcDiscoveryInitializeEvent,
      transformer: droppable(),
    );
    on<NfcDiscoverySendCommandEvent>(
      _onNfcDiscoverySendCommandEvent,
      transformer: droppable(),
    );
    on<NfcDiscoveryPauseEvent>(
      _onNfcDiscoveryPauseEvent,
      transformer: droppable(),
    );
    on<NfcDiscoveryResumeEvent>(
      _onNfcDiscoveryResumeEvent,
      transformer: droppable(),
    );
  }

  static final _nfcApi = Injector.instance.nfcApi;
  @visibleForTesting
  StreamSubscription<String>? sub;

  Future<void> _onNfcDiscoveryInitializeEvent(
    NfcDiscoveryInitializeEvent event,
    Emitter<NfcDiscoveryState> emit,
  ) async {
    emit(const NfcDiscoveryLoadInProgress());

    await _cancelSub();
    emit(NfcDiscoveryConnectInProgress(event.aid, event.password));

    sub = _nfcApi.startDiscovery().listen(
      (_) => add(const NfcDiscoverySendCommandEvent()),
    );
  }

  Future<void> _onNfcDiscoverySendCommandEvent(
    NfcDiscoverySendCommandEvent event,
    Emitter<NfcDiscoveryState> emit,
  ) async {
    if (state case NfcDiscoveryConnectInProgress(:final aid, :final password)) {
      emit(NfcDiscoveryConnectInProgress(aid, password));

      final selectResponse = await _nfcApi.sendCommand(SelectAidCommand(aid));
      if (!selectResponse) {
        emit(NfcDiscoveryConnectOnFailure(aid, password));
        return;
      }

      final verifyResponse = await _nfcApi.sendCommand(
        VerifyPinCommand(password),
      );

      if (verifyResponse) {
        emit(NfcDiscoveryConnectOnSuccess(aid, password));
        await _cancelSub();
      } else {
        emit(NfcDiscoveryConnectOnFailure(aid, password));
      }
    }
  }

  void _onNfcDiscoveryPauseEvent(
    NfcDiscoveryPauseEvent event,
    Emitter<NfcDiscoveryState> emit,
  ) {
    if (state is NfcDiscoveryConnectInProgress &&
        state is! NfcDiscoveryConnectOnSuccess) {
      sub?.pause();
    }
  }

  void _onNfcDiscoveryResumeEvent(
    NfcDiscoveryResumeEvent event,
    Emitter<NfcDiscoveryState> emit,
  ) {
    if (state is NfcDiscoveryConnectInProgress &&
        state is! NfcDiscoveryConnectOnSuccess) {
      sub?.resume();
    }
  }

  Future<void> _cancelSub() async {
    await sub?.cancel();
    sub = null;
  }

  @override
  Future<void> close() async {
    await _cancelSub();
    return super.close();
  }
}

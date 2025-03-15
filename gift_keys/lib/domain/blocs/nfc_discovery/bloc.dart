import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/nfc_command.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';

final class NfcDiscoveryBloc extends Bloc<NfcDiscoveryEvent, bool?> {
  NfcDiscoveryBloc({required this.aid, required this.password}) : super(null) {
    on<NfcDiscoveryInitializeEvent>(
      _onNfcDiscoveryInitializeEvent,
      transformer: droppable(),
    );
    on<NfcDiscoverySendCommandEvent>(
      _onNfcDiscoverySendCommandEvent,
      transformer: droppable(),
    );
  }

  final String aid;
  final String password;

  static final _nfcApi = Injector.instance.nfcApi;

  StreamSubscription<String>? _sub;

  void _onNfcDiscoveryInitializeEvent(
    NfcDiscoveryInitializeEvent event,
    Emitter<bool?> emit,
  ) =>
      _sub = _nfcApi.startDiscovery().listen(
        (_) => add(const NfcDiscoverySendCommandEvent()),
      );

  Future<void> _onNfcDiscoverySendCommandEvent(
    NfcDiscoverySendCommandEvent event,
    Emitter<bool?> emit,
  ) async {
    final selectResponse = await _nfcApi.sendCommand(SelectAidCommand(aid));
    if (!selectResponse) {
      return;
    }

    final verifyResponse = await _nfcApi.sendCommand(
      VerifyPinCommand(password),
    );
    if (verifyResponse) {
      emit(true);
      await _cancelSub();
    } else {
      emit(false);
    }
  }

  Future<void> _cancelSub() async {
    await _sub?.cancel();
    _sub = null;
  }

  @override
  Future<void> close() async {
    await _cancelSub();
    return super.close();
  }
}

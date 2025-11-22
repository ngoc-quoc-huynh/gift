import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/gift_box.dart';
import 'package:gift_box_satisfactory/injector.dart';

part 'event.dart';
part 'state.dart';

final class GiftBoxBloc extends Bloc<GiftBoxEvent, GiftBoxState> {
  GiftBoxBloc({required this.aid, required this.pin})
    : super(const GiftBoxIdle()) {
    on<GiftBoxInitializeEvent>(
      _onGiftBoxInitializeEvent,
      transformer: droppable(),
    );
    on<GiftBoxOpenCorrectEvent>(
      _onGiftBoxOpenCorrectEvent,
      transformer: droppable(),
    );
    on<GiftBoxOpenWrongEvent>(
      _onGiftBoxOpenWrongEvent,
      transformer: droppable(),
    );
    on<GiftBoxIdleEvent>(_onGiftBoxIdleEvent, transformer: droppable());
  }

  final Uint8List aid;
  final Uint8List pin;
  StreamSubscription<NfcStatus>? _sub;
  static final _nfcApi = Injector.instance.nfcApi;

  void _onGiftBoxInitializeEvent(
    GiftBoxInitializeEvent event,
    Emitter<GiftBoxState> emit,
  ) => _sub = _nfcApi
      .startEmulation(aid, pin)
      .listen(
        (status) => switch (status) {
          NfcStatus.error => add(const GiftBoxOpenWrongEvent()),
          NfcStatus.idle => add(const GiftBoxIdleEvent()),
          NfcStatus.success => add(const GiftBoxOpenCorrectEvent()),
        },
      );

  Future<void> _onGiftBoxOpenCorrectEvent(
    GiftBoxOpenCorrectEvent event,
    Emitter<GiftBoxState> emit,
  ) async {
    await _stopEmulation();
    emit(const GiftBoxOpenOnSuccess());
    emit(const GiftBoxIdle());
  }

  void _onGiftBoxOpenWrongEvent(
    GiftBoxOpenWrongEvent event,
    Emitter<GiftBoxState> emit,
  ) {
    emit(const GiftBoxOpenOnFailure());
    emit(const GiftBoxIdle());
  }

  void _onGiftBoxIdleEvent(
    GiftBoxIdleEvent event,
    Emitter<GiftBoxState> emit,
  ) => emit(const GiftBoxIdle());

  Future<void> _stopEmulation() async {
    await _sub?.cancel();
    _sub = null;
  }

  @override
  Future<void> close() async {
    await _stopEmulation();
    return super.close();
  }
}

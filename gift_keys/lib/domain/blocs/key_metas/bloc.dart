import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/exceptions/local_database.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

@visibleForTesting
base mixin TestKeyMetasBlocMixin implements KeyMetasBloc {}

final class KeyMetasBloc extends Bloc<KeyMetasEvent, KeyMetasState> {
  KeyMetasBloc() : super(const KeyMetasLoadInProgress()) {
    on<KeyMetasInitializeEvent>(
      _onKeyMetasInitializeEvent,
      transformer: droppable(),
    );
    on<KeyMetasAddEvent>(_onKeyMetasAddEvent, transformer: droppable());
    on<KeyMetasDeleteEvent>(_onKeyMetasDeleteEvent, transformer: droppable());
    on<KeyMetasUpdateEvent>(_onKeyMetasUpdateEvent, transformer: droppable());
    on<KeyMetasResetEvent>(_onKeyMetasResetEvent, transformer: droppable());
  }

  static final _fileApi = Injector.instance.fileApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeyMetasInitializeEvent(
    KeyMetasInitializeEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    emit(const KeyMetasLoadInProgress());

    try {
      final metas = await _localDatabaseApi.loadKeyMetas();
      emit(KeyMetasLoadOnSuccess(metas.sorted(_compareGiftKeyMetas)));
    } on LocalDatabaseException {
      emit(const KeyMetasLoadOnFailure());
    }
  }

  void _onKeyMetasAddEvent(
    KeyMetasAddEvent event,
    Emitter<KeyMetasState> emit,
  ) {
    if (state case KeyMetasOperationState(:final metas)) {
      final newMeta = event.meta;
      final insertIndex = metas.lowerBound(newMeta, _compareGiftKeyMetas);
      final newMetas = [...metas]..insert(insertIndex, newMeta);

      emit(KeyMetasAddOnSuccess(insertIndex, newMetas));
    }
  }

  void _onKeyMetasDeleteEvent(
    KeyMetasDeleteEvent event,
    Emitter<KeyMetasState> emit,
  ) {
    if (state case KeyMetasOperationState(:final metas)) {
      final id = event.id;
      emit(
        KeyMetasDeleteOnSuccess(
          List.of(metas)..removeWhere((meta) => meta.id == id),
        ),
      );
    }
  }

  void _onKeyMetasUpdateEvent(
    KeyMetasUpdateEvent event,
    Emitter<KeyMetasState> emit,
  ) {
    if (state case KeyMetasOperationState(:final metas)) {
      final newMeta = event.meta;
      final newMetas = List.of(metas)
        ..removeWhere((meta) => meta.id == newMeta.id);
      final insertIndex = newMetas.lowerBound(newMeta, _compareGiftKeyMetas);
      newMetas.insert(insertIndex, newMeta);

      emit(KeyMetasUpdateOnSuccess(insertIndex, newMetas));
    }
  }

  Future<void> _onKeyMetasResetEvent(
    KeyMetasResetEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    if (state case KeyMetasOperationState(:final metas)) {
      emit(const KeyMetasLoadInProgress());

      try {
        await Future.wait([
          _localDatabaseApi.deleteKeys(),
          _fileApi.deleteAllImages(),
        ]);

        emit(const KeyMetasLoadOnSuccess([]));
      } on LocalDatabaseException {
        emit(KeyMetasResetOnFailure(metas));
      }
    }
  }

  static int _compareGiftKeyMetas(GiftKeyMeta a, GiftKeyMeta b) {
    final dateComparison = b.birthday.compareTo(a.birthday);

    return switch (dateComparison) {
      0 => a.name.compareTo(b.name),
      _ => dateComparison,
    };
  }
}

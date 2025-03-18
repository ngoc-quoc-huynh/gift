import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/key_meta.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

final class KeyMetasBloc extends Bloc<KeyMetasEvent, KeyMetasState> {
  KeyMetasBloc() : super(const KeyMetasLoadInProgress()) {
    on<KeyMetasInitializeEvent>(
      _onKeyMetasInitializeEvent,
      transformer: droppable(),
    );
    on<KeyMetasAddEvent>(_onKeyMetasAddEvent, transformer: droppable());
    on<KeyMetasResetEvent>(_onKeyMetasResetEvent, transformer: droppable());
    on<KeyMetasDeleteEvent>(_onKeyMetasDeleteEvent, transformer: droppable());
  }

  static final _fileApi = Injector.instance.fileApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeyMetasInitializeEvent(
    KeyMetasInitializeEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    await _localDatabaseApi.initialize();
    final metas = await _localDatabaseApi.loadKeyMetas();
    emit(KeyMetasLoadOnSuccess(metas));
  }

  Future<void> _onKeyMetasAddEvent(
    KeyMetasAddEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    if (state case KeyMetasLoadOnSuccess(metas: final metas)) {
      final newMeta = await _localDatabaseApi.saveKey(
        name: event.name,
        birthday: event.birthday,
        aid: event.aid,
        password: event.password,
      );
      await _fileApi.moveFileToAppDir(event.imagePath, newMeta.id);

      final insertIndex = metas.lowerBound(newMeta, _compareGiftKeyMetas);
      final newMetas = [...metas]..insert(insertIndex, newMeta);

      emit(KeyMetasAddOnSuccess(insertIndex, newMetas));
    }
  }

  Future<void> _onKeyMetasResetEvent(
    KeyMetasResetEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    emit(const KeyMetasLoadInProgress());
    await Future.wait([
      _fileApi.deleteAllImages(),
      _localDatabaseApi.deleteKeys(),
    ]);
    emit(const KeyMetasLoadOnSuccess([]));
  }

  Future<void> _onKeyMetasDeleteEvent(
    KeyMetasDeleteEvent event,
    Emitter<KeyMetasState> emit,
  ) async {
    if (state case KeyMetasLoadOnSuccess(metas: final metas)) {
      final id = event.id;
      emit(
        KeyMetasDeleteOnSuccess(
          List.of(metas)..removeWhere((meta) => meta.id == id),
        ),
      );
      await _localDatabaseApi.deleteKey(id);
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

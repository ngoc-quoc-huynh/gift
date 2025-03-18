import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_keys/domain/models/date_time_format.dart';
import 'package:gift_keys/domain/models/key.dart';
import 'package:gift_keys/domain/utils/extensions/date_time.dart';
import 'package:gift_keys/injector.dart';

part 'event.dart';
part 'state.dart';

final class KeysBloc extends Bloc<KeysEvent, KeysState> {
  KeysBloc() : super(const KeysLoadInProgress()) {
    on<KeysInitializeEvent>(_onKeysInitializeEvent, transformer: droppable());
    on<KeysAddEvent>(_onKeysAddEvent, transformer: droppable());
    on<KeysResetEvent>(_onKeysResetEvent, transformer: droppable());
    on<KeysDeleteEvent>(_onKeysDeleteEvent, transformer: droppable());
  }

  static final _fileApi = Injector.instance.fileApi;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  Future<void> _onKeysInitializeEvent(
    KeysInitializeEvent event,
    Emitter<KeysState> emit,
  ) async {
    await _localDatabaseApi.initialize();
    final keys = await _localDatabaseApi.loadKeys();
    emit(KeysLoadOnSuccess(keys));
  }

  Future<void> _onKeysAddEvent(
    KeysAddEvent event,
    Emitter<KeysState> emit,
  ) async {
    if (state case KeysLoadOnSuccess(:final keys)) {
      final imageFileName =
          '${event.name}_'
          '${event.birthday.format(DateTimeFormat.compact)}.webp';
      final [_, newKey] = await Future.wait([
        _fileApi.moveFileToAppDir(event.imagePath, imageFileName),
        _localDatabaseApi.saveKey(
          imageFileName: imageFileName,
          name: event.name,
          birthday: event.birthday,
          aid: event.aid,
          password: event.password,
        ),
      ]);
      newKey as GiftKey;

      final insertIndex = keys.lowerBound(newKey, _compareGiftKeys);
      final newKeys = [...keys]..insert(insertIndex, newKey);

      emit(KeysAddOnSuccess(insertIndex, newKeys));
    }
  }

  Future<void> _onKeysResetEvent(
    KeysResetEvent event,
    Emitter<KeysState> emit,
  ) async {
    emit(const KeysLoadInProgress());
    await Future.wait([
      _fileApi.deleteAllImages(),
      _localDatabaseApi.deleteKeys(),
    ]);
    emit(const KeysLoadOnSuccess([]));
  }

  Future<void> _onKeysDeleteEvent(
    KeysDeleteEvent event,
    Emitter<KeysState> emit,
  ) async {
    if (state case KeysLoadOnSuccess(:final keys)) {
      final id = event.id;
      emit(
        KeysDeleteOnSuccess(List.of(keys)..removeWhere((key) => key.id == id)),
      );
      await _localDatabaseApi.deleteKey(id);
    }
  }

  static int _compareGiftKeys(GiftKey a, GiftKey b) {
    final dateComparison = b.birthday.compareTo(a.birthday);

    return switch (dateComparison) {
      0 => a.name.compareTo(b.name),
      _ => dateComparison,
    };
  }
}
